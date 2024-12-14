class Usuario {
  String _idUsuario = "";
  String _nickname = "";
  String _nombre = "";
  String _password = "";
  String _preferenciasNotificacion = "";
  String _rutaImagenPerfil="";
  String _formato = "";


  Usuario({
    required String idUsuario,
    required String nickname,
    required String nombre,
    required String password,
    required String preferenciasNotificacion,
    required String rutaImagenPerfil
  })  : _idUsuario = idUsuario,
        _nickname = nickname,
        _nombre = nombre,
        _password = password,
        _preferenciasNotificacion = preferenciasNotificacion,
        _rutaImagenPerfil = rutaImagenPerfil;

  Usuario.fromJson(Map<String, dynamic> json) {
    _idUsuario = (json['idUsuario']).toString();
    _nickname = json['nickname'];
    _nombre = json['nombre'];
    _password = json['password'];
    _preferenciasNotificacion = json['preferenciasNotificacion'];
    _rutaImagenPerfil = json['rutaImagenPerfil'];
    _formato = cambiarFormato((json['formato']).toString());

  }
  


  String cambiarFormato(String formato) {
    switch (formato) {
      case '1':
        return 'Video';
      case '2':
        return 'Audio';
      case '3':
        return 'Texto';
      case '4':
        return 'Imagen';
      case '5':
        return 'Fotograma';
      default:
        return 'Texto';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'idUsuario': _idUsuario,
      'nickname': _nickname,
      'nombre': _nombre,
      'password': _password,
      'preferenciasNotificacion': _preferenciasNotificacion,
      'rutaImagenPerfil': _rutaImagenPerfil,
      'formato': _formato,
    };
  }

  String get idUsuario => _idUsuario;
  String get nickname => _nickname;
  String get nombre => _nombre;
  String get password => _password;
  String get preferenciasNotificacion => _preferenciasNotificacion;
  String get rutaImagenPerfil => _rutaImagenPerfil;
  String get formato => _formato;

}