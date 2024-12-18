import 'package:dali/widget/adminTitulo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dali/controlers/controladores.dart';
import '../widget/barraMenu.dart';

class AdminAsignarTareas extends StatefulWidget {
  final String admin;

  const AdminAsignarTareas({super.key, required this.admin});


  @override
  _AdminAsignarTareasState createState() => _AdminAsignarTareasState();
}

class _AdminAsignarTareasState extends State<AdminAsignarTareas> {
  final Controladores controladores = Controladores();
  int? tareaSel; // Índice de la tarea seleccionada
  int? alumnoSel; // Índice del alumno seleccionado
  String? formatoSel = 'Texto';
  int completada = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    Future<List<Map<String, dynamic>>> tareas = controladores.cargarTareasPlantilla();
        Future<List<Map<String, dynamic>>> alumnos = controladores.cargarAlumnos();
    return Scaffold(
      body: Column(
        children: [
          // Título superior
          AdminTitulo(atras: false, titulo: "Asignar Tareas"),

          // Tablas de tareas y alumnos
          Expanded(
            child: Row(
              children: [
                // Tabla de tareas
                Expanded(
  child: FutureBuilder<List<Map<String, dynamic>>>(
    future: tareas,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(fontFamily: 'Roboto', fontSize: screenHeight*0.03),));
      } else if (snapshot.hasData) {
        List<Map<String, dynamic>> tareasData = snapshot.data!;

        return ListView(
          children: [
            Table(
              border: TableBorder.all(color: Colors.grey),
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(2),
              },
              children: [
                TableRow(
                  decoration: const BoxDecoration(color: Colors.green),
                  children: [
                    _buildCell("Título", context, isHeader: true),
                    _buildCell("Descripción", context, isHeader: true),
                  ],
                ),
                ...tareasData.map((tarea) {
                  return TableRow(
                    decoration: BoxDecoration(
                      color: tareaSel == tarea["idTareaPlantilla"]
                          ? Colors.yellow
                          : Colors.white,
                    ),
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            tareaSel = tareaSel == tarea["idTareaPlantilla"]
                                ? null
                                : tarea["idTareaPlantilla"];
                          });
                        },
                        child: _buildCell(tarea["titulo"], context),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            tareaSel = tareaSel == tarea["idTareaPlantilla"]
                                ? null
                                : tarea["idTareaPlantilla"];
                          });
                        },
                        child: _buildCell(tarea["descripcion"], context),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ],
        );
      } else {
        return Center(child: Text('No hay datos disponibles.', style: TextStyle(fontFamily: 'Roboto', fontSize: screenHeight*0.03),));
      }
    },
  ),
),
              // Botón de asignar tarea
                Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    ElevatedButton(
      onPressed: (tareaSel != null && alumnoSel != null)
          ? () {
              _mostrarDialogoAsignarTarea(context);
              print(
                  "Tarea con ID $tareaSel asignada a estudiante con ID $alumnoSel.");
            }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        maximumSize: Size(screenWidth * 0.12, screenHeight * 0.08),
        minimumSize: Size(screenWidth * 0.12, screenHeight * 0.08),
        foregroundColor: Colors.black,
      ),
      child: Text(
        "Asignar Tarea",
        style: TextStyle(
          fontFamily: 'Roboto', 
          fontSize: screenHeight * 0.02,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ],
),

                // Tabla de alumnos
                Expanded(
  child: FutureBuilder<List<Map<String, dynamic>>>(
    future: alumnos,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (snapshot.hasData) {
        List<Map<String, dynamic>> alumnosData = snapshot.data!;

        return ListView(
          children: [
            Table(
              border: TableBorder.all(color: Colors.grey),
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(2),
              },
              children: [
                TableRow(
                  decoration: const BoxDecoration(color: Colors.red),
                  children: [
                    _buildCell("Nombre", context, isHeader: true),
                    _buildCell("Nickname", context, isHeader: true),
                  ],
                ),
                ...alumnosData.map((alumno) {
                  return TableRow(
                    decoration: BoxDecoration(
                      color: alumnoSel == alumno["idUsuario"]
                          ? Colors.yellow
                          : Colors.white,
                    ),
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            alumnoSel = alumnoSel == alumno["idUsuario"]
                                ? null
                                : alumno["idUsuario"];
                          });
                        },
                        child: _buildCell(alumno["nombre"], context),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            alumnoSel = alumnoSel == alumno["idUsuario"]
                                ? null
                                : alumno["idUsuario"];
                          });
                        },
                        child: _buildCell(alumno["nickname"], context),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ],
        );
      } else {
        return Center(child: Text('No hay datos disponibles.'));
      }
    },
  ),
),
              ],
            ),
          ),
        ],
      ),

      // Barra de navegación personalizada
      bottomNavigationBar: BarraMenu(selectedIndex: 2, admin: widget.admin,),
    );
  }
  void _mostrarDialogoAsignarTarea(BuildContext context) {
  DateTime? fechaAsignacion;
  DateTime? fechaFinalizacion;
  String formatoPrincipal = 'Texto';
  List<String> formatosAdicionales = [];
  List<String> opcionesFormato = ['Texto', 'Audio', 'Imagen', 'Video'];

  showDialog(
    context: context,
    builder: (BuildContext context) {
      double alto = MediaQuery.of(context).size.height;
      double ancho = MediaQuery.of(context).size.width;

      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: Text(
            'Detalles de Asignación',
            style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: alto * 0.03),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Fecha de Asignación
                Text('Fecha de Asignación:', style: TextStyle(fontFamily: 'Roboto', fontSize: alto * 0.025)),
                SizedBox(height: alto * 0.02),
                ElevatedButton(
                  onPressed: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        fechaAsignacion = pickedDate;
                      });
                    }
                  },
                  child: Text(
                    fechaAsignacion == null
                        ? 'Seleccionar Fecha'
                        : '${fechaAsignacion!.day}/${fechaAsignacion!.month}/${fechaAsignacion!.year}',
                        style: TextStyle(fontFamily: 'Roboto', fontSize: alto*0.02),
                  ),
                ),
                SizedBox(height: alto * 0.04),

                // Fecha de Finalización
                Text('Fecha de Expiración:', style: TextStyle(fontFamily: 'Roboto', fontSize: alto * 0.025)),
                SizedBox(height: alto * 0.02),
                ElevatedButton(
                  onPressed: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        fechaFinalizacion = pickedDate;
                      });
                    }
                  },
                  child: Text(
                    fechaFinalizacion == null
                        ? 'Seleccionar Fecha'
                        : '${fechaFinalizacion!.day}/${fechaFinalizacion!.month}/${fechaFinalizacion!.year}',
                        style: TextStyle(fontFamily: 'Roboto', fontSize: alto*0.02),
                  ),
                ),
                SizedBox(height: alto * 0.04),

                // Formato Principal
                Text('Formato Principal:', style: TextStyle(fontFamily: 'Roboto', fontSize: alto * 0.025)),
                SizedBox(height: alto * 0.02),
                DropdownButton<String>(
                  value: formatoPrincipal,
                  items: opcionesFormato.map((String formato) {
                    return DropdownMenuItem<String>(
                      value: formato,
                      child: Text(formato, style: TextStyle(fontFamily: 'Roboto', fontSize: alto*0.02),),
                    );
                  }).toList(),
                  onChanged: (String? nuevoFormato) {
                    setState(() {
                      formatoPrincipal = nuevoFormato!;
                      formatosAdicionales.remove(formatoPrincipal);
                    });
                  },
                ),
                SizedBox(height: alto * 0.04),

                // Formatos Adicionales
                Text('Formatos Adicionales:', style: TextStyle(fontFamily: 'Roboto', fontSize: alto * 0.025)),
                Column(
                  children: opcionesFormato.map((String formato) {
                    final bool isPrincipal = formato == formatoPrincipal;
                    return CheckboxListTile(
                      title: Text(formato, style: TextStyle(fontFamily: 'Roboto', fontSize: alto*0.02),),
                      value: isPrincipal ? false : formatosAdicionales.contains(formato),
                      onChanged: isPrincipal
                          ? null
                          : (bool? value) {
                              setState(() {
                                if (value == true) {
                                  formatosAdicionales.add(formato);
                                } else {
                                  formatosAdicionales.remove(formato);
                                }
                              });
                            },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            // Cancelar
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar', style: TextStyle(fontFamily: 'Roboto', fontSize: alto*0.03),),
            ),
            // Confirmar
            ElevatedButton(
              onPressed: () async {
                if (fechaAsignacion != null && fechaFinalizacion != null) {
                  // Validar y construir formato
                  String formato = [
                    formatoPrincipal,
                    ...formatosAdicionales
                  ].join(", ").trim();

                  // Verificar que el formato no esté vacío
                  if (formato.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Selecciona al menos un formato.")),
                    );
                    return;
                  }

                  final bool resultado = await controladores.asignarTarea(
                    alumnoSel!,
                    tareaSel!, // idTareaPlantilla
                    completada, // Completada
                    formato, // Formato combinado
                    fechaAsignacion!.toIso8601String(),
                    fechaFinalizacion!.toIso8601String(),
                    "", // fotoResultado
                    "", // valoración
                    "images/microondas.png" // miniatura
                  );

                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        resultado
                            ? "Tarea asignada exitosamente."
                            : "Error al asignar la tarea.",
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Selecciona ambas fechas.")),
                  );
                }
              },
              child: Text('Confirmar', style: TextStyle(fontFamily: 'Roboto', fontSize: alto*0.03),),
            ),
          ],
        );
      });
    },
  );
}

  Widget _buildCell(dynamic content, BuildContext context,
      {bool isHeader = false}) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.01,
        horizontal: screenWidth * 0.01,
      ),
      child: content is Widget
          ? content
          : Text(
              content.toString(),
              style: TextStyle(
                fontFamily: 'Roboto', 
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                fontSize: screenHeight * 0.02,
              ),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
    );
    
  }
  
  
}
