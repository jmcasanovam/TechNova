import 'dart:convert';
import 'package:dali/models/tareaAsignada.dart';
import 'package:http/http.dart' as http;

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
  // if (response.statusCode == 200) {
  //   final data = jsonDecode(response.body);
  //   for (var tarea in data['tareas']) {
  //     TareaAsignada nuevaTarea = TareaAsignada.fromJson(tarea);
  //     tareas.add(nuevaTarea);
  //   }
  //   return tareas;
  // } else {
  //   final error = jsonDecode(response.body);
  //   print('Error: ${error['error']}');
  //   return tareas;
  // }

  // Emulando la respuesta de la API
  final data = {
    'tareas': [
      {
        'id': 1,
        'titulo': 'Tarea 1',
        'descripcion': 'Descripción de la tarea 1',
        'fechaEntrega': '2023-10-10'
      },
      {
        'id': 2,
        'titulo': 'Tarea 2',
        'descripcion': 'Descripción de la tarea 2',
        'fechaEntrega': '2023-10-15'
      },
    ]
  };

  for (var tarea in data['tareas']!) {
    TareaAsignada nuevaTarea = TareaAsignada.fromJson(tarea);
    tareas.add(nuevaTarea);
  }
  return tareas;

  


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