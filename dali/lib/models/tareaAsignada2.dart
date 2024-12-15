import 'package:dali/models/tareaPlantilla.dart';

class TareaAsignada2 {
  int completada;
  String fechaAsignacion;
  String? fechaCompletada;
  String fechaExpiracion;
  String formato;
  String? fotoResultado;
  int idEstudiante;
  int idTareaAsignada;
  String miniatura;
  Tareaplantilla tareaPlantilla;
  double? valoracion;

  TareaAsignada2({
    required this.completada,
    required this.fechaAsignacion,
    this.fechaCompletada,
    required this.fechaExpiracion,
    required this.formato,
    this.fotoResultado,
    required this.idEstudiante,
    required this.idTareaAsignada,
    required this.miniatura,
    required this.tareaPlantilla,
    this.valoracion,
  });

  factory TareaAsignada2.fromJson(Map<String, dynamic> json) {
    return TareaAsignada2(
      completada: json['completada'],
      fechaAsignacion: json['fechaAsignacion'],
      fechaCompletada: json['fechaCompletada'],
      fechaExpiracion: json['fechaExpiracion'],
      formato: json['formato'],
      fotoResultado: json['fotoResultado'],
      idEstudiante: json['idEstudiante'],
      idTareaAsignada: json['idTareaAsignada'],
      miniatura: json['miniatura'],
      tareaPlantilla: Tareaplantilla.fromJson(json['tareaPlantilla']),
      valoracion: json['valoracion'] != null ? (json['valoracion'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'completada': completada,
      'fechaAsignacion': fechaAsignacion,
      'fechaCompletada': fechaCompletada,
      'fechaExpiracion': fechaExpiracion,
      'formato': formato,
      'fotoResultado': fotoResultado,
      'idEstudiante': idEstudiante,
      'idTareaAsignada': idTareaAsignada,
      'miniatura': miniatura,
      'tareaPlantilla': tareaPlantilla.toJson(),
      'valoracion': valoracion,
    };
  }

  void imprimir() {
    print("TareaAsignada");
    print("completada: $completada");
    print("fechaAsignacion: $fechaAsignacion");
    print("fechaCompletada: $fechaCompletada");
    print("fechaExpiracion: $fechaExpiracion");
    print("formato: $formato");
    print("fotoResultado: $fotoResultado");
    print("idEstudiante: $idEstudiante");
    print("idTareaAsignada: $idTareaAsignada");
    print("miniatura: $miniatura");
    tareaPlantilla.imprimir();
    print("valoracion: $valoracion");
  }

  int get getCompletada => completada;
  String get getFechaAsignacion => fechaAsignacion;
  String? get getFechaCompletada => fechaCompletada;
  String get getFechaExpiracion => fechaExpiracion;
  String get getFormato => formato;
  String? get getFotoResultado => fotoResultado;
  int get getIdEstudiante => idEstudiante;
  int get getIdTareaAsignada => idTareaAsignada;
  String get getMiniatura => miniatura;
  Tareaplantilla get getTareaPlantilla => tareaPlantilla;
  double? get getValoracion => valoracion;

}
