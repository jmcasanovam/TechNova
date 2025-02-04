import 'package:dali/screen/loginProfesor.dart';
import 'package:flutter/material.dart';
import 'loginAlumnos.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0x0fffffff).withOpacity(1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // imagen logo
            Image.asset(
              'images/logoapp_general.png',
              width: screenWidth * 0.2,
              height: screenHeight * 0.25,
              semanticLabel: 'Logo Aplicacion',
            ),

            // Botón "Alumnos"
            Semantics(
              label: 'Botón Alumnos',
              child: FilledButton(
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.02)),
                  backgroundColor: Colors.red,
                  minimumSize: Size(screenWidth * 0.75, screenHeight * 0.45),
                  maximumSize: Size(screenWidth * 0.85, screenHeight * 0.45),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginAlumnos()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/alumno.png',
                      width: screenWidth * 0.15,
                      height: screenHeight * 0.2,
                    ),
                    const SizedBox(width: 15),
                    SizedBox(
                        width: screenWidth * 0.4,
                        child: FittedBox(
                          child: Text(
                            "ALUMNOS",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: screenWidth * 0.08,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.02),

                // Botón "Profesor"
                Semantics(
                  label: 'Botón Profesor',
                  child: Padding(
                    padding: EdgeInsets.only(right: screenWidth * (0.15 / 2)),
                    child: SizedBox(
                      width: screenWidth * 0.25,
                      height: screenHeight * 0.15,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginProfesor()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('images/profesor.png',
                                height: screenWidth * 0.1),
                            SizedBox(
                                width: screenWidth * 0.1,
                                child: FittedBox(
                                  child: Text("Profesor",
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.black,
                                        fontFamily: 'Roboto',
                                        fontSize: screenWidth * 0.08,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.right),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ),
    );
  }
}

