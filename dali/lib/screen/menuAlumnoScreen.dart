import 'package:dali/screen/historialAlumno.dart';
import 'package:dali/widget/botonCerrarSesion.dart';
import 'package:flutter/material.dart';

class MenuAlumnoScreen extends StatefulWidget {
  final String _username;
  const MenuAlumnoScreen({super.key,required String username}) : _username = username;

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
                      Semantics(label: "Botón de retorno", child:IconButton(
                        icon: Image(
                          image: const AssetImage('images/back-arrow.png'),
                          width: MediaQuery.of(context).size.width * 0.04,
                          height: MediaQuery.of(context).size.width * 0.04,
                        ),
                        onPressed: () => volverAtras(context),
                      )),
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
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    child: Semantics(label: "Botón de acceso al historial", child:_crearBoton(context, 'Historial', 'images/historial.png', () {
                      if (widget._username.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Historial(username: widget._username),
                          ),
                        );
                      } else {
                        // Mostrar un mensaje de error si el username está vacío o es nulo
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('El nombre de usuario es inválido')),
                        );
                      }
                    })),
                  ),
                )
              ],
            )));
  }

  Widget _crearBoton(BuildContext context, String texto, String iconoRuta,
      VoidCallback onPressed) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;


    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width: screenWidth * 0.18,
          height: screenHeight*0.35,
          padding: EdgeInsets.all(screenWidth * 0.02),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(screenHeight*0.04),
          ),
          child: Column(
            children: [
              Image.asset(
                iconoRuta,
                width: screenWidth * 0.1,
                height: screenHeight * 0.15,
                // fit: BoxFit.cover,
              ),
              // SizedBox(height: screenWidth * 0.02),
              Text(
                texto,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenHeight * 0.03,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          )),
    );
  }
}
