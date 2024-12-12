class Pasos {
  int _idPasos = 0;
  String _urlVideo = "";
  String _urlAudio = "";
  String _urlTexto = "";
  String _urlImagen = "";
  String _urlPictograma = "";

  Pasos({required String urlVideo, required String urlAudio, required String urlTexto, required String urlImagen, required String urlPictograma})
      : 
        _urlVideo = urlVideo,
        _urlAudio = urlAudio,
        _urlTexto = urlTexto,
        _urlImagen = urlImagen,
        _urlPictograma = urlPictograma;

  Pasos.fromJson(Map<String, dynamic> json) {
    _idPasos = json['idPasos'];
    _urlVideo = json['urlVideo'];
    _urlAudio = json['urlAudio'];
    _urlTexto = json['urlTexto'];
    _urlImagen = json['urlImagen'];
    _urlPictograma = json['urlPictograma'];
  }

  toJson() {
    return {
      'idPasos': _idPasos,
      'urlVideo': _urlVideo,
      'urlAudio': _urlAudio,
      'urlTexto': _urlTexto,
      'urlImagen': _urlImagen,
      'urlPictograma': _urlPictograma
    };
  }

}