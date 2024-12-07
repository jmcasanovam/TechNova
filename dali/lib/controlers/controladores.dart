import 'dart:convert';
import 'package:dali/models/tareaAsignada.dart';
import 'package:http/http.dart' as http;


class Controladores {

Future<int> login(String username, String password) async {
  final url = Uri.parse('http://127.0.0.1:5000/login'); 
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

Future<List<TareaAsignada>> obtenerTareas(String username) async {
  final url = Uri.parse('http://127.0.0.1:5000/get_tareas'+"?idAlumno="+username);
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

Future<List<Map<String, String>>> getEstudiantesNicknameyPerfil() async {
  final url = Uri.parse('http://127.0.0.1:5000/get_estudiantes_foto_nickname'); // Ajusta el endpoint según tu API

  try {
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body); // Decodifica la lista de estudiantes
      print('Estudiantes encontrados: ${data.length}');

      // Mapear los datos recibidos en una lista de mapas
      return data.map<Map<String, String>>((estudiante) {
        return {
          'nickname': estudiante['nickname'], // Ajusta según los campos de tu respuesta
          'rutaImagenPerfil': estudiante['rutaImagenPerfil'], // Ajusta según los campos de tu respuesta
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
  final url = Uri.parse('http://127.0.0.1:5000/get_estudiante'); 

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



Future<List<Map<String, dynamic>>> getTareasCompletadasPorDia(String nickname) async {
  final url = Uri.parse('http://127.0.0.1:5000/get_tareas_completadas'); // Ajusta el endpoint de tu API

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
      return List<Map<String, dynamic>>.from(data); // Retorna la lista de tareas como un mapa
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

Future<List<Map<String, dynamic>>> getTareasAsignadasPorHoy(String nickname) async {
  final url = Uri.parse('http://127.0.0.1:5000/get_tareas_hoy'); // Ajusta el endpoint

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
      return List<Map<String, dynamic>>.from(data); // Retorna la lista de tareas
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
Future<List<Map<String, dynamic>>> getEstudiantesPorNickname(String nickname) async {
  // Construir la URL con el parámetro de consulta (query string)
  final url = Uri.parse('http://127.0.0.1:5000/get_admin_estudiantes/$nickname');

  try {
    // Realiza la solicitud GET
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Estudiantes encontrados: ${data.length}');
      return List<Map<String, dynamic>>.from(data); // Retorna la lista de estudiantes
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
Future<List<Map<String, dynamic>>> getTareasPorNickname(String nickname) async {
  final url = Uri.parse('http://127.0.0.1:5000/get_tareas_estudiante/$nickname'); // Usar localhost para emuladores
  
  try {
    final response = await http.get(url);
    
    print('Respuesta recibida: ${response.body}');  // Imprimir la respuesta para depuración

    // Verificar si la solicitud fue exitosa
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      print('Datos decodificados: $data');  // Ver los datos decodificados

      // Acceder a las tareas para el nickname dado
      if (data.containsKey(nickname)) {
        var tareasList = data[nickname] as List;

        // Imprimir las tareas obtenidas para depuración
        print('Tareas para $nickname: $tareasList');
        
        return List<Map<String, dynamic>>.from(tareasList);
      } else {
        print('No se encontraron tareas para el nickname $nickname');
        return [];  // Devolver una lista vacía si no hay tareas
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
Future<bool> actualizarPerfilPorNickname(String nickname, Map<String, dynamic> datosActualizados) async {
  final url = Uri.parse('http://127.0.0.1:5000/update_usuario/$nickname');  // Ajusta la URL al endpoint correspondiente

  try {
    // Realiza la solicitud PUT con el nickname y los nuevos datos
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(datosActualizados),  // Enviamos los datos actualizados
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Perfil actualizado con éxito: $data');
      return true;  // Si la actualización fue exitosa
    } else {
      final error = jsonDecode(response.body);
      print('Error: ${error['error']}');
      return false;  // Si la actualización falló
    }
  } catch (e) {
    print('Error al realizar la solicitud: $e');
    return false;  // En caso de error en la solicitud
  }
}
// Función para cargar todas las tareasPlantilla para el ADMIN
Future<List<Map<String, dynamic>>> cargarTareasPlantilla() async {
  final url = Uri.parse('http://127.0.0.1:5000/get_tareas_plantilla');  // Asegúrate de que la URL es correcta

  try {
    // Realiza la solicitud GET
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Filtrar solo nombre y descripción
      List<Map<String, dynamic>> tareas = [];
      for (var tarea in data) {
        tareas.add({
          'nombre': tarea['nombre'],  // Asumiendo que 'nombre' es el nombre de la tarea
          'descripcion': tarea['descripcion'],  // Asumiendo que 'descripcion' es la descripción de la tarea
        });
      }
      print('Tareas cargadas: ${tareas.length}');
      return tareas;  // Retorna las tareas con solo nombre y descripción
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
  final url = Uri.parse('http://127.0.0.1:5000/get_admin_estudiantes'); // Ajusta la URL si es necesario

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
  final url = Uri.parse('http://127.0.0.1:5000/get_nombre_nickname_estudiantes');  // Asegúrate de que la URL es correcta

  try {
    // Realiza la solicitud GET
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Filtrar solo nombre y nickname
      List<Map<String, dynamic>> estudiantes = [];
      for (var estudiante in data) {
        estudiantes.add({
         // 'nombre': estudiante['nombre'],  // Asumiendo que 'nombre' es el nombre del alumno
          'nickname': estudiante['nickname'],  // Asumiendo que 'nickname' es el nickname del alumno
        });
      }
      print('Estudiantes cargados: ${estudiantes.length}');
      return estudiantes;  // Retorna los alumnos con solo nombre y nickname
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
Future<bool> asignarTarea(int idTareaAsignada, int idEstudiante, int idTareaPlantilla, String completada, String formato, String fechaAsignacion, String fechaExpiracion, String fotoResultado, String valoracion, String miniatura) async {
  final url = Uri.parse('http://127.0.0.1:5000/asignar_tarea');  // Asegúrate de que la URL es correcta

  try {
    // Realiza la solicitud POST
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'idTareaAsignada': idTareaAsignada,
        'idEstudiante': idEstudiante,
        'idTareaPlantilla': idTareaPlantilla,
        'completada': completada,
        'formato': formato,
        'fechaAsignacion': fechaAsignacion,
        'fechaExpiracion': fechaExpiracion,
        'fotoResultado': fotoResultado,
        'valoracion': valoracion,
        'miniatura': miniatura,
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      if (data['message'] == 'Tarea asignada exitosamente') {
        print('Tarea asignada con éxito');
        return true;  // Retorna true si la tarea se asignó con éxito
      } else {
        print('Error al asignar tarea: ${data['error']}');
        return false;  // Retorna false si hubo un error
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
}

Future<List<Map<String, dynamic>>> cargarMenu() async {
  final url = Uri.parse('http://127.0.0.1:5000/get_menu'); // Asegúrate de que la URL es correcta

  try {
    // Realiza la solicitud GET
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Asumimos que el API devuelve una lista de menús
      List<Map<String, dynamic>> menu = [];
      for (var item in data) {
        menu.add({
          'idMenu': item['idMenu'],            // ID del menú
          'archivoMenus': item['archivoMenus'], // Nombre del archivo
          'fechaMenu': item['fechaMenu'],      // Fecha del menú
        });
      }
      print('Menús cargados: ${menu.length}');
      return menu;  // Retorna la lista de menús
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
      throw FormatException('Formato de fecha incorrecto. Debe ser dd/mm/yyyy');
    }
    final fechaFormatoApi = '${partesFecha[2]}-${partesFecha[1]}-${partesFecha[0]}';

    // Construir la URL con el parámetro de fecha
    final url = Uri.parse('http://127.0.0.1:5000/get_menu?fechaMenu=$fechaFormatoApi');

    // Realiza la solicitud GET
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Asumimos que el API devuelve una lista de menús
      List<Map<String, dynamic>> menu = [];
      for (var item in data) {
        menu.add({
          'idMenu': item['idMenu'],            // ID del menú
          'nombre del menu': item['nombreMenu'], // Nombre del archivo
        });
      }
      print('Menús cargados: ${menu.length}');
      return menu;  // Retorna la lista de menús
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
    final url = Uri.parse('http://127.0.0.1:5000/get_menu_pdf/');

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


Future<int> obtenerCantidadMenus(String fecha) async {
  final url = Uri.parse('http://127.0.0.1:5000/get_menu_count/?fecha=$fecha'); // URL con el parámetro fecha como query string

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