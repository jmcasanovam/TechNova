import 'package:dali/screen/profeAlumnos.dart';
import 'package:dali/screen/profeMateriales.dart';
import 'package:dali/screen/profePerfil.dart';
import 'package:flutter/material.dart';

class BarraMenuProfe extends StatelessWidget {
  final String profe;
  final int selectedIndex;
  
  BarraMenuProfe({required this.selectedIndex, required this.profe});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;


    return Container(
      padding: EdgeInsets.only(top: screenHeight*0.02, bottom: screenHeight* 0.02),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(3, (index) {
          return SizedBox(
            width: screenWidth* 0.1,
            height: screenHeight * 0.15,
            child: FilledButton(

              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.02)),
                backgroundColor: selectedIndex == index ? Colors.blue : Colors.red,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    _getImagen(index),
                    width: screenWidth * 0.06,
                    height: screenHeight * 0.06,
                    color: Colors.white,
                  ),
                  SizedBox(
                      width: screenWidth * 0.2,
                      height: screenHeight * 0.05,
                      child: FittedBox(
                        child: Text(
                          _getNombre(index),
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
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => _getPantalla(index, profe)),
                );
              },
            ),
          );
        }),
      ),
    );
  }

  // Método para obtener el texto de cada botón basado en el índice
  String _getNombre(int index) {
    switch (index) {
      case 0:
        return 'Alumnos';
      case 1:
        return 'Pedir materiales';
      case 2:
        return 'Mi perfil';
      default:
        return '';
    }
  }
  String _getImagen(int index) {
    switch (index) {
      case 0:
        return 'images/alumnos.png';
      case 1:
        return 'images/lapiz.png';
      case 2:
        return 'images/usuario.png';
      default:
        return '';
    }
  }

  Widget _getPantalla(int index, String profe) {
    switch (index) {
      case 0:
        return ProfeUsuarios(profe : profe);
      case 1:
        return ProfeMateriales(profe : profe);
      case 2:
        return ProfePerfil(profe : profe);
      
      default:
        return Container(); // Pantalla vacía como fallback
    }
  }

}