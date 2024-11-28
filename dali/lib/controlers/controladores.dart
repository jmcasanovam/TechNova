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