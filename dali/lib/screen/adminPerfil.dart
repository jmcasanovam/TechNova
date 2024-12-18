import 'package:dali/controlers/controladores.dart';
import 'package:dali/screen/adminAlumnoTareas.dart';
import 'package:dali/screen/adminCreadorPerfil.dart';
import 'package:dali/screen/adminEditarPerfil.dart';
import 'package:dali/widget/adminTitulo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widget/barraMenu.dart';

class AdminPerfil extends StatefulWidget {
  @override
  _AdminPerfilState createState() => _AdminPerfilState();
}

class _AdminPerfilState extends State<AdminPerfil> {

  String nombre = "juan";
  String nickname = "juan123";
  String nombreNuevo = "juan";
  String nicknameNuevo = "juan123";

  bool _oculto1 = true;
  bool _oculto2 = true;
  bool _oculto3 = true;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          AdminTitulo(atras: false, titulo: "Perfil"),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        //Cambiar de nomobre
                        Container(
                          width: screenWidth*0.35,
                          height: screenHeight*0.1,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(screenWidth * 0.02),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth*0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Nombre:", style: TextStyle(fontFamily: 'Roboto', fontSize: screenHeight*0.025, color: Colors.white),),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(screenWidth*0.01),
                                    color: Colors.white,
                                  ),
                                  width: screenWidth * 0.15,
                                  child: TextField(
                                    controller: TextEditingController(text: nombre),
                                    style: TextStyle(
                                      fontFamily: 'Roboto', 
                                      color: Colors.black,
                                      fontSize: screenHeight * 0.02,
                                    ),
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black,), borderRadius:BorderRadius.circular(screenWidth * 0.01)),
                                      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black,), borderRadius:BorderRadius.circular(screenWidth * 0.01)),
                                      hintText: 'Ingrese su nombre',
                                      hintStyle: TextStyle(
                                        fontFamily: 'Roboto', 
                                        color: Colors.black,
                                        fontSize: screenHeight * 0.020,
                                      ),
                                    ),
                                    onChanged: (value) => nombreNuevo = value,
                                    ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight*0.02,),

                        //cambiar de nickname
                        Container(
                          width: screenWidth*0.35,
                          height: screenHeight*0.1,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(screenWidth * 0.02),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth*0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Nickname:", style: TextStyle(fontFamily: 'Roboto', fontSize: screenHeight*0.025, color: Colors.white),),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(screenWidth*0.01),
                                    color: Colors.white,
                                  ),
                                  width: screenWidth * 0.15,
                                  child: TextField(
                                    controller: TextEditingController(text: nickname),
                                    style: TextStyle(
                                      fontFamily: 'Roboto', 
                                      color: Colors.black,
                                      fontSize: screenHeight * 0.02,
                                    ),
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black,), borderRadius:BorderRadius.circular(screenWidth * 0.01)),
                                      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black,), borderRadius:BorderRadius.circular(screenWidth * 0.01)),
                                      hintText: 'Ingrese su nickname',
                                      hintStyle: TextStyle(
                                        fontFamily: 'Roboto', 
                                        color: Colors.black,
                                        fontSize: screenHeight * 0.020,
                                      ),
                                    ),
                                    onChanged: (value) => nicknameNuevo = value,
                                    ),
                                )
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: screenHeight*0.02,),
                      ],
                    ),
                    SizedBox(width: screenWidth*0.02,),
                    FilledButton(
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.02)),
                        backgroundColor: Colors.red[400],
                        minimumSize: Size(screenWidth * 0.15, screenHeight * 0.15),
                        maximumSize: Size(screenWidth * 0.15, screenHeight * 0.15),
                      ),
                      onPressed: () => {},
                      child: Text(
                        "Confirmar valores",
                        style: TextStyle(fontFamily: 'Roboto', fontSize: screenHeight * 0.03),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),


                //Cambiar contraseña
                FilledButton(
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02)),
                    backgroundColor: Colors.red[200],
                    minimumSize: Size(screenWidth * 0.15, screenHeight * 0.15),
                    maximumSize: Size(screenWidth * 0.15, screenHeight * 0.15),
                  ),
                  onPressed: () {
                     showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            final screenHeight = MediaQuery.of(context).size.height;
                            final screenWidth = MediaQuery.of(context).size.width;
                            return AlertDialog(
                              title: Text(
                                'Cambiar contraseña',
                                style: TextStyle(fontFamily: 'Roboto', fontSize: screenHeight * 0.025, fontWeight: FontWeight.bold),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Contraseña actual
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Contraseña actual:',
                                        style: TextStyle(
                                          fontFamily: 'Roboto', 
                                          color: Colors.black,
                                          fontSize: screenHeight * 0.02,
                                        ),
                                      ),
                                      SizedBox(width: screenWidth * 0.02),
                                      SizedBox(
                                        width: screenWidth * 0.25,
                                        height: screenHeight * 0.1,
                                        child: TextField(
                                          obscureText: _oculto1,
                                          style: TextStyle(
                                            fontFamily: 'Roboto', 
                                            color: Colors.black,
                                            fontSize: screenHeight * 0.015,
                                          ),
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(color: Colors.black),
                                              borderRadius: BorderRadius.circular(screenWidth * 0.01),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(color: Colors.black),
                                              borderRadius: BorderRadius.circular(screenWidth * 0.01),
                                            ),
                                            hintText: 'Ingrese su contraseña actual',
                                            hintStyle: TextStyle(
                                              fontFamily: 'Roboto', 
                                              color: Colors.black,
                                              fontSize: screenHeight * 0.015,
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _oculto1 ? Icons.visibility : Icons.visibility_off,
                                                color: Colors.black,
                                                size: screenWidth * 0.02,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _oculto1 = !_oculto1;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: screenHeight * 0.02),

                                  // Contraseña nueva
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Nueva contraseña:',
                                        style: TextStyle(
                                          fontFamily: 'Roboto', 
                                          color: Colors.black,
                                          fontSize: screenHeight * 0.02,
                                        ),
                                      ),
                                      SizedBox(width: screenWidth * 0.02),
                                      SizedBox(
                                        width: screenWidth * 0.25,
                                        height: screenHeight*0.1,
                                        child: TextField(
                                          obscureText: _oculto2,
                                          style: TextStyle(
                                            fontFamily: 'Roboto', 
                                            color: Colors.black,
                                            fontSize: screenHeight * 0.015,
                                          ),
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(color: Colors.black),
                                              borderRadius: BorderRadius.circular(screenWidth * 0.01),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(color: Colors.black),
                                              borderRadius: BorderRadius.circular(screenWidth * 0.01),
                                            ),
                                            hintText: 'Ingrese su nueva contraseña',
                                            hintStyle: TextStyle(
                                              fontFamily: 'Roboto', 
                                              color: Colors.black,
                                              fontSize: screenHeight * 0.015,
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _oculto2 ? Icons.visibility : Icons.visibility_off,
                                                color: Colors.black,
                                                size: screenWidth * 0.02,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _oculto2 = !_oculto2;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: screenHeight * 0.02),

                                  // Confirmar contraseña
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Confirmar contraseña:',
                                        style: TextStyle(
                                          fontFamily: 'Roboto', 
                                          color: Colors.black,
                                          fontSize: screenHeight * 0.02,
                                        ),
                                      ),
                                      SizedBox(width: screenWidth * 0.02),
                                      SizedBox(
                                        width: screenWidth * 0.25,
                                        height: screenHeight*0.1,
                                        child: TextField(
                                          obscureText: _oculto3,
                                          style: TextStyle(
                                            fontFamily: 'Roboto', 
                                            color: Colors.black,
                                            fontSize: screenHeight * 0.015,
                                          ),
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(color: Colors.black),
                                              borderRadius: BorderRadius.circular(screenWidth * 0.01),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(color: Colors.black),
                                              borderRadius: BorderRadius.circular(screenWidth * 0.01),
                                            ),
                                            hintText: 'Confirme su contraseña',
                                            hintStyle: TextStyle(
                                              fontFamily: 'Roboto', 
                                              color: Colors.black,
                                              fontSize: screenHeight * 0.015,
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _oculto3 ? Icons.visibility : Icons.visibility_off,
                                                color: Colors.black,
                                                size: screenWidth * 0.02,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _oculto3 = !_oculto3;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                      minimumSize: Size(screenWidth * 0.13, screenHeight * 0.05),
                                      maximumSize: Size(screenWidth * 0.13, screenHeight * 0.05),
                                      backgroundColor: Colors.blue),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Confirmar',
                                    style: TextStyle(fontFamily: 'Roboto', fontSize: screenHeight * 0.02, color: Colors.white),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Text(
                    "Cambiar contraseña",
                    style: TextStyle(fontFamily: 'Roboto', fontSize: screenHeight * 0.03),
                    textAlign: TextAlign.center,
                  ),
                )


            ],)
          ),
        ],
      ),
      bottomNavigationBar: BarraMenu(selectedIndex: 5),
    );
  }
}