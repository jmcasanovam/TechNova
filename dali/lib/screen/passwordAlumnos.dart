import 'package:dali/controlers/controladores.dart';
import 'package:dali/screen/inicioAlumnoScreen.dart';
import 'package:dali/widget/botonCerrarSesion.dart';
import 'package:flutter/material.dart';

class PasswordAlumnos extends StatefulWidget {
  final String image; // Ruta de la imagen seleccionada
  final String username;

  const PasswordAlumnos(
      {super.key, required this.image, required this.username});

  @override
  _PasswordAlumnosState createState() => _PasswordAlumnosState();
}

class _PasswordAlumnosState extends State<PasswordAlumnos> {
  List<String> enteredShapes = [
    '',
    '',
    ''
  ]; // Lista para las formas seleccionadas

  // Método para agregar una forma en la primera casilla vacía
  void addShape(String shape) {
    setState(() {
      for (int i = 0; i < enteredShapes.length; i++) {
        if (enteredShapes[i] == '') {
          enteredShapes[i] = shape;
          break;
        }
      }
    });
  }

  // Método para limpiar las casillas
  void clearShapes() {
    setState(() {
      enteredShapes = ['', '', ''];
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Imagen del perfil
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.01),
            child: Image.asset(
              widget.image,
              width: screenWidth * 0.1,
              height: screenHeight * 0.2,
            ),
          ),

          //Bloque de botones
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.1),
            child: Column(
              children: [
                // Botones de formas
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShapeButton(
                      icon: Icons.circle_outlined,
                      color: Colors.red,
                      onPressed: () => addShape('circle'),
                    ),
                    ShapeButton(
                      icon: Icons.square_outlined,
                      color: Colors.blue,
                      onPressed: () => addShape('square'),
                    ),
                    ShapeButton(
                      icon: Icons.change_history, // Triángulo
                      color: Colors.orange,
                      onPressed: () => addShape('triangle'),
                    ),
                    ShapeButton(
                      icon: Icons.star_border,
                      color: Colors.green,
                      onPressed: () => addShape('star'),
                    ),
                  ],
                ),

                // Casillas de contraseña
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return Container(
                      margin: EdgeInsets.only(
                        left: screenWidth * 0.02,
                        right: screenWidth * 0.02,
                        top: screenHeight * 0.04,
                        bottom: screenHeight * 0.04,
                      ),
                      width: screenWidth * 0.15,
                      height: screenHeight * 0.30,
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: enteredShapes[index] != ''
                          ? Icon(
                              _getIconForShape(enteredShapes[index]),
                              size: screenWidth * 0.1,
                              color: _colorIcono(enteredShapes[index]),
                            )
                          : null,
                    );
                  }),
                ),

                Row(
                  children: [
                    Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          iconSize: screenHeight * 0.17,
                          onPressed: clearShapes,
                        ),
                        Text(
                          "BORRAR",
                          style: TextStyle(
                            fontSize: screenHeight * 0.03,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                        style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          backgroundColor: Colors.red,
                          minimumSize:
                              Size(screenWidth * 0.2, screenHeight * 0.2),
                          maximumSize:
                              Size(screenWidth * 0.2, screenHeight * 0.2),
                        ),
                        onPressed: () async {
                          // int result = await login(widget.username, enteredShapes.join());

                          // if (result == 200) {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => InicioAlumnoScreen(iconoPerfil: widget.image)),
                          //   );
                          // } else {
                          //   // Handle login failure (e.g., show an error message)
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(content: Text('Te has equivocado. Inténtalo de nuevo.')),
                          //   );

                          //   clearShapes();
                          // }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    InicioAlumnoScreen(iconoPerfil: widget.image))
                          );
                        },
                        child: SizedBox(
                            width: screenWidth * 0.16,
                            child: const FittedBox(
                              child: Text(
                                "CONFIRMAR",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ))),
                  ],
                )
              ],
            ),
          ),

          //Boton de cerrar sesion
          Padding(
            padding: EdgeInsets.only(
                right: screenWidth * 0.05, top: screenHeight * 0.02),
            child: const FittedBox(child: BotonCerrarSesion()),
          )
        ],
      ),
    );
  }

  // Método para obtener el icono correspondiente a la forma
  IconData _getIconForShape(String shape) {
    switch (shape) {
      case 'circle':
        return Icons.circle_outlined;
      case 'square':
        return Icons.square_outlined;
      case 'triangle':
        return Icons.change_history;
      case 'star':
        return Icons.star_border;
      default:
        return Icons.help_outline;
    }
  }

  Color _colorIcono(String shape) {
    switch (shape) {
      case 'circle':
        return Colors.red;
      case 'square':
        return Colors.blue;
      case 'triangle':
        return Colors.orange;
      case 'star':
        return Colors.green;
      default:
        return Colors.black;
    }
  }
}

// Widget personalizado para los botones de formas
class ShapeButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  ShapeButton(
      {required this.icon, required this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return IconButton(
      icon: Icon(icon, color: color),
      iconSize: screenWidth * 0.1,
      onPressed: onPressed,
    );
  }
}
