import 'package:flutter/material.dart';


class BotonCerrarSesion extends StatelessWidget {
  const BotonCerrarSesion({super.key});

  void cerrarSesion(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Semantics(
      label: 'Botón cerrar sesión',
      child: FilledButton(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.02)),
          backgroundColor: Colors.red,
          minimumSize: Size(screenWidth * 0.07, screenHeight * 0.15),
          maximumSize: Size(screenWidth * 0.07, screenHeight * 0.15),
        ),
        onPressed: () => cerrarSesion(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/boton-de-encendido-apagado.png',
              width: screenWidth * 0.035,
              height: screenHeight * 0.05,
              color: Colors.white,
            ),
            SizedBox(height: screenHeight*0.006),
            SizedBox(
                width: screenHeight * 0.2,
                child: FittedBox(
                  child: Text(
                    "CERRAR",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontSize: screenHeight * 0.01,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
