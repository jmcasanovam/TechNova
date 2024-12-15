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

  final controladores = Controladores(); // Crear instancia de Controladores
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
          Semantics(
            label: "imagen del perfil",
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.01),
              child: Image.asset(
                widget.image,
                width: screenWidth * 0.1,
                height: screenHeight * 0.2,
              ),
            ),
          ),

          //Bloque de botones
          Semantics(
            label: 'Botones para introducir contraseñas',
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.1),
              child: Column(
                children: [
                  // Botones de formas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Semantics(
                        label: 'Botón círculo rojo',
                        child: ShapeButton(
                          icon: Icons.circle_outlined,
                          color: Colors.red,
                          onPressed: () => addShape('circle'),
                        ),
                      ),
                      Semantics(
                        label: 'Botón cuadrado azul',
                        child: ShapeButton(
                          icon: Icons.square_outlined,
                          color: Colors.blue,
                          onPressed: () => addShape('square'),
                        ),
                      ),
                      Semantics(
                        label: 'Botón triángulo naranja',
                        child: ShapeButton(
                          icon: Icons.change_history, // Triángulo
                          color: Colors.orange,
                          onPressed: () => addShape('triangle'),
                        ),
                      ),
                      Semantics(
                        label: 'Botón estrella verde',
                        child: ShapeButton(
                          icon: Icons.star_border,
                          color: Colors.green,
                          onPressed: () => addShape('star'),
                        ),
                      ),
                    ],
                  ),
            
                  // Casillas de contraseña
                  Semantics(
                    label: 'Casillas de contraseña',
                    child: Row(
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
                  ),
            
                  Row(
                    children: [
                      Column(
                        children: [
                          Semantics(
                            label: 'Botón borrar',
                            child: IconButton(
                              icon: const Icon(Icons.close, color: Colors.red),
                              iconSize: screenHeight * 0.17,
                              onPressed: clearShapes,
                            ),
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
                      Semantics(
                        label: 'Botón para confirmar la contraseña',
                        child: ElevatedButton(
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
                                 // Llamar al método login_estudiante y obtener el resultado
                                              bool isLoginSuccessful = await controladores.login_estudiante(widget.username, enteredShapes.join());

                                              if (isLoginSuccessful) {
                                                // Navegar a la pantalla de inicio del alumno
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => InicioAlumnoScreen(iconoPerfil: widget.image, username: widget.username),
                                                  ),
                                                );
                                              } else {
                                                // Manejar el fallo de inicio de sesión
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text('Te has equivocado. Inténtalo de nuevo.')),
                                                );

                                                // Limpiar las casillas
                                                clearShapes();
                                              }
                                    
                             
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
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),

          // Boton de cerrar sesion
          // Semantics(
          //   label: 'Botón cerrar sesión',
          //   child: Padding(
          //     padding: EdgeInsets.only(
          //         right: screenWidth * 0.05, top: screenHeight * 0.02),
          //     child: const FittedBox(child: BotonCerrarSesion()),
          //   ),
          // )
          Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.02, top: screenHeight * 0.02,),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenHeight*0.1),
              child: SizedBox(
                height: screenHeight*0.1,
                child: BotonCerrarSesion()
                ),
            ),
          ),
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

