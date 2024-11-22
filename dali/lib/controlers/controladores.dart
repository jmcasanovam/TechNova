import 'dart:convert';
import 'package:dali/models/tareaAsignada.dart';
import 'package:http/http.dart' as http;

Future<int> login(String username, String password) async {
  final url = Uri.parse('http://127.0.0.1:5000/login'); 
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'username': username, 'password': password}),
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