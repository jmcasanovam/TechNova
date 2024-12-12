class Tareaplantilla {

  int _idTareaPlantilla = 0;
  String _titulo = "";
  String _descripcion = "";
  int _idPasos = 0;

  Tareaplantilla({String titulo = "", String descripcion = "", int idPasos = 0})
      : _titulo = titulo,
        _descripcion = descripcion,
        _idPasos = idPasos;

  Tareaplantilla.fromJson(Map<String, dynamic> json) {
    _idTareaPlantilla = json['idTareaPlantilla'];
    _titulo = json['titulo'];
    _descripcion = json['descripcion'];
    _idPasos = json['idPasos'];
  }

  toJson() {
    return {
      'idTareaPlantilla': _idTareaPlantilla,
      'titulo': _titulo,
      'descripcion': _descripcion,
      'idPasos': _idPasos
    };
  }

}