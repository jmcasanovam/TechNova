import 'package:dali/screen/adminAlumnoTareas.dart';
import 'package:dali/screen/adminCreadorPerfil.dart';
import 'package:dali/screen/adminEditarPerfil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widget/barraMenu.dart';




class AdminUsuarios extends StatefulWidget {
  @override
  _AdminUsuariosState createState() => _AdminUsuariosState();
}

class _AdminUsuariosState extends State<AdminUsuarios> {
  String? _ordenActual = 'Ordenar A-Z';
  List<String> nombres = ['Carlos', 'Ana', 'Luis', 'María', 'Pedro','Carlos', 'Ana', 'Luis', 'María', 'Pedro'];
  

  @override
  void initState(){
    super.initState();
    _ordenarLista();
  }

  void _ordenarLista() {
    setState(() {
      if (_ordenActual == 'Ordenar A-Z') {
        nombres.sort((a, b) => a.compareTo(b));
      } else {
        nombres.sort((a, b) => b.compareTo(a));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _ordenActual;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.02, top: screenHeight * 0.02,),
            child: SizedBox(
              height: screenHeight * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                  Expanded(
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          "Alumnos",
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
                ],
              )
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: screenWidth * 0.05, left: screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Botones de "Ordenar" y "Crear Perfil"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Boton desplegable ordenar
                      Container(
                        alignment: Alignment.center,
                        width: screenWidth*0.1,
                        height: screenHeight * 0.06,
                        decoration: BoxDecoration(  
                          borderRadius: BorderRadius.circular(screenWidth * 0.01),
                          color: Colors.red, // Color de fondo del contenedor
                        ),
                        child: DropdownButton<String>(
                          value: _ordenActual,
                          onChanged: (String? nuevoValor) {
                            setState(() {
                              _ordenActual = nuevoValor;
                              _ordenarLista();
                            });
                          },
                          items: <String>['Ordenar A-Z', 'Ordenar Z-A']
                              .map<DropdownMenuItem<String>>((String valor) {
                            return DropdownMenuItem<String>(
                              value: valor,
                              child: Text(valor),
                            );
                          }).toList(),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontSize: screenHeight * 0.02,
                          ),
                          icon: Icon(Icons.arrow_drop_down, color: Colors.white, size: screenWidth*0.02,), 
                          dropdownColor: Colors.red,
                          borderRadius:  BorderRadius.circular(screenWidth * 0.01), 
                          underline: Container(height: 0,),
                          // padding: EdgeInsets.only(left: screenWidth*0.02),
                        ),
                      ),

                      //Boton de crear perfil
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          // fixedSize: Size(screenWidth*0.1, screenHeight * 0.06),
                          minimumSize: Size(screenWidth*0.1, screenHeight * 0.06),
                          maximumSize: Size(screenWidth*0.1, screenHeight * 0.06),
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.01),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminCreadorPerfil()),
                          );
                        },
                        icon: Icon(Icons.add, color: Colors.white,size: screenWidth*0.02),
                        label: Text(
                          'Crear perfil',
                          style: TextStyle(
                            fontSize: screenHeight * 0.02,
                            fontFamily: 'Roboto',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: screenHeight * 0.02),

                  // Lista de alumnos
                  

                  Text("Nickname", style: TextStyle(
                            fontSize: screenHeight * 0.03,
                            fontFamily: 'Roboto',
                            color: Colors.black,
                          ),),
                  Divider(color: Colors.black, thickness: screenHeight*0.006,),  
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(  
                        borderRadius: BorderRadius.circular(screenWidth * 0.01),
                        color: Colors.grey[200], // Color de fondo del contenedor
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: screenHeight * 0.01, bottom: screenHeight * 0.01, left: screenWidth * 0.01, right: screenWidth * 0.01),
                        itemCount: nombres.length, 
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: screenHeight * 0.01),
                            child: Container(
                              // height: screenHeight*0.07,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(screenWidth * 0.02),
                              ),
                              child: ListTile(
                                title: Text(nombres[index], style: TextStyle(fontSize: screenHeight * 0.03, fontWeight: FontWeight.bold,fontFamily: 'Roboto', color: Colors.white)),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AdminAlumnoTareas(nickname: nombres[index]),
                                          ),
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.red[100]
                                      ),
                                      child: Text("Tareas", style: TextStyle(fontSize: screenHeight * 0.03, fontWeight: FontWeight.bold,fontFamily: 'Roboto', color: Colors.black)),
                                    ),
                                    SizedBox(width: screenWidth*0.01,),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AdminEditarPerfil(nickname: nombres[index]),
                                          ),
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.red[100]
                                      ),
                                      child: Text("Editar perfil", style: TextStyle(fontSize: screenHeight * 0.03, fontWeight: FontWeight.bold,fontFamily: 'Roboto',  color: Colors.black)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Barra de menú
      bottomNavigationBar: BarraMenu(selectedIndex: 0,),
    );
  }
}

