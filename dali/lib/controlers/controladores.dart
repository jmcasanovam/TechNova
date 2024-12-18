import 'dart:convert';
import 'package:dali/models/pasos.dart';
import 'package:dali/models/tareaAsignada.dart';
import 'package:dali/models/tareaAsignada2.dart';
import 'package:dali/models/tareaPlantilla.dart';
import 'package:dali/models/usuario.dart';
import 'package:http/http.dart' as http;

class Controladores {
  // String _url_cabeza = "http://192.168.1.149:5000";
  String _url_cabeza = "http://127.0.0.1:5000";

  Future<int> login(String username, String password) async {
    final url = Uri.parse('$_url_cabeza/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'nickname': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Inicio de sesión exitoso. Token: ${data['token']}');
      // Guarda el token para futuras solicitudes
      return 200;
    } else {
      final error = jsonDecode(response.body);
      print('Error: ${error['error']}');
      return response.statusCode;
    }
  }

  Future<bool> login_estudiante(String nickname, String password) async {
    final url = Uri.parse(
        '$_url_cabeza/login_estudiante'); // Cambia por la URL de tu API
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'nickname': nickname, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Inicio de sesión exitoso. ID Usuario: ${data['idUsuario']}');
        // Guarda el ID Usuario o cualquier dato necesario
        return true;
      } else {
        final error = jsonDecode(response.body);
        print('Error: ${error['error']}');
        return false;
      }
    } catch (e) {
      print('Error de conexión: $e');
      return false; // Código genérico para errores de conexión
    }
  }

  Future<List<TareaAsignada>> obtenerTareas(String username) async {
    final url =
        Uri.parse('$_url_cabeza/get_tareas' + "?idAlumno=" + username);
    final response = await http.get(url);

    List<TareaAsignada> tareas = [];
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (var tarea in data['tareas']) {
        TareaAsignada nuevaTarea = TareaAsignada.fromJson(tarea);
        tareas.add(nuevaTarea);
      }
      return tareas;
    } else {
      final error = jsonDecode(response.body);
      print('Error: ${error['error']}');
      return tareas;
    }
  }

//foto de perfil?
  Future<List<Map<String, String>>> getEstudiantesNicknameyPerfil() async {
    final url = Uri.parse(
        '$_url_cabeza/get_estudiantes_foto_nickname'); // Ajusta el endpoint según tu API

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data =
            jsonDecode(response.body); // Decodifica la lista de estudiantes
        print('Estudiantes encontrados: ${data.length}');

        // Mapear los datos recibidos en una lista de mapas
        return data.map<Map<String, String>>((estudiante) {
          return {
            'nickname': estudiante[
                'nickname'], // Ajusta según los campos de tu respuesta
            'rutaImagenPerfil': estudiante[
                'rutaImagenPerfil'], // Ajusta según los campos de tu respuesta
          };
        }).toList();
      } else {
        final error = jsonDecode(response.body);
        print('Error: ${error['error']}');
        return [];
      }
    } catch (e) {
      print('Error al realizar la solicitud: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>?> getInfoEstudiante(String nickname) async {
    // URL del endpoint en tu backend
    final url = Uri.parse('$_url_cabeza/get_estudiante');

    try {
      // Realiza la solicitud POST enviando el nickname en el cuerpo
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'nickname': nickname}),
      );

      // Verifica si la solicitud fue exitosa
      if (response.statusCode == 200) {
        // Decodifica la respuesta JSON
        final data = jsonDecode(response.body);
        print('Información del estudiante cargada con éxito.');
        return data; // Retorna la información como un mapa
      } else {
        // Maneja errores con códigos HTTP distintos de 200
        final error = jsonDecode(response.body);
        print('Error: ${error['error']}');
        return null;
      }
    } catch (e) {
      // Maneja errores generales de conexión o excepciones
      print('Error al realizar la solicitud: $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getTareasCompletadasPorDia(
      String nickname) async {
    final url = Uri.parse(
        '$_url_cabeza/get_tareas_completadas'); // Ajusta el endpoint de tu API

    try {
      // Realiza una solicitud POST enviando el nickname
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'nickname': nickname}),
      );

      // Si la solicitud es exitosa (HTTP 200)
      if (response.statusCode == 200) {
        // Decodifica la respuesta JSON
        final data = jsonDecode(response.body);
        print('Tareas completadas encontradas: ${data.length}');
        return List<Map<String, dynamic>>.from(
            data); // Retorna la lista de tareas como un mapa
      } else {
        // Manejo de errores según la respuesta del servidor
        final error = jsonDecode(response.body);
        print('Error: ${error['error']}');
        return [];
      }
    } catch (e) {
      // Manejo de excepciones de conexión u otros errores
      print('Error al realizar la solicitud: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getTareasAsignadasPorHoy(
      String nickname) async {
    final url =
        Uri.parse('$_url_cabeza/get_tareas_hoy'); // Ajusta el endpoint

    try {
      // Realiza la solicitud POST con el nickname
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'nickname': nickname}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Tareas asignadas encontradas: ${data.length}');
        return List<Map<String, dynamic>>.from(
            data); // Retorna la lista de tareas
      } else {
        final error = jsonDecode(response.body);
        print('Error: ${error['error']}');
        return [];
      }
    } catch (e) {
      print('Error al realizar la solicitud: $e');
      return [];
    }
  }

// Función para cargar el listado de estudiantes a partir del nickname para el ADMIN desde la API
  Future<List<Map<String, dynamic>>> getEstudiantesPorNickname(
      String nickname) async {
    // Construir la URL con el parámetro de consulta (query string)
    final url =
        Uri.parse('$_url_cabeza/get_admin_estudiantes/$nickname');

    try {
      // Realiza la solicitud GET
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Estudiantes encontrados: ${data.length}');
        return List<Map<String, dynamic>>.from(
            data); // Retorna la lista de estudiantes
      } else {
        final error = jsonDecode(response.body);
        print('Error: ${error['error']}');
        return [];
      }
    } catch (e) {
      print('Error al realizar la solicitud: $e');
      return [];
    }
  }

// Función para cargar el listado de tareas a partir del nickname para el ADMIN desde la API
  Future<List<Map<String, dynamic>>> getTareasPorNickname(
      String nickname) async {
    final url = Uri.parse(
        '$_url_cabeza/get_tareas_estudiante/$nickname'); // Usar localhost para emuladores

    try {
      final response = await http.get(url);

      print(
          'Respuesta recibida: ${response.body}'); // Imprimir la respuesta para depuración

      // Verificar si la solicitud fue exitosa
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print('Datos decodificados: $data'); // Ver los datos decodificados

        // Acceder a las tareas para el nickname dado
        if (data.containsKey(nickname)) {
          var tareasList = data[nickname] as List;

          // Imprimir las tareas obtenidas para depuración
          print('Tareas para $nickname: $tareasList');

          return List<Map<String, dynamic>>.from(tareasList);
        } else {
          print('No se encontraron tareas para el nickname $nickname');
          return []; // Devolver una lista vacía si no hay tareas
        }
      } else {
        print('Error en la respuesta: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error al realizar la solicitud: $e');
      return [];
    }
  }

// Función para cargar actualizar un perfil para el ADMIN
  Future<bool> actualizarPerfilPorNickname(
      String nickname, Map<String, dynamic> datosActualizados) async {
    final url = Uri.parse(
        '$_url_cabeza/update_usuario/$nickname'); // Ajusta la URL al endpoint correspondiente

    try {
      // Realiza la solicitud PUT con el nickname y los nuevos datos
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(datosActualizados), // Enviamos los datos actualizados
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Perfil actualizado con éxito: $data');
        return true; // Si la actualización fue exitosa
      } else {
        final error = jsonDecode(response.body);
        print('Error: ${error['error']}');
        return false; // Si la actualización falló
      }
    } catch (e) {
      print('Error al realizar la solicitud: $e');
      return false; // En caso de error en la solicitud
    }
  }

// Función para cargar todas las tareasPlantilla para el ADMIN
  Future<List<Map<String, dynamic>>> cargarTareasPlantilla() async {
    final url = Uri.parse(
        '$_url_cabeza/get_tareas_plantilla'); // Asegúrate de que la URL es correcta

    try {
      // Realiza la solicitud GET
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body); // Esto es un Map

        // Acceder a la clave 'tareasPlantilla' que contiene la lista de tareas
        List<Map<String, dynamic>> tareas =
            List<Map<String, dynamic>>.from(data['tareasPlantilla']);

        print('Tareas cargadas: ${tareas.length}');
        return tareas; // Retorna las tareas con solo nombre y descripción
      } else {
        final error = jsonDecode(response.body);
        print('Error: ${error['error']}');
        return [];
      }
    } catch (e) {
      print('Error al realizar la solicitud: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> cargarNicknamesEstudiantes() async {
    final url = Uri.parse(
        '$_url_cabeza/get_admin_estudiantes'); // Ajusta la URL si es necesario

    try {
      // Realiza la solicitud GET
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Decodificar la respuesta JSON
        final Map<String, dynamic> data = jsonDecode(response.body);

        // Convertir el JSON en una lista de mapas
        List<Map<String, dynamic>> estudiantes = data.entries.map((entry) {
          return {
            'estudiante': entry.key,
            'nickname': entry.value,
          };
        }).toList();

        print('Estudiantes cargados: ${estudiantes.length}');
        return estudiantes;
      } else {
        // Manejo de errores del servidor
        final error = jsonDecode(response.body);
        print('Error del servidor: ${error['error']}');
        return [];
      }
    } catch (e) {
      // Manejo de errores de red o de la solicitud
      print('Error al realizar la solicitud: $e');
      return [];
    }
  }

// Función para cargar todos los nombres y nickname de los estudiantes para el ADMIN
  Future<List<Map<String, dynamic>>> cargarAlumnos() async {
    final url = Uri.parse(
        '$_url_cabeza/get_nombre_nickname_estudiantes'); // Asegúrate de que la URL es correcta

    try {
      // Realiza la solicitud GET
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body); // Esto es un Map

        // Acceder a la clave 'estudiantes' que contiene la lista de estudiantes
        List<Map<String, dynamic>> estudiantes =
            List<Map<String, dynamic>>.from(data['estudiantes']);

        print('Estudiantes cargados: ${estudiantes.length}');
        return estudiantes; // Retorna los estudiantes con solo nombre, nickname y idEstudiante
      } else {
        final error = jsonDecode(response.body);
        print('Error: ${error['error']}');
        return [];
      }
    } catch (e) {
      print('Error al realizar la solicitud: $e');
      return [];
    }
  }

// Función para asignar una tarea por el ADMIN
  Future<bool> asignarTarea(
      int idEstudiante,
      int idTareaPlantilla,
      int completada,
      String formato,
      String fechaAsignacion,
      String fechaExpiracion,
      String fotoResultado,
      String valoracion,
      String miniatura) async {
    final url = Uri.parse(
        '$_url_cabeza/asignar_tarea'); // Asegúrate de que la URL es correcta

    try {
      // Realiza la solicitud POST
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          //'idTareaAsignada': idTareaAsignada,
          'idEstudiante': idEstudiante,
          'idTareaPlantilla': idTareaPlantilla,
          'completada': completada,
          'formato': formato,
          'fechaAsignacion': fechaAsignacion,
          'fechaExpiracion': fechaExpiracion,
          'fotoResultado': fotoResultado,
          'valoracion': valoracion,
          'miniatura': miniatura,
          'fechaCompletada': null,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['message'] == 'Tarea asignada exitosamente') {
          print('Tarea asignada con éxito');
          return true; // Retorna true si la tarea se asignó con éxito
        } else {
          print('Error al asignar tarea: ${data['error']}');
          return false; // Retorna false si hubo un error
        }
      } else {
        final error = jsonDecode(response.body);
        print('Error: ${error['error']}');
        return false;
      }
    } catch (e) {
      print('Error al realizar la solicitud: $e');
      return false;
    }
  }

// Función para crear un estudiante
  Future<Map<String, dynamic>> crearEstudiante(
      Map<String, dynamic> data) async {
    final url = Uri.parse('$_url_cabeza/crear_estudiante');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al crear estudiante: ${response.body}');
    }
  }

  Future<List<Map<String, dynamic>>> cargarMenu() async {
    final url = Uri.parse(
        '$_url_cabeza/get_menu'); // Asegúrate de que la URL es correcta

    try {
      // Realiza la solicitud GET
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Asumimos que el API devuelve una lista de menús
        List<Map<String, dynamic>> menu = [];
        for (var item in data) {
          menu.add({
            'idMenu': item['idMenu'], // ID del menú
            'archivoMenus': item['archivoMenus'], // Nombre del archivo
            'fechaMenu': item['fechaMenu'], // Fecha del menú
          });
        }
        print('Menús cargados: ${menu.length}');
        return menu; // Retorna la lista de menús
      } else {
        final error = jsonDecode(response.body);
        print('Error: ${error['error']}');
        return [];
      }
    } catch (e) {
      print('Error al realizar la solicitud: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> cargarMenuPorFecha(String fecha) async {
    // Convertir la fecha de dd/mm/yyyy a yyyy-mm-dd
    try {
      final partesFecha = fecha.split('/');
      if (partesFecha.length != 3) {
        throw FormatException(
            'Formato de fecha incorrecto. Debe ser dd/mm/yyyy');
      }
      final fechaFormatoApi =
          '${partesFecha[2]}-${partesFecha[1]}-${partesFecha[0]}';

      // Construir la URL con el parámetro de fecha
      final url = Uri.parse(
          '$_url_cabeza/get_menu?fechaMenu=$fechaFormatoApi');

      // Realiza la solicitud GET
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Asumimos que el API devuelve una lista de menús
        List<Map<String, dynamic>> menu = [];
        for (var item in data) {
          menu.add({
            'idMenu': item['idMenu'], // ID del menú
            'nombre del menu': item['nombreMenu'], // Nombre del archivo
          });
        }
        print('Menús cargados: ${menu.length}');
        return menu; // Retorna la lista de menús
      } else {
        final error = jsonDecode(response.body);
        print('Error: ${error['error']}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<String?> consultarPdfMenu(String nombreMenu) async {
    // Asegúrate de que el nombre del menú no esté vacío
    if (nombreMenu.isEmpty) {
      print("El nombre del menú es requerido.");
      return null;
    }

    try {
      // Construir la URL con el parámetro nombreMenu
      final url = Uri.parse('$_url_cabeza/get_menu_pdf/');

      // Realiza la solicitud GET con el nombre del menú en el cuerpo (JSON)
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
      });

      // Verificar si la respuesta fue exitosa
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Retorna el archivo del menú (PDF)
        return data['archivoMenu'];
      } else if (response.statusCode == 404) {
        // En caso de no encontrar el menú
        final error = jsonDecode(response.body);
        print('Error: ${error['error']}');
        return null;
      } else {
        // Otro tipo de error
        print('Error desconocido: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Si hay un error en la solicitud
      print('Error al realizar la solicitud: $e');
      return null;
    }
  }

  // Función para crear un administrador en la base de datos
  Future<Map<String, dynamic>> crearAdministrador(
      Map<String, dynamic> data) async {
    final url = Uri.parse('$_url_cabeza/crear_administrador');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al crear administrador: ${response.body}');
    }
  }

// Función para crear un educador en la base de datos
  Future<Map<String, dynamic>> crearEducador(Map<String, dynamic> data) async {
    final url = Uri.parse('$_url_cabeza/crear_educador');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al crear educador: ${response.body}');
    }
  }

  Future<int> obtenerCantidadMenus(String fecha) async {
    final url = Uri.parse(
        '$_url_cabeza/get_menu_count/?fecha=$fecha'); // URL con el parámetro fecha como query string

    try {
      // Realiza la solicitud GET
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Cantidad de menús: ${data['cantidad_menus']}');
        return data['cantidad_menus']; // Retorna la cantidad de menús
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return 0; // Si hay error, retorna 0 como cantidad de menús
      }
    } catch (e) {
      print('Error al realizar la solicitud: $e');
      return 0; // Retorna 0 si ocurre algún error inesperado
    }
  }

  Future<bool> editarPerfilAlumno(
      String nickname, Map<String, dynamic> datosActualizados) async {
    final url = Uri.parse(
        '$_url_cabeza/editar_perfil_alumno'); // Ruta sin el nickname en la URL

    try {
      // Agregar el nickname al cuerpo de los datos
      datosActualizados['nickname'] = nickname;

      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(datosActualizados), // Enviamos los datos actualizados
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Perfil del alumno actualizado con éxito: $data');
        return true; // Si la actualización fue exitosa
      } else {
        final error = jsonDecode(response.body);
        print('Error: ${error['error']}');
        return false; // Si la actualización falló
      }
    } catch (e) {
      print('Error al realizar la solicitud: $e');
      return false; // En caso de error en la solicitud
    }
  }

  Future<List<TareaAsignada>> obtenerTareasNoCompletadas(
      String nickname) async {
    final url = Uri.parse(
        '$_url_cabeza/get_tareas_no_completadas/?nickname=$nickname');

    // Hacer la solicitud GET
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> tareasData = data['tareas_no_completadas'] ?? [];

      // Convertir la respuesta en objetos TareaAsignada
      return tareasData.map((tarea) {
        return TareaAsignada(
          tarea['idTareaPlantilla'] ?? 0,
          tarea['titulo'] ?? 'Tarea sin nombre',
          tarea['descripcion'] ?? 'sin miniatura',
          tarea['miniatura'] ?? 'desconocido',
        );
      }).toList();
    } else {
      throw Exception('Error en la solicitud: ${response.statusCode}');
    }
  }

  // Función para crear una tarea plantilla
  Future<int> crearTareaPlantilla(Tareaplantilla tareaplantilla, Pasos pasos) async {
    final url = Uri.parse('$_url_cabeza/tarea_plantilla');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: 
    jsonEncode({
      'tareaPlantilla': tareaplantilla.toJson(),
      'pasos': pasos.toJson(),
    })
    );

    if (response.statusCode == 201) {
      return 201;
    } else {
      throw Exception('Error al crear tarea plantilla: ${response.body}');
    }
  }

  // Función para borrar una tarea plantilla
  Future<int> borrarTareaPlantilla(int idTareaPlantilla) async {
    final url = Uri.parse('$_url_cabeza/borrar_tarea_plantilla');
    final response = await http.delete(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'idTareaPlantilla': idTareaPlantilla}),
    );

    if (response.statusCode == 200) {
      return 200;
    } else {
      throw Exception('Error al borrar tarea plantilla: ${response.body}');
    }

  }


  Future<List<TareaAsignada>> obtenerTareasFechaExpiracion(String nickname) async {
  final url = Uri.parse('$_url_cabeza/get_tareas_fechaExpiracion/$nickname');

  // Hacer la solicitud GET
  final response = await http.get(
    url,
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final List<dynamic> tareasData = data[nickname] ?? [];

    // Convertir la respuesta en objetos Tarea
    return tareasData.map<TareaAsignada>((tarea) {
      return TareaAsignada.fromJson(tarea);
    }).toList();
  } else {
    throw Exception('Error en la solicitud: ${response.statusCode}');
  }
}

 Future<List<TareaAsignada>> obtenerTareasMiniaturaTituloFechaCompletada(String nickname) async {
  try {
    // Realizar la solicitud GET a la API
    final response = await http.get(
      Uri.parse('$_url_cabeza/get_tareas_miniatura_titulo_fechas/$nickname'),
    );

    if (response.statusCode == 200) {
      // Decodificar el cuerpo de la respuesta
      final Map<String, dynamic> data = json.decode(response.body);

      // Verificar si el nickname tiene tareas asignadas
      if (data.containsKey(nickname)) {
        final List<dynamic> tareasJson = data[nickname];

        // Convertir la lista JSON en una lista de objetos TareaAsignada
        List<TareaAsignada> tareas = tareasJson
            .map((tareaJson) => TareaAsignada.fromJson(tareaJson))
            .toList();

        return tareas;
      } else {
        throw Exception('No se encontraron tareas para el nickname $nickname.');
      }
    } else {
      throw Exception('Error al cargar las tareas: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error en la solicitud: $e');
  }
}

  // Función para obtener una tarea plantilla por su ID
  Future<Tareaplantilla> getTareaPlantilla(String idTareaPlantilla) async {
    final url = Uri.parse(
        '$_url_cabeza/consultar_tarea_plantilla?idTareaPlantilla=$idTareaPlantilla');
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      try {
        final tareaPlantilla = Tareaplantilla.fromJson(data);
        // print("Tarea plantilla cargada correctamente:");
        // print("Título: ${tareaPlantilla.titulo}");
        // tareaPlantilla.imprimir();
        return tareaPlantilla;
      } catch (e) {
        print("Error al procesar Tareaplantilla: $e");
        throw Exception('Error al cargar la tarea plantilla: $e');
      }
    } else {
      throw Exception('Error al consultar tarea plantilla: ${response.body}');
    }
  }

  //Actualizar tarea plantilla
  Future<int> actualizarTareaPlantilla(
      Tareaplantilla tareaplantilla, Pasos pasos) async {
    final url = Uri.parse('$_url_cabeza/actualizar_tarea_plantilla');
    final response = await http.put(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'tareaPlantilla': tareaplantilla.toJson(),
          'pasos': pasos.toJson(),
        }));

    if (response.statusCode == 200) {
      return 200;
    } else {
      return 400;
    }
  }

  Future<Usuario?> getInfoEstudiante2(String nickname) async {
    // URL del endpoint en tu backend
    final url = Uri.parse('$_url_cabeza/get_info_estudiante/'+ "?nickname=" + nickname);

    try {
      
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      // Verifica si la solicitud fue exitosa
      if (response.statusCode == 200) {
        // Decodifica la respuesta JSON
        final data = jsonDecode(response.body);
        final usuario = Usuario.fromJson(data);
        return usuario;
      } else {
        // Maneja errores con códigos HTTP distintos de 200
        final error = jsonDecode(response.body);
        print('Error: ${error['error']}');
        return null;
      }
    } catch (e) {
      // Maneja errores generales de conexión o excepciones
      print('Error al realizar la solicitud: $e');
      return null;
    }
  }

  //Comprobar login de administrador y educador
  Future< Map<String?, String?>?> loginAdminEducador(String nickname, String password) async {
    final url = Uri.parse('$_url_cabeza/login_admin_profesor');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'nickname': nickname, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      Map<String?, String?> map = {
        'idUsuario': data['idUsuario'].toString(),
        'tipo': data['tipo'],
      };
      return map;
    } else {
      return null;
    }

  }

  Future<TareaAsignada2?> getTareaAsignada(int idTareaAsignada) async {
    try {
      final url = Uri.parse('$_url_cabeza/get_tarea_asignada/?idTareaAsignada=$idTareaAsignada');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final tareaAsignada = TareaAsignada2.fromJson(json);
        return tareaAsignada;
      } else {
        throw Exception('Error al cargar los datos');
      }
    } catch (e) {
      return null;
      
    }
  }

  //Marco como completada una tarea asignada
  Future<int> marcarTareaCompletada(int idTareaAsignada) async {
    final url = Uri.parse('$_url_cabeza/completar_tarea');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'idTareaAsignada': idTareaAsignada}),
    );

    if (response.statusCode == 200) {
      return 200;
    } else {
      return 400;
    }
  }

Future<bool> editarPerfilAdmin(
    String nickname, Map<String, dynamic> datosActualizados) async {
  final url = Uri.parse('$_url_cabeza/editar_perfil_admin'); // URL de tu API

  try {
    // Agregar el nickname al cuerpo de los datos
    datosActualizados['nickname'] = nickname;

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(datosActualizados), // Enviamos los datos actualizados
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Perfil del administrador actualizado con éxito: $data');
      return true; // Actualización exitosa
    } else {
      final error = jsonDecode(response.body);
      print('Error: ${error['error']}');
      return false; // Error al actualizar
    }
  } catch (e) {
    print('Error al realizar la solicitud: $e');
    return false; // Error en la solicitud
  }
}

Future<bool> editarPerfilEducador(
    String nickname, Map<String, dynamic> datosActualizados) async {
  final url = Uri.parse('$_url_cabeza/editar_perfil_educador'); // URL de tu API

  try {
    // Agregar el nickname al cuerpo de los datos
    datosActualizados['nickname'] = nickname;

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(datosActualizados), // Enviamos los datos actualizados
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Perfil del educador actualizado con éxito: $data');
      return true; // Actualización exitosa
    } else {
      final error = jsonDecode(response.body);
      print('Error: ${error['error']}');
      return false; // Error al actualizar
    }
  } catch (e) {
    print('Error al realizar la solicitud: $e');
    return false; // Error en la solicitud
  }
}

}
