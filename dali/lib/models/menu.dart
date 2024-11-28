class Menu {
  String _nombre;
  String _picto;
  int cantidad = 0;
  
  Menu(this._nombre, this._picto);

  String get nombre => _nombre;
  String get picto => _picto;

  void aumentar_cant(){
    cantidad++;
  }

  void dism_cant(){
    if(cantidad > 0)
      cantidad--;
  }

  void set_cant(int cant){
    cantidad = cant;
  }

  int get_cant(){
    return cantidad;
  }
}