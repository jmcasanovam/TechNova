import 'dart:convert';

class Pasos {
  late int _idPasos;
  late List<String> _urlVideo;
  late List<String> _urlAudio;
  late String _urlTexto;
  late List<String> _urlImagen;
  late List<String> _urlPictograma;

  // Constructor actualizado
  Pasos({
    int idPasos = 0,
    required List<String> urlVideo,
    required List<String> urlAudio,
    required String urlTexto,
    required List<String> urlImagen,
    required List<String> urlPictograma,
  })  : _idPasos = idPasos,
        _urlVideo = urlVideo,
        _urlAudio = urlAudio,
        _urlTexto = urlTexto,
        _urlImagen = urlImagen,
        _urlPictograma = urlPictograma;

  // Método para convertir el JSON en un objeto Pasos
  // Pasos.fromJson(Map<String, dynamic> json)
  //     : _idPasos = json['idPasos'],
  //       _urlVideo = List<String>.from(json['urlVideo']),
  //       _urlAudio = List<String>.from(json['urlAudio']),
  //       _urlTexto = json['urlTexto'] ?? "", // Manejo de valores nulos
  //       _urlImagen = List<String>.from(json['urlImagen']),
  //       _urlPictograma = List<String>.from(json['urlPictograma']);
  Pasos.fromJson(Map<String, dynamic> json) {
    _idPasos = json['idPasos'] ?? int.tryParse(json['idPasos'].toString()) ?? 0;

    // Convierte cadenas en listas reales usando jsonDecode
    _urlVideo = json['urlVideo'] != null
        ? List<String>.from(jsonDecode(json['urlVideo']))
        : [];
    _urlAudio = json['urlAudio'] != null
        ? List<String>.from(jsonDecode(json['urlAudio']))
        : [];
      List<dynamic> _aux = [];
      _aux = json['urlTexto'];
    _urlTexto = _aux.join(' | ');
    _urlImagen = json['urlImagen'] != null
        ? List<String>.from(jsonDecode(json['urlImagen']))
        : [];
    _urlPictograma = json['urlPictograma'] != null
        ? List<String>.from(jsonDecode(json['urlPictograma']))
        : [];
        
  }

  // Método para convertir el objeto Pasos en un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'idPasos': _idPasos,
      'urlVideo': _urlVideo,
      'urlAudio': _urlAudio,
      'urlTexto': _urlTexto,
      'urlImagen': _urlImagen,
      'urlPictograma': _urlPictograma,
    };
  }

  void imprimir(){
    print("Pasos");
    print("idPasos: $_idPasos");
    print("urlVideo: $_urlVideo");
    print("urlAudio: $_urlAudio");
    print("urlTexto: $_urlTexto");
    print("urlImagen: $_urlImagen");
    print("urlPictograma: $_urlPictograma");
  }

  // Getters y setters para acceder a los campos privados
  int get idPasos => _idPasos;
  List<String> get urlVideo => _urlVideo;
  List<String> get urlAudio => _urlAudio;
  String get urlTexto => _urlTexto;
  List<String> get urlImagen => _urlImagen;
  List<String> get urlPictograma => _urlPictograma;

  set idPasos(int value) {
    _idPasos = value;
  }

  set urlVideo(List<String> value) {
    _urlVideo = value;
  }

  set urlAudio(List<String> value) {
    _urlAudio = value;
  }

  set urlTexto(String value) {
    _urlTexto = value;
  }

  set urlImagen(List<String> value) {
    _urlImagen = value;
  }

  set urlPictograma(List<String> value) {
    _urlPictograma = value;
  }
}
