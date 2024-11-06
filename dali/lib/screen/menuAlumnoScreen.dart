import 'package:dali/screen/inicioAlumnoScreen.dart';
import 'package:flutter/material.dart';

class MenuAlumnoScreen extends StatefulWidget {
  const MenuAlumnoScreen({super.key});

  @override
  State<MenuAlumnoScreen> createState() => _MenuAlumnoScreenState();
}

class _MenuAlumnoScreenState extends State<MenuAlumnoScreen> {
  bool _tareaComedor = false;
  
  void volverAtras(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(screenWidth * 0.01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Image(
                          image: const AssetImage('images/back-arrow.png'),
                          width: MediaQuery.of(context).size.width * 0.04,
                          height: MediaQuery.of(context).size.width * 0.04,
                        ),
                        onPressed: () => volverAtras(context),
                      ),
                      Text(
                        'Menú',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: screenWidth * 0.08,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // 
                      const BotonCerrarSesion(),
                    ]),
                Center(
                  child: Column(
                    children: [
                      if (!_tareaComedor)
                      Padding(
                        padding: EdgeInsets.only(top: screenWidth * 0.1),
                        child: _crearBoton(context, 'Historial', 'images/historial.png', () {
                        setState(() {
                          _tareaComedor = !_tareaComedor;
                        });
                        }),
                      )
                      else ...[
                      _crearBoton(context, 'Historial', 'images/historial.png', () {
                        setState(() {
                        _tareaComedor = !_tareaComedor;
                        });
                      }),
                      SizedBox(height: screenWidth * 0.02),
                      _crearBoton(context, 'Comedor', 'images/comedor.png', () {
                        
                      }),
                      ],
                    ],
                  )
                )
              ],
            )));
  }

  Widget _crearBoton(BuildContext context, String texto, String iconoRuta, VoidCallback onPressed){
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: screenWidth * 0.18,
        padding: EdgeInsets.all(screenWidth * 0.02),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),

        child: Column(
          children: [
            Image.asset(
              iconoRuta,
              width: screenWidth * 0.1,
              height: screenWidth * 0.1,
              fit: BoxFit.cover,
            ),
            // SizedBox(height: screenWidth * 0.02),
            Text(
              texto,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.03,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
          ],
        )
      ),
    );
  }
}

class BotonCerrarSesion extends StatelessWidget {
  const BotonCerrarSesion({super.key});

  void cerrarSesion(BuildContext context) {
    // Navigator.of(context).pushReplacementNamed('/login');
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
              )),
        ],
      ),
    );
  }
}
