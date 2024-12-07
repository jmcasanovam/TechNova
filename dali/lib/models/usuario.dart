class Usuario {
  String idUsuario = "";
  String nickname = "";
  String nombre = "";
  String password = "";
  String preferenciasNotificacion = "";
  String rutaImagenPerfil="";


  Usuario({
    required this.idUsuario,
    required this.nickname,
    required this.nombre,
    required this.password,
    required this.preferenciasNotificacion,
    required this.rutaImagenPerfil
  });

  Usuario.fromJson(Map<String, dynamic> json) {
    
      idUsuario: json['id'];
      nickname: json['nickname'];
      nombre: json['nombre'];
      password: json['password'];
      preferenciasNotificacion: json['preferenciasNotificacion'];
      rutaImagenPerfil: json['rutaImagenPerfil'];
    
  }

  Map<String, dynamic> toJson() {
    return {
      'idUsuario': idUsuario,
      'nickname': nickname,
      'nombre': nombre,
      'password': password,
      'preferenciasNotificacion': preferenciasNotificacion,
      'rutaImagenPerfil': rutaImagenPerfil,
    };
  }
}