import 'package:dali/models/menu.dart';

class Aula {
  String _nombre;
  String _picto;
  List<Menu> _menus;
  bool _terminada = false;

  Aula(this._nombre, this._picto, this._menus);

  String get nombre => _nombre;
  String get picto => _picto;
  List<Menu> get menus => _menus;
  bool get terminada => _terminada;

  void terminar(){
    _terminada = true;
  }

  bool get_terminada(){
    return _terminada;
  }
}