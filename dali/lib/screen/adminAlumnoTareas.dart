import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';


import 'package:flutter/material.dart';

import '../widget/barraMenu.dart';

class AdminAlumnoTareas extends StatelessWidget {
  final String nickname;

  AdminAlumnoTareas({required this.nickname});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    // Datos de ejemplo
    final List<Map<String, dynamic>> tareas = [
      {
        "completada": true,
        "formato": "Video",
        "fechaAsignacion": "2024-11-01",
        "fechaExpiracion": "2024-11-15",
        "fotoResultado": "images/panda.png", // URL temporal
        "valoracion": "Buen trabajo",
      },
      {
        "completada": false,
        "formato": "Pictograma",
        "fechaAsignacion": "2024-11-05",
        "fechaExpiracion": "2024-11-20",
        "fotoResultado": "https://via.placeholder.com/150",
        "valoracion": "Este comentario es muy largo, así que necesitamos que ocupe más de una línea para que sea visible correctamente y no se superponga a otros elementos.",
      },
      {
        "completada": true,
        "formato": "Video",
        "fechaAsignacion": "2024-11-01",
        "fechaExpiracion": "2024-11-15",
        "fotoResultado": "https://via.placeholder.com/150", // URL temporal
        "valoracion": "Buen trabajo",
      },
      {
        "completada": false,
        "formato": "Pictograma",
        "fechaAsignacion": "2024-11-05",
        "fechaExpiracion": "2024-11-20",
        "fotoResultado": "https://via.placeholder.com/150",
        "valoracion": "Este comentario es muy largo, así que necesitamos que ocupe más de una línea para que sea visible correctamente y no se superponga a otros elementos.",
      },
      {
        "completada": true,
        "formato": "Video",
        "fechaAsignacion": "2024-11-01",
        "fechaExpiracion": "2024-11-15",
        "fotoResultado": "https://via.placeholder.com/150", // URL temporal
        "valoracion": "Buen trabajo",
      },
      {
        "completada": false,
        "formato": "Pictograma",
        "fechaAsignacion": "2024-11-05",
        "fechaExpiracion": "2024-11-20",
        "fotoResultado": "https://via.placeholder.com/150",
        "valoracion": "Este comentario es muy largo, así que necesitamos que ocupe más de una línea para que sea visible correctamente y no se superponga a otros elementos.",
      },
      {
        "completada": true,
        "formato": "Video",
        "fechaAsignacion": "2024-11-01",
        "fechaExpiracion": "2024-11-15",
        "fotoResultado": "https://via.placeholder.com/150", // URL temporal
        "valoracion": "Buen trabajo",
      },
      {
        "completada": false,
        "formato": "Pictograma",
        "fechaAsignacion": "2024-11-05",
        "fechaExpiracion": "2024-11-20",
        "fotoResultado": "https://via.placeholder.com/150",
        "valoracion": "Este comentario es muy largo, así que necesitamos que ocupe más de una línea para que sea visible correctamente y no se superponga a otros elementos.",
      },
      {
        "completada": true,
        "formato": "Video",
        "fechaAsignacion": "2024-11-01",
        "fechaExpiracion": "2024-11-15",
        "fotoResultado": "https://via.placeholder.com/150", // URL temporal
        "valoracion": "Buen trabajo",
      },
      {
        "completada": false,
        "formato": "Pictograma",
        "fechaAsignacion": "2024-11-05",
        "fechaExpiracion": "2024-11-20",
        "fotoResultado": "https://via.placeholder.com/150",
        "valoracion": "Este comentario es muy largo, así que necesitamos que ocupe más de una línea para que sea visible correctamente y no se superponga a otros elementos.",
      },
      {
        "completada": true,
        "formato": "Video",
        "fechaAsignacion": "2024-11-01",
        "fechaExpiracion": "2024-11-15",
        "fotoResultado": "https://via.placeholder.com/150", // URL temporal
        "valoracion": "Buen trabajo",
      },
      {
        "completada": false,
        "formato": "Pictograma",
        "fechaAsignacion": "2024-11-05",
        "fechaExpiracion": "2024-11-20",
        "fotoResultado": "https://via.placeholder.com/150",
        "valoracion": "Este comentario es muy largo, así que necesitamos que ocupe más de una línea para que sea visible correctamente y no se superponga a otros elementos.",
      },
      {
        "completada": true,
        "formato": "Video",
        "fechaAsignacion": "2024-11-01",
        "fechaExpiracion": "2024-11-15",
        "fotoResultado": "https://via.placeholder.com/150", // URL temporal
        "valoracion": "Buen trabajo",
      },
      {
        "completada": false,
        "formato": "Pictograma",
        "fechaAsignacion": "2024-11-05",
        "fechaExpiracion": "2024-11-20",
        "fotoResultado": "https://via.placeholder.com/150",
        "valoracion": "Este comentario es muy largo, así que necesitamos que ocupe más de una línea para que sea visible correctamente y no se superponga a otros elementos.",
      },
      {
        "completada": true,
        "formato": "Video",
        "fechaAsignacion": "2024-11-01",
        "fechaExpiracion": "2024-11-15",
        "fotoResultado": "https://via.placeholder.com/150", // URL temporal
        "valoracion": "Buen trabajo",
      },
      {
        "completada": false,
        "formato": "Pictograma",
        "fechaAsignacion": "2024-11-05",
        "fechaExpiracion": "2024-11-20",
        "fotoResultado": "https://via.placeholder.com/150",
        "valoracion": "Este comentario es muy largo, así que necesitamos que ocupe más de una línea para que sea visible correctamente y no se superponga a otros elementos.",
      },
    ];

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.02, top: screenHeight * 0.02,),
            child: SizedBox(
              height: screenHeight * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Image.asset('images/back-arrow.png', width: screenWidth * 0.08,),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          "Historial - $nickname",
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
                  SizedBox(
                    width: screenWidth * 0.08,
                  ),
                ],
              )
            ),
          ),

          Expanded(
            child: ListView(
              children: [
                Table(
                  border: TableBorder.all(color: Colors.grey),
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(2),
                    3: FlexColumnWidth(2),
                    4: FlexColumnWidth(2),
                    5: FlexColumnWidth(3),
                  },
                  children: [
                    // Encabezado
                    TableRow(
                      decoration: const BoxDecoration(color: Colors.red),
                      children: [
                        _buildCell("Completada", context, isHeader: true),
                        _buildCell("Formato",context, isHeader: true),
                        _buildCell("Fecha Asignación", context, isHeader: true),
                        _buildCell("Fecha Expiración", context, isHeader: true),
                        _buildCell("Foto Resultado", context, isHeader: true),
                        _buildCell("Valoración", context, isHeader: true),
                      ],
                    ),
                    // Filas dinámicas
                    ...tareas.map((tarea) => TableRow(
                          children: [
                            _buildCell(
                              tarea["completada"]
                                  ? Icon(Icons.check_circle, color: Colors.green)
                                  : Icon(Icons.cancel, color: Colors.red), context
                            ),
                            _buildCell(tarea["formato"], context),
                            _buildCell(tarea["fechaAsignacion"], context),
                            _buildCell(tarea["fechaExpiracion"], context),
                            _buildCell(
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  maximumSize: Size(screenWidth*0.02, screenHeight*0.05),
                                  minimumSize: Size(screenWidth*0.02, screenHeight*0.05)
                                ),
                                onPressed: () =>
                                    _mostrarFoto(context, tarea["fotoResultado"]),
                                child: Text("Ver Foto", style: TextStyle(fontSize: screenHeight*0.02),),
                              ),context
                            ),
                            _buildCell(tarea["valoracion"],context),
                          ],
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BarraMenu(selectedIndex: 0),
    );
  }

  Widget _buildCell(dynamic content, BuildContext context, {bool isHeader = false}) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: screenHeight*0.01, bottom: screenHeight*0.01, left: screenWidth*0.01, right: screenWidth*0.01),
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

  void _mostrarFoto(BuildContext context, String fotoUrl) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(fotoUrl, width: screenWidth*0.3, height: screenHeight * 0.4,),
              SizedBox(height: screenHeight*0.04),
              Text("Foto de la tarea", style: TextStyle(fontSize: screenHeight * 0.02),),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cerrar", style: TextStyle(fontSize: screenHeight*0.03),),
              ),
            ],
          ),
        );
      },
    );
  }
}
