
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
  [ this.idTareaAsignada = 0,
    this.titulo = "",
    this.descripcion = "d",
    this.miniatura = "images/miniatura.png",
    this.formato = "dd",
    idPasos = 0,]
   
  );

  TareaAsignada.fromJson(Map<String, dynamic> json) {
  idTareaAsignada = json['idTareaAsignada'] ?? 0; // Asignamos 0 si el valor es null
  idEstudiante = json['idEstudiante'] ?? 0; // Asignamos 0 si el valor es null
  idTareaPlantilla = json['idTareaPlantilla'] ?? 0; // Asignamos 0 si el valor es null
  completada = json['completada'] ?? 0; // Asignamos 0 si el valor es null
  formato = json['formato'] ?? ''; // Asignamos cadena vacía si el valor es null
  fechaAsignacion = json['fechaAsignacion'] != null 
      ? DateTime.parse(json['fechaAsignacion']) 
      : DateTime.now(); // Asignamos la fecha actual si el valor es null
  fechaExpiracion = json['fechaExpiracion'] != null 
      ? DateTime.parse(json['fechaExpiracion']) 
      : DateTime.now(); // Asignamos la fecha actual si el valor es null
  fotoResultado = json['fotoResultado'] ?? ''; // Asignamos cadena vacía si el valor es null
  valoracion = json['valoracion'] ?? ''; // Asignamos cadena vacía si el valor es null
  miniatura = json['miniatura'] ?? ''; // Asignamos cadena vacía si el valor es null
  fechaCompletada = json['fechaCompletada'] != null 
      ? DateTime.parse(json['fechaCompletada']) 
      : null; // Asignamos null si no existe la fecha
  _idPasos = json['_idPasos'] ?? 0; // Asignamos 0 si el valor es null
  titulo = json['titulo'] ?? ''; // Asignamos cadena vacía si el valor es null
}

  int get idPasos => _idPasos;

  Map<String, dynamic> toJson() {
    return {
      'idTareaAsignada': idTareaAsignada,
      'idEstudiante': idEstudiante,
      'idTareaPlantilla': idTareaPlantilla,
      'completada': completada,
      'formato': formato,
      'fechaAsignacion': fechaAsignacion.toIso8601String(),
      'fechaExpiracion': fechaExpiracion.toIso8601String(),
      'fotoResultado': fotoResultado,
      'valoracion': valoracion,
      'miniatura': miniatura,
      'fechaCompletada': fechaCompletada?.toIso8601String(),
      '_idPasos': _idPasos,
    };
  }

  
}


   
