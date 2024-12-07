import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widget/barraMenu.dart';


class AdminAsignarTareas extends StatefulWidget {
  @override
  _AdminAsignarTareasState createState() => _AdminAsignarTareasState();
}

class _AdminAsignarTareasState extends State<AdminAsignarTareas> {
  int? tareaSel; // Índice de la tarea seleccionada
  int? alumnoSel; // Índice del alumno seleccionado
  String? formatoSel = 'Texto';

  final List<Map<String, String>> tareas = [
    {
      "nombre": "Tarea 1",
      "descripcion":
          "Esta es una descripción muy larga para probar cómo se ve en varias líneas dentro de la tabla horizontal.",
    },
    {
      "nombre": "Tarea 2",
      "descripcion": "Descripción más corta.",
    },
  ];

  final List<Map<String, String>> alumnos = [
    {"nombre": "Ana", "nickname": "ana123"},
    {"nombre": "Carlos", "nickname": "carlos456"},
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          // Título superior
          Padding(
            padding: EdgeInsets.only(
              bottom: screenHeight * 0.02,
              top: screenHeight * 0.02,
            ),
            child: SizedBox(
              height: screenHeight * 0.1,
              child: Center(
                child: FittedBox(
                  child: Text(
                    "Asignar Tareas",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontSize: screenHeight * 0.08,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Tablas horizontales
          Expanded(
            child: Row(
              children: [
                // Tabla de tareas
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.05,
                        left: screenWidth * 0.03,
                        right: screenWidth * 0.03,
                        bottom: screenHeight * 0.1),
                    child: Column(
                      children: [
                        Text(
                          "Lista de Tareas",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenHeight * 0.03,
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            children: [
                              Table(
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.intrinsicHeight,
                                border: TableBorder.all(color: Colors.grey),
                                columnWidths: const {
                                  0: FlexColumnWidth(2),
                                  1: FlexColumnWidth(3),
                                },
                                children: [
                                  // Encabezado
                                  TableRow(
                                    decoration:
                                        const BoxDecoration(color: Colors.green),
                                    children: [
                                      _buildCell("Nombre", context,
                                          isHeader: true),
                                      _buildCell("Descripción", context,
                                          isHeader: true),
                                    ],
                                  ),
                                  // Filas dinámicas
                                  ...tareas.asMap().entries.map((entry) {
                                    final index = entry.key;
                                    final task = entry.value;

                                    return TableRow(
                                      decoration: BoxDecoration(
                                        color: tareaSel == index
                                            ? Colors.yellow
                                            : Colors.white,
                                      ),
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              tareaSel = tareaSel == index
                                                  ? null
                                                  : index;
                                            });
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              color: Colors.transparent,
                                              child: _buildCell(
                                                  task["nombre"], context)),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              tareaSel = tareaSel == index
                                                  ? null
                                                  : index;
                                            });
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              color: Colors.transparent,
                                              child: _buildCell(
                                                  task["descripcion"],
                                                  context)),
                                        ),
                                      ],
                                    );
                                  }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Botón de Asignar
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: (tareaSel != null && alumnoSel != null)
                          ? () {
                              _mostrarDialogoAsignarTarea(context);
                              // Acción de asignar tarea
                              print("Tarea ${tareas[tareaSel!]['nombre']} asignada a ${alumnos[alumnoSel!]['nombre']} con formato: $formatoSel");
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:Colors.blue,
                        maximumSize: Size(screenWidth*0.12, screenHeight*0.08),
                        minimumSize: Size(screenWidth*0.12, screenHeight*0.08),
                        foregroundColor: Colors.black,
                      ),
                      child: Text(
                        "Asignar Tarea",
                        style: TextStyle(fontSize: screenHeight * 0.02, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),

                // Tabla de alumnos
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.05,
                        left: screenWidth * 0.03,
                        right: screenWidth * 0.03,
                        bottom: screenHeight * 0.1),
                    child: Column(
                      children: [
                        Text(
                          "Lista de Alumnos",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenHeight * 0.03,
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            children: [
                              Table(
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.intrinsicHeight,
                                border: TableBorder.all(color: Colors.grey),
                                columnWidths: const {
                                  0: FlexColumnWidth(5),
                                  1: FlexColumnWidth(5),
                                },
                                children: [
                                  // Encabezado
                                  TableRow(
                                    decoration:
                                        const BoxDecoration(color: Colors.red),
                                    children: [
                                      _buildCell("Nombre", context,
                                          isHeader: true),
                                      _buildCell("Nickname", context,
                                          isHeader: true),
                                    ],
                                  ),
                                  // Filas dinámicas
                                  ...alumnos.asMap().entries.map((entry) {
                                    final index = entry.key;
                                    final alumno = entry.value;

                                    return TableRow(
                                      decoration: BoxDecoration(
                                        color: alumnoSel == index
                                            ? Colors.yellow
                                            : Colors.white,
                                      ),
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              alumnoSel = alumnoSel == index
                                                  ? null
                                                  : index;
                                            });
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              color: Colors.transparent,
                                              child: _buildCell(
                                                  alumno["nombre"], context)),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              alumnoSel = alumnoSel == index
                                                  ? null
                                                  : index;
                                            });
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              color: Colors.transparent,
                                              child: _buildCell(
                                                  alumno["nickname"], context)),
                                        ),
                                      ],
                                    );
                                  }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // Barra de navegación personalizada
      bottomNavigationBar: BarraMenu(selectedIndex: 2),
    );
  }

  Widget _buildCell(dynamic content, BuildContext context,{bool isHeader = false}) {
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
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                fontSize: screenHeight * 0.02,
              ),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
    );
  }

  void _mostrarDialogoAsignarTarea(BuildContext context) {
    DateTime? fechaAsignacion;
    DateTime? fechaFinalizacion;
    String formatoPrincipal = 'Audio';
    List<String> formatosAdicionales = [];
    List<String> opcionesFormato = ['Audio', 'Texto', 'Imagen', 'Pictograma', 'Video'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        double alto = MediaQuery.of(context).size.height;
        double ancho = MediaQuery.of(context).size.width;
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text(
              'Detalles de Asignación',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: alto*0.06),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Fecha de Asignación
                  Text('Fecha Asignación:', style: TextStyle(fontSize: alto*0.02),),
                  SizedBox(height: alto*0.02),
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
                    style: ElevatedButton.styleFrom(
                      maximumSize: Size(ancho*0.13, alto*0.05),
                      minimumSize: Size(ancho*0.13, alto*0.05),
                    ),
                    child: Text(fechaAsignacion == null
                        ? 'Seleccionar Fecha'
                        : '${fechaAsignacion!.day}/${fechaAsignacion!.month}/${fechaAsignacion!.year}',
                        style: TextStyle(color: Colors.black, fontSize: alto*0.02),),
                  ),
                  SizedBox(height: alto*0.04),

                  // Fecha de Finalización
                  Text('Fecha Finalización:', style: TextStyle(fontSize: alto*0.02),),
                  SizedBox(height: alto*0.02),
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
                    style: ElevatedButton.styleFrom(
                      maximumSize: Size(ancho*0.13, alto*0.05),
                      minimumSize: Size(ancho*0.13, alto*0.05),
                    ),
                    child: Text(fechaFinalizacion == null
                        ? 'Seleccionar Fecha'
                        : '${fechaFinalizacion!.day}/${fechaFinalizacion!.month}/${fechaFinalizacion!.year}',
                        style: TextStyle(color: Colors.black, fontSize: alto*0.02),),
                  ),
                  SizedBox(height: alto*0.04),

                  // Formato Principal
                  Text('Formato Principal:', style: TextStyle(fontSize: alto*0.02),),
                  SizedBox(height: alto*0.02),
                  SizedBox(
                    height: alto*0.08,
                    child: DropdownButton<String>(
                      value: formatoPrincipal,
                      items: opcionesFormato.map((String formato) {
                        return DropdownMenuItem<String>(
                          value: formato,
                          child: Text(formato, style: TextStyle(fontSize: alto*0.02),),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          formatoPrincipal = newValue!;
                          formatosAdicionales.remove(formatoPrincipal);
                        });
                      },
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: alto * 0.02,
                        color: Colors.black,
                      ),
                      focusColor: Colors.transparent,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        size: alto * 0.04,
                      ),
                      borderRadius:
                          BorderRadius.circular(ancho * 0.01),
                      underline: Container(height: 0,),
                    ),
                  ),
                  SizedBox(height: alto*0.04),

                  // Formatos Adicionales
                  Text('Formatos Adicionales:', style: TextStyle(fontSize: alto*0.02),),
                  SizedBox(height: alto*0.02),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: opcionesFormato.map((String formato) {
                      final bool isPrincipal = formato == formatoPrincipal;
                      return Transform.scale(
                        scale: alto*0.0015,
                        child: CheckboxListTile(
                          title: Text(
                            formato,
                            style: TextStyle(
                              fontSize: alto * 0.02,
                            ),
                          ),
                          value: isPrincipal
                              ? false
                              : formatosAdicionales.contains(formato),
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
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            actions: [
              // Botón Cancelar
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancelar', style: TextStyle(fontSize: alto*0.03),),
              ),
              // Botón Confirmar
              ElevatedButton(
                onPressed: () {
                  // Acción de confirmación
                  if (fechaAsignacion != null && fechaFinalizacion != null) {
                    print('Fecha Asignación: $fechaAsignacion');
                    print('Fecha Finalización: $fechaFinalizacion');
                    print('Formato Principal: $formatoPrincipal');
                    print('Formatos Adicionales: $formatosAdicionales');
                    Navigator.of(context).pop();
                  } else {
                    // Mostrar un error si las fechas no se han seleccionado
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Error", style: TextStyle(fontSize: alto*0.03)),
                          content: Text("Por favor selecciona ambas fechas.", style: TextStyle(fontSize: alto*0.02)),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Aceptar", style: TextStyle(fontSize: alto*0.02)),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  maximumSize: Size(ancho*0.13, alto*0.08),
                  minimumSize: Size(ancho*0.05, alto*0.08),
                ),
                child: Text('Confirmar',style: TextStyle(fontSize: alto*0.03),),
              ),
            ],
          );
        });
      },
    );
  }
}
