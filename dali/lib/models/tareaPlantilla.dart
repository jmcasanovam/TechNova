import 'package:dali/models/pasos.dart';

class Tareaplantilla {

  int _idTareaPlantilla = 0;
  String _titulo = "";
  String _descripcion = "";
  int _idPasos = 0;
  Pasos? _pasos;

  Tareaplantilla({String titulo = "", String descripcion = "", int idPasos = 0, Pasos? pasos, int idTareaPlantilla = 0})
      : _titulo = titulo,
        _descripcion = descripcion,
        _idPasos = idPasos,
        _pasos = pasos,
        _idTareaPlantilla = idTareaPlantilla;
      

  Tareaplantilla.fromJson(Map<String, dynamic> json) {
    // Asegúrate de que no sea null, asigna un valor predeterminado
    _idTareaPlantilla = json['idTareaPlantilla'] ?? int.tryParse(json['idTareaPlantilla'].toString()) ?? 0;
    _titulo = (json['titulo']).toString();
    _descripcion = (json['descripcion']).toString();
    _idPasos = json['idPasos'] ?? int.tryParse(json['idPasos'].toString()) ?? 0;

    // Verifica si 'pasos' existe en el JSON y no es null antes de crear el objeto Pasos
    if (json['pasos'] != null) {
      _pasos = Pasos.fromJson(json['pasos']);
    } else {
      _pasos = null;  // O asigna un valor por defecto si lo prefieres
    }
  }

  void imprimir(){
    print("TareaPlantilla");
    print("idTareaPlantilla: $_idTareaPlantilla");
    print("titulo: $_titulo");
    print("descripcion: $_descripcion");
    print("idPasos: $_idPasos");
    if(_pasos != null){
      _pasos!.imprimir();

    }
  }



  toJson() {
    return {
      'idTareaPlantilla': _idTareaPlantilla,
      'titulo': _titulo,
      'descripcion': _descripcion,
      'idPasos': _idPasos
    };
  }

  int get idTareaPlantilla => _idTareaPlantilla;
  String get titulo => _titulo;
  String get descripcion => _descripcion;
  int get idPasos => _idPasos;
  Pasos? get pasos => _pasos;

  set pasos(Pasos? value) {
    _pasos = value;
  }

}