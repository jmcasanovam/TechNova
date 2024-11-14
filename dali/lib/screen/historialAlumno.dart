import 'package:dali/models/tarea.dart';
import 'package:flutter/material.dart';


class Historial extends StatefulWidget {
  const Historial({super.key});

  @override
  _HistorialState createState() => _HistorialState();
}
  // This widget is the root of your application.
class _HistorialState extends State<Historial> {

  void volverAtras(BuildContext context) {
    Navigator.of(context).pop();
  }

  final Tarea _tarea = Tarea('¡Pongamos el microondas!', 'images/comedor.png');
  final Tarea _tarea2 = Tarea ('Vamos a lavarnos las manos', 'images/feliz.png');

  @override
  void initState() {
    super.initState();
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
                //Primera fila: Back, Texto
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
                      ), // Icono de perfil
                    Text('Historial',
                        style: TextStyle(
                          fontSize: screenWidth * 0.08,
                          fontWeight: FontWeight.bold,
                        )),

                    SizedBox(width: screenWidth * 0.03)
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
                      },
                      child: Container(
                        width: screenWidth * 0.9,
                        //height: screenHeight * 0.7,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(176, 211, 255, 1),
                          borderRadius: BorderRadius.circular(screenWidth * 0.07),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: screenWidth* 0.01),
                            SizedBox(
                              width: screenWidth * 0.9,
                              height: screenHeight * 0.7,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                          },
                                          ),
                                        ),
                                      Column(
                                        children: [
                                          Container( //Espacio del día (si no cabe, continúa en la siguiente página)
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(5, 153, 159, 1),
                                              borderRadius: BorderRadius.circular(screenWidth * 0.02),
                                            ),
                                            width: screenWidth * 0.6,
                                            child: Column(
                                              children: [ 
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: screenWidth*0.05,
                                                    ),
                                                    Text(
                                                      "HOY",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: screenWidth * 0.03,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(//un Row + SizedBox por cada tarea mostrada en ESE día
                                                  children: [
                                                    SizedBox(
                                                      width: screenWidth*0.05,
                                                    ),
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(screenWidth * 0.07),
                                                      child: Image.asset(
                                                        _tarea.imagen,
                                                        fit: BoxFit.cover,
                                                        width: screenWidth * 0.1, // Ajusta el ancho de la imagen
                                                        height: screenHeight * 0.1, // Ajusta la altura de la imagen
                                                      ),
                                                    ),
                                                    SizedBox(width: screenWidth * 0.02), // Espacio entre la imagen y el texto
                                                    Expanded( // Para que el texto ocupe el resto del espacio
                                                      child: Text(
                                                        _tarea.nombre,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: screenWidth * 0.03,
                                                        ),
                                                        maxLines: 3, // Limita el texto a 3 líneas, si es necesario
                                                        overflow: TextOverflow.ellipsis, // Puntos suspensivos si el texto es largo
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: screenHeight*0.05,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: screenWidth*0.05,
                                                    ),
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(screenWidth * 0.07),
                                                      child: Image.asset(
                                                        _tarea2.imagen,
                                                        fit: BoxFit.cover,
                                                        width: screenWidth * 0.1, // Ajusta el ancho de la imagen
                                                        height: screenHeight * 0.1, // Ajusta la altura de la imagen
                                                      ),
                                                    ),
                                                    SizedBox(width: screenWidth * 0.02), // Espacio entre la imagen y el texto
                                                    Expanded( // Para que el texto ocupe el resto del espacio
                                                      child: Text(
                                                        _tarea2.nombre,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: screenWidth * 0.03,
                                                        ),
                                                        maxLines: 3, // Limita el texto a 3 líneas, si es necesario
                                                        overflow: TextOverflow.ellipsis, // Puntos suspensivos si el texto es largo
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: screenHeight*0.05,
                                                ),
                                              ],
                                            )

                                          ),
                                          SizedBox(
                                            height: screenHeight*0.01,
                                          ),                                         
                                          Container( //Espacio del día (si no cabe, continúa en la siguiente página)
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(5, 153, 159, 1),
                                              borderRadius: BorderRadius.circular(screenWidth * 0.02),
                                            ),
                                            width: screenWidth * 0.6,
                                            child: Column(
                                              children: [ 
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: screenWidth*0.05,
                                                    ),
                                                    Text(
                                                      "MAÑANA",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: screenWidth * 0.03,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(//un Row + SizedBox por cada tarea mostrada en ESE día
                                                  children: [
                                                    SizedBox(
                                                      width: screenWidth*0.05,
                                                    ),
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(screenWidth * 0.07),
                                                      child: Image.asset(
                                                        _tarea.imagen,
                                                        fit: BoxFit.cover,
                                                        width: screenWidth * 0.1, // Ajusta el ancho de la imagen
                                                        height: screenHeight * 0.1, // Ajusta la altura de la imagen
                                                      ),
                                                    ),
                                                    SizedBox(width: screenWidth * 0.02), // Espacio entre la imagen y el texto
                                                    Expanded( // Para que el texto ocupe el resto del espacio
                                                      child: Text(
                                                        _tarea.nombre,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: screenWidth * 0.03,
                                                        ),
                                                        maxLines: 3, // Limita el texto a 3 líneas, si es necesario
                                                        overflow: TextOverflow.ellipsis, // Puntos suspensivos si el texto es largo
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: screenHeight*0.05,
                                                ),
                                              ],
                                            )

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