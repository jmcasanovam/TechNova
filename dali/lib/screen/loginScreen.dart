import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'loginAlumnos.dart';


class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFF).withOpacity(1),
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
            FilledButton(
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                  Image.asset('images/alumno.png',
                    width: screenWidth * 0.15,
                    height: screenHeight * 0.2,
                    ),
                  const SizedBox(width: 15),
                  SizedBox(
                    width: screenWidth * 0.4,
                    child : const FittedBox(
                      child: Text(
                        "ALUMNOS",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                        ),
                    )
                  )
                ],
              ),
            ),
      
            const SizedBox(height: 15),
      
            // Filas para botones de abajo
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Botón configuracion
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * (0.15/2)),
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      backgroundColor: Colors.red,
                      fixedSize: Size(screenWidth * 0.08, screenWidth * 0.08),
                    ),
                    onPressed: () {},
                    child: Image.asset('images/ajustes.png', height: screenWidth * 0.07),
                  ),
                ),
                
                // Botón "Profesor"
                Padding(
                  padding: EdgeInsets.only(right: screenWidth * (0.15/2)),
                  child: SizedBox(
                    width: screenWidth * 0.21,
                    height: screenHeight * 0.15, 
                    child: TextButton(
                      onPressed: () {},
                      
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset('images/profesor.png', height: screenWidth * 0.1),
                          SizedBox(
                            width: screenWidth * 0.1,
                            child : const FittedBox(
                              child: Text(
                                "Profesor",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.black, 
                                ), 
                                textAlign: TextAlign.right
                                ),
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}