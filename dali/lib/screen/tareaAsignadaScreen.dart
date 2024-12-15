import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dali/models/tareaAsignada2.dart';

class TareaAsignadaScreen extends StatefulWidget {
  final int idTareaAsignada;

  TareaAsignadaScreen({required this.idTareaAsignada});

  @override
  _TareaAsignadaScreenState createState() => _TareaAsignadaScreenState();
}

class _TareaAsignadaScreenState extends State<TareaAsignadaScreen> {
  TareaAsignada2? tareaAsignada;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTareaAsignada();
  }

  Future<void> fetchTareaAsignada() async {
    try {
      final url = Uri.parse('http://127.0.0.1:5000/get_tarea_asignada/?idTareaAsignada=${widget.idTareaAsignada}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        setState(() {
          tareaAsignada = TareaAsignada2.fromJson(json);
          isLoading = false;
        });
      } else {
        throw Exception('Error al cargar los datos');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarea Asignada'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : tareaAsignada == null
              ? Center(child: Text('No se pudo cargar la tarea asignada'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tarea Asignada #${tareaAsignada!.idTareaAsignada}',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text('Completada: ${tareaAsignada!.completada == 1 ? "Sí" : "No"}'),
                        Text('Fecha de Asignación: ${tareaAsignada!.fechaAsignacion}'),
                        Text('Fecha de Expiración: ${tareaAsignada!.fechaExpiracion}'),
                        Text('Formato: ${tareaAsignada!.formato}'),
                        if (tareaAsignada!.fotoResultado != null)
                          Image.network(tareaAsignada!.fotoResultado!),
                        Text('Estudiante ID: ${tareaAsignada!.idEstudiante}'),
                        Text('Miniatura:'),
                        Image.asset(tareaAsignada!.miniatura),
                        SizedBox(height: 10),
                        Text(
                          'Tarea Plantilla',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text('Título: ${tareaAsignada!.tareaPlantilla.titulo}'),
                        Text('Descripción: ${tareaAsignada!.tareaPlantilla.descripcion}'),
                        SizedBox(height: 10),
                        Text(
                          'Pasos',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text('URL Texto: ${tareaAsignada!.tareaPlantilla.pasos!.urlTexto}'),
                        if (tareaAsignada!.tareaPlantilla.pasos!.urlImagen != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: tareaAsignada!.tareaPlantilla.pasos!.urlImagen
                                .map<Widget>((url) => Image.network(url))
                                .toList(),
                          ),
                        SizedBox(height: 10),
                        Text(
                          'URL Video, audio y pictograma', 
                        ),
                        if (tareaAsignada!.tareaPlantilla.pasos!.urlVideo != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: tareaAsignada!.tareaPlantilla.pasos!.urlVideo
                                .map<Widget>((url) => Text('URL Video: $url'))
                                .toList(),
                          ),
                        if (tareaAsignada!.tareaPlantilla.pasos!.urlAudio != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: tareaAsignada!.tareaPlantilla.pasos!.urlAudio
                                .map<Widget>((url) => Text('URL Audio: $url'))
                                .toList(),
                          ),
                        if (tareaAsignada!.tareaPlantilla.pasos!.urlPictograma != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: tareaAsignada!.tareaPlantilla.pasos!.urlPictograma
                                .map<Widget>((url) => Text('URL Pictograma: $url'))
                                .toList(),
                          ),
                        SizedBox(height: 10),
                        if (tareaAsignada!.valoracion != null)
                          Text('Valoración: ${tareaAsignada!.valoracion}'),
                      ],
                    ),
                  ),
                ),
    );
  }
}
