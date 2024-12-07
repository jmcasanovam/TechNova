
class TareaAsignada {
  String _nombre = "";//titulo
  String _imagen = 'images/microondas.png';
  bool _completada = false;
  String _formato = "";
  String _descripcion = '';
  int _idPasos = 0;
  

  TareaAsignada([this._nombre = "", this._imagen = 'images/microondas.png', this._formato = "", this._idPasos = 0]);

  TareaAsignada.fromJson(Map<String, dynamic> json) {
    _nombre = json['titulo'];
    _formato = json['formato'];
    _descripcion = json['descripcion'];
    _idPasos = json['idPasos'];
    print(json['imagen']);
  }
  

  String get nombre => _nombre;
  String get imagen => _imagen;
  bool get completada => _completada;
  String get formato => _formato;


   
}