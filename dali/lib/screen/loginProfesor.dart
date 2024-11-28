import 'package:dali/screen/adminUsuarios.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginProfesor extends StatefulWidget {
  @override
  _LoginProfesorState createState() => _LoginProfesorState();
}


class _LoginProfesorState extends State<LoginProfesor> {
  bool _oculto = true;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

          // caja cuestionario
          Container(
            width: screenWidth * 0.8,
            height: screenHeight * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(screenWidth * 0.01),
              color: Colors.red, // Color de fondo del contenedor
            ),
            // cuestionario
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Campo de Nickname
                Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.05, left: screenWidth * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nickname:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenHeight * 0.03,
                        ),
                      ),
                      // SizedBox(width: screenWidth * 0.02),
                      SizedBox(
                        width: screenWidth * 0.6,
                        child: TextField(
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenHeight * 0.03,
                          ),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white), borderRadius:BorderRadius.circular(screenWidth * 0.01)),
                            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white), borderRadius:BorderRadius.circular(screenWidth * 0.01)),
                            hintText: 'Ingrese su nickname',
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: screenHeight * 0.03,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.05),

                // Campo de Contraseña
                Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.05, left: screenWidth * 0.05),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Contraseña:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenHeight * 0.03,
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.6,
                        child: TextField(
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenHeight * 0.03,

                          ),
                          obscureText: _oculto,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white), borderRadius:BorderRadius.circular(screenWidth * 0.01)),
                            focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white), borderRadius:BorderRadius.circular(screenWidth * 0.01)),
                            hintText: 'Ingrese su contraseña',
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: screenHeight * 0.03,
                            ),
                            suffixIcon: IconButton(
                              icon: _oculto?Icon(Icons.visibility, color: Colors.white, size: screenWidth * 0.03):Icon(Icons.visibility_off, color: Colors.white, size: screenWidth * 0.03),
                              onPressed: (){
                                setState((){
                                  _oculto=!_oculto;
                                });
                              } ,
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          SizedBox(height: screenHeight * 0.05),
          // Botón de Confirmar
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.08,
                vertical: screenHeight * 0.035,
              ),
              backgroundColor: Colors.red, // Color del botón
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AdminUsuarios()),
              );
            },
            child: Text(
              'Confirmar',
              style: TextStyle(
                fontSize: screenHeight * 0.03,
                color: Colors.white,
              ),
            ),
          )
        ],)
      ),
    );
  }
}


