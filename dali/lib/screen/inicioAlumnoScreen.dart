import 'package:dali/tarea.dart';
import 'package:flutter/material.dart';

class InicioAlumnoScreen extends StatefulWidget {
  const InicioAlumnoScreen({super.key});

  @override
  State<InicioAlumnoScreen> createState() => _InicioAlumnoScreenState();
}

class _InicioAlumnoScreenState extends State<InicioAlumnoScreen> {
  final String _iconoPerfil = "images/panda.png";
  final Tarea _tarea = Tarea('¡Pongamos el microondas!', 'images/comedor.png');

  void accederTarea(BuildContext context) {
    // Navigator.of(context).pushNamed('/tarea');
  }

  void tareaAnterior() {
    // _tarea = Tarea('¡Pongamos el microondas!', 'images/comedor.png');
  }

  void tareaSiguiente() {
    // _tarea = Tarea('¡Pongamos el microondas!', 'images/comedor.png');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(screenWidth * 0.01),
            child: Column(
              children: [
                //Primera fila: Panda, Texto
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(_iconoPerfil,
                        width: screenWidth * 0.096,
                        height: screenHeight *
                            0.096), // Icono de perfil
                    Text('Agenda',
                        style: TextStyle(
                          fontSize: screenWidth * 0.08,
                          fontWeight: FontWeight.bold,
                        )),

                    const BotonMenu()
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),
                //Segunda fila: Botones de opciones
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Botón de Tarea
                    GestureDetector(
                      onTap: () {
                        accederTarea(context);
                      },
                      child: Container(
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.7,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(176, 211, 255, 1),
                          borderRadius: BorderRadius.circular(screenWidth * 0.07),
                        ),
                        child: Column(
                          children: [
                            Text("Hoy",
                                style: TextStyle(
                                    fontSize: screenWidth * 0.05,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto')),
                            SizedBox(height: screenWidth* 0.01),
                            SizedBox(
                              width: screenWidth * 0.9,
                              height: screenHeight * 0.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      //Flecha para la izquierda
                                        SizedBox(
                                          width: screenWidth * 0.1,
                                          child: IconButton(
                                          icon: Image.asset(
                                            'images/flecha-izquierda.png',
                                            fit: BoxFit.cover,
                                          ),
                                          iconSize: screenWidth * 0.1,
                                          onPressed: () {
                                            tareaAnterior();
                                          },
                                          ),
                                        ),
                                      Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  5, 153, 159, 1),
                                              borderRadius:
                                                  BorderRadius.circular(screenWidth * 0.02),
                                            ),
                                            width: screenWidth * 0.2,
                                            height: screenHeight * 0.3,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(screenWidth * 0.07),
                                              child: Image.asset(
                                                _tarea.imagen,
                                                fit: BoxFit
                                                    .cover, // Ensure the image fits the container
                                              ),
                                            ),
                                          ),
                                          Text(
                                            _tarea.nombre,
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.05,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Roboto',
                                            ),
                                          ),
                                        ],
                                      ),
                                      //Flecha para la derecha
                                      SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.1,
                                          child: IconButton(
                                          icon: Image.asset(
                                            'images/flecha-derecha.png',
                                            fit: BoxFit.cover,
                                          ),
                                          iconSize: MediaQuery.of(context).size.width * 0.1,
                                          onPressed: () {
                                            tareaSiguiente();
                                          },
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )));
  }
}


class BotonMenu extends StatelessWidget {
  const BotonMenu({super.key});

  void abrirMenu(BuildContext context) {
    // Navigator.of(context).pushNamed('/menuAlumno');
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
        children: [
          IconButton(
            icon: Image(
              image: const AssetImage('images/menu.png'),
              width: MediaQuery.of(context).size.width * 0.04,
              height: MediaQuery.of(context).size.width * 0.04,
            ),
            onPressed: () => abrirMenu(context),
          ),
          const Text('MENÚ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              )),
        ],
      ),
    );
  }
}
