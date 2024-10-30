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
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            child: Column(
              children: [
                //Primera fila: Panda, Texto
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(_iconoPerfil,
                        width: MediaQuery.of(context).size.width * 0.096,
                        height: MediaQuery.of(context).size.width *
                            0.096), // Icono de perfil
                    const Text('Agenda',
                        style: TextStyle(
                          fontSize: 128,
                          fontWeight: FontWeight.bold,
                        )),

                    const BotonMenu()
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.02),
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
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(176, 211, 255, 1),
                          borderRadius: BorderRadius.circular(63),
                        ),
                        child: Column(
                          children: [
                            const Text("Hoy",
                                style: TextStyle(
                                    fontSize: 64,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto')),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.01),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: MediaQuery.of(context).size.width * 0.2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      //Flecha para la izquierda
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.1,
                                          child: IconButton(
                                          icon: Image.asset(
                                            'images/flecha-izquierda.png',
                                            fit: BoxFit.cover,
                                          ),
                                          iconSize: MediaQuery.of(context).size.width * 0.1,
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
                                                  BorderRadius.circular(63),
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.15,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.15, // Ensure the container is square
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(63),
                                              child: Image.asset(
                                                _tarea.imagen,
                                                fit: BoxFit
                                                    .cover, // Ensure the image fits the container
                                              ),
                                            ),
                                          ),
                                          Text(
                                            _tarea.nombre,
                                            style: const TextStyle(
                                              fontSize: 64,
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

void cerrarSesion(BuildContext context) {
  // Navigator.of(context).pushReplacementNamed('/login');
}

class BotonMenu extends StatelessWidget {
  const BotonMenu({super.key});

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
            onPressed: () => cerrarSesion(context),
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
