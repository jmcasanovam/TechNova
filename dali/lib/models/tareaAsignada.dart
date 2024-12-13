
class TareaAsignada {
  int idTareaAsignada = 0; // ID de la tarea asignada
  int idEstudiante = 0; // ID del estudiante
  int idTareaPlantilla = 0; // ID de la plantilla de tarea
  int completada = 0; // Si la tarea está completada o no
  String formato = ""; // Formato de la tarea (ej. PDF, DOCX)
  DateTime fechaAsignacion = DateTime.now(); // Fecha de asignación de la tarea
  DateTime fechaExpiracion = DateTime.now(); // Fecha de expiración de la tarea
  String fotoResultado = ""; // URL o ruta de la foto del resultado
  String valoracion = ""; // Valoración de la tarea
  String miniatura = ""; // Miniatura de la tarea (ej. imagen o archivo)
  DateTime? fechaCompletada; // Fecha en que se completó la tarea
  String titulo = ""; // Título de la tarea
  String descripcion = ""; // Descripción de la tarea
  int _idPasos = 0;
  

  TareaAsignada(
  [ this.titulo = "",
    this.miniatura = "d",
    this.formato = "dd",
    idPasos = 0,]
   
  );

  TareaAsignada.fromJson(Map<String, dynamic> json) {
    idTareaAsignada = json['idTareaAsignada'];
    idEstudiante = json['idEstudiante'];
    idTareaPlantilla = json['idTareaPlantilla'];
    completada = json['completada'];
    formato = json['formato'];
    fechaAsignacion = DateTime.parse(json['fechaAsignacion']);
    fechaExpiracion = DateTime.parse(json['fechaExpiracion']);
    fotoResultado = json['fotoResultado'];
    valoracion = json['valoracion'];
    miniatura = json['miniatura'];
    fechaCompletada = DateTime.parse(json['fechaCompletada']);
    _idPasos = json['_idPasos'];
    titulo = json['titulo'];
  }
  

  int get idPasos => _idPasos;

  Map<String, dynamic> toJson() {
    return {
      'idTareaAsignada': idTareaAsignada,
      'idEstudiante': idEstudiante,
      'idTareaPlantilla': idTareaPlantilla,
      'completada': completada,
      'formato': formato,
      'fechaAsignacion': fechaAsignacion?.toIso8601String(),
      'fechaExpiracion': fechaExpiracion?.toIso8601String(),
      'fotoResultado': fotoResultado,
      'valoracion': valoracion,
      'miniatura': miniatura,
      'fechaCompletada': fechaCompletada?.toIso8601String(),
      '_idPasos': _idPasos,
    };
  }

  
}


   
