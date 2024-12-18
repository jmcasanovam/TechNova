import 'package:dali/controlers/controladores.dart';
import 'package:dali/widget/adminTitulo.dart';
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
    
    // Instanciar el controlador
    final Controladores controlador = Controladores();

    // Mostramos el nickname en consola
    print("Nickname: $nickname");
    
    // Llamada al método que obtiene las tareas
    Future<List<Map<String, dynamic>>> tareas = controlador.getTareasPorNickname(nickname);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AdminTitulo(atras: true, titulo: "Historial - $nickname",),

          // Aquí es donde usamos FutureBuilder
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: tareas,  // Usamos el Future que retorna las tareas
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  print("Error: ${snapshot.error}");
                  return Center(child: Text("Error al cargar las tareas"));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("No hay tareas disponibles"));
                }

                List<Map<String, dynamic>> tareasData = snapshot.data!;

                return ListView(
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
                        TableRow(
                          decoration: const BoxDecoration(color: Colors.red),
                          children: [
                            _buildCell("Completada", context, isHeader: true),
                            _buildCell("Formato", context, isHeader: true),
                            _buildCell("Fecha Asignación", context, isHeader: true),
                            _buildCell("Fecha Expiración", context, isHeader: true),
                            _buildCell("Foto Resultado", context, isHeader: true),
                            _buildCell("Valoración", context, isHeader: true),
                            _buildCell("Fecha Completada", context, isHeader: true),
                          ],
                        ),
                        ...tareasData.map((tarea) => TableRow(
                              children: [
                                _buildCell(
                                   (tarea["completada"] == 1)  // Si es 1, lo tratamos como true
                                      ? Icon(Icons.check_circle, color: Colors.green)
                                      : Icon(Icons.cancel, color: Colors.red),
                                  context,
                                ),
                                _buildCell(tarea["formato"], context),
                                _buildCell(tarea["fechaAsignacion"], context),
                                _buildCell(tarea["fechaExpiracion"], context),
                                
                                _buildCell(
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      maximumSize: Size(screenWidth * 0.02, screenHeight * 0.05),
                                      minimumSize: Size(screenWidth * 0.02, screenHeight * 0.05),
                                    ),
                                    onPressed: () {
                                      tarea["fotoResultado"]==null?
                                        _mostrarFoto(context, false, "") : 
                                        _mostrarFoto(context, true, tarea["fotoResultado"]);
                                    },
                                    child: Text("Ver Foto", style: TextStyle(fontSize: screenHeight * 0.02)),
                                  ),
                                  context,
                                ),
                                _buildCell(tarea["valoracion"], context),
                                _buildCell(tarea["fechaCompletada"], context),
                              ],
                            )),

                      ],
                    ),
                  ],
                );
              },
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
      padding: EdgeInsets.only(top: screenHeight * 0.01, bottom: screenHeight * 0.01, left: screenWidth * 0.01, right: screenWidth * 0.01),
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

  void _mostrarFoto(BuildContext context, bool existe, String fotoUrl) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              !existe? 
                Image.asset('images/no.png', width: screenWidth * 0.3, height: screenHeight * 0.4) :
                Image.network(fotoUrl, width: screenWidth * 0.3, height: screenHeight * 0.4),
              SizedBox(height: screenHeight * 0.04),
              Text("Foto de la tarea", style: TextStyle(fontSize: screenHeight * 0.02)),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cerrar", style: TextStyle(fontSize: screenHeight * 0.03)),
              ),
            ],
          ),
        );
      },
    );
  }
}
