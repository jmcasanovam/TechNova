import 'package:flutter/material.dart';

class BarraMenu extends StatelessWidget {
  final int selectedIndex;
  
  BarraMenu({required this.selectedIndex,});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;


    return Container(
      padding: EdgeInsets.only(top: screenHeight*0.02, bottom: screenHeight* 0.02),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(6, (index) {
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
                Navigator.pushReplacementNamed(context, _getEnlace(index));
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
        return 'Editar tarea';
      case 2:
        return 'Asignar tarea';
      case 3:
        return 'Menu';
      case 4:
        return 'Chats';
      case 5:
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
        return 'images/tarea-nueva.png';
      case 2:
        return 'images/tarea.png';
      case 3:
        return 'images/menus.png';
      case 4:
        return 'images/chat.png';
      case 5:
        return 'images/usuario.png';
      default:
        return '';
    }
  }

  String _getEnlace(int index) {
    switch (index) {
      case 0:
        return '/adminUsuarios';
      case 1:
        return '/adminCreadorTareas';
      case 2:
        return '/adminAsignarTarea';
      case 3:
        return '/adminMenus';
      case 4:
        return '/adminChats';
      case 5:
        return '/adminPerfil';
      default:
        return '';
    }
  }

}
