import 'package:dali/widget/adminTitulo.dart';
import 'package:dali/widget/barraMenuProfe.dart';
import 'package:flutter/material.dart';


class ProfeMateriales extends StatefulWidget {
  @override
  _ProfeMaterialesState createState() => _ProfeMaterialesState();
}

class _ProfeMaterialesState extends State<ProfeMateriales> {
  int aula = 1; 
  List<Map<String, dynamic>> materials = [];

  void _showAddMaterialDialog() {
    String nombre = '';
    int cantidad = 1;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        final screenHeight = MediaQuery.of(context).size.height;
        return AlertDialog(
          title: Text("Añadir material", style: TextStyle(fontSize: screenHeight*0.03, fontFamily: 'Roboto',)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                style: TextStyle(fontSize: screenHeight * 0.02),
                decoration: InputDecoration(labelText: "Nombre del material", labelStyle: TextStyle(fontSize: screenHeight*0.02, fontFamily: 'Roboto',)),
                onChanged: (value) {
                  nombre = value;
                },
              ),
              TextField(
                style: TextStyle(fontSize: screenHeight * 0.015, fontFamily: 'Roboto',),
                decoration: InputDecoration(labelText: "Cantidad", labelStyle: TextStyle(fontSize: screenHeight*0.02, fontFamily: 'Roboto',)),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  cantidad = int.tryParse(value) ?? 1;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Cancelar ", style: TextStyle(fontSize: screenHeight*0.015, fontFamily: 'Roboto',),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red
              ),
              child: Text("Añadir", style: TextStyle(fontSize: screenHeight*0.015, color: Colors.white, fontFamily: 'Roboto',),),
              onPressed: () {
                if(nombre!=""){
                  setState(() {
                    materials.add({
                      'nombre': nombre,
                      'cantidad': cantidad,
                    });
                  });
                  Navigator.of(context).pop();
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Introduce el nombre del material", style: TextStyle(fontSize: screenHeight*0.025, fontFamily: 'Roboto',),)),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          AdminTitulo(atras: false, titulo: "Pedir Materiales"),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05, top: screenHeight*0.05, bottom: screenHeight*0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título de la sección
                  Text(
                    "Material a pedir",
                    style: TextStyle(
                      fontSize: screenHeight * 0.03,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Contenedor con el selector de aula al lado
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Contenedor de materiales
                      Expanded(
                        child: Container(
                          height: screenHeight * 0.3, // Tamaño fijo
                          padding: EdgeInsets.only(left: screenWidth * 0.08, right: screenWidth * 0.08, top: screenHeight*0.02, bottom: screenHeight*0.01),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(screenWidth * 0.02),
                          ),
                          child: Column(
                            children: [
                              // Lista de materiales con desplazamiento
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: materials.map((material) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
                                        child: Container(
                                          padding: EdgeInsets.only(left: screenWidth*0.05, right: screenWidth*0.1),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(screenWidth*0.01),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(material['nombre'], style: TextStyle(fontSize: screenHeight*0.03, fontFamily: 'Roboto', color: Colors.white,),),
                                              Text("x${material['cantidad']}", style: TextStyle(fontSize: screenHeight*0.03, fontFamily: 'Roboto', color: Colors.white),),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              // Botón para añadir materiales
                              Center(
                                child: IconButton(
                                  icon: Icon(Icons.add, size: screenHeight*0.04,),
                                  onPressed: () {
                                    // Muestra un cuadro de diálogo para agregar materiales
                                    _showAddMaterialDialog();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.05),
                      // Selector de aula
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Aula",
                            style: TextStyle(fontSize: screenHeight * 0.025, fontWeight: FontWeight.bold, fontFamily: 'Roboto',),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: screenWidth * 0.1,
                            height: screenHeight * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(screenWidth * 0.01),
                              color: Colors.red,
                            ),
                            child: DropdownButton<int>(
                              value: aula,
                              onChanged: (int? newValue) {
                                setState(() {
                                  aula = newValue!;
                                });
                              },
                              items: List.generate(
                                10,
                                (index) => DropdownMenuItem<int>(
                                  value: index + 1,
                                  child: Text("${index + 1}", style: TextStyle(fontSize: screenHeight*0.02, fontFamily: 'Roboto',),),
                                ),
                              ),
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: screenHeight * 0.02,
                                color: Colors.white
                              ),
                              focusColor: Colors.red,
                              dropdownColor: Colors.red,
                              icon: Icon(Icons.arrow_drop_down, size: screenHeight*0.04, color: Colors.white,), 
                              borderRadius:  BorderRadius.circular(screenWidth * 0.01), 
                              underline: Container(height: 0,),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  // Botón de pedir material
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        maximumSize: Size(screenWidth*0.4, screenHeight*0.07),
                        minimumSize: Size(screenWidth*0.4, screenHeight*0.07),
                        backgroundColor: Colors.red[700],
                      ),
                      onPressed: () {
                        // Acción para pedir material
                      },
                      child: Text(
                        "Pedir material",
                        style: TextStyle(
                          fontSize: screenHeight * 0.025,
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),


        ],
      ),
      bottomNavigationBar: BarraMenuProfe(selectedIndex: 1),
    );
  }
}