class Pasos {
  int _idPasos;
  List<String> _urlVideo;
  List<String> _urlAudio;
  String _urlTexto;
  List<String> _urlImagen;
  List<String> _urlPictograma;

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
  Pasos.fromJson(Map<String, dynamic> json)
      : _idPasos = json['idPasos'],
        _urlVideo = List<String>.from(json['urlVideo']),
        _urlAudio = List<String>.from(json['urlAudio']),
        _urlTexto = json['urlTexto'] ?? "", // Manejo de valores nulos
        _urlImagen = List<String>.from(json['urlImagen']),
        _urlPictograma = List<String>.from(json['urlPictograma']);

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
