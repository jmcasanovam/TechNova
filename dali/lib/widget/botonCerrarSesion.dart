import 'package:flutter/material.dart';


class BotonCerrarSesion extends StatelessWidget {
  const BotonCerrarSesion({super.key});

  void cerrarSesion(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.07,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10), // Bordes redondeados
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Image(
              image: const AssetImage('images/boton-de-encendido-apagado.png'),
              color: Colors.white,
              width: MediaQuery.of(context).size.width * 0.04,
              height: MediaQuery.of(context).size.width * 0.04,
            ),
            onPressed: () => cerrarSesion(context),
          ),
          Text('CERRAR',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.01,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}
