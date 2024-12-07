import 'package:dali/models/tareaAsignada.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


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

  List<List<TareaAsignada>> paginarTareas(List<TareaAsignada> tareas, int tamanioPagina) {
    List<List<TareaAsignada>> paginas = [];
    for (int i = 0; i < tareas.length; i += tamanioPagina) {
      paginas.add(tareas.sublist(i, i + tamanioPagina > tareas.length ? tareas.length : i + tamanioPagina));
    }
    return paginas;
  }

  List<List<TareaAsignada>> dias = [[
      TareaAsignada('¡Pongamos el microondas!', 'images/comedor.png'),
      TareaAsignada('Vamos a lavarnos las manos', 'images/feliz.png'),
    ],[
      TareaAsignada('¡Pongamos el microondas!', 'images/microondas.png'),
      TareaAsignada('Vamos a lavarnos las manos', 'images/feliz.png'),
      TareaAsignada('Tomar comandas', 'images/comedor.png'),
    ],
    [
      TareaAsignada('¡Pongamos el microondas!', 'images/microondas.png'),
      TareaAsignada('Vamos a lavarnos las manos', 'images/feliz.png'),
      TareaAsignada('Tomar comandas', 'images/comedor.png'),
      TareaAsignada('¡Pongamos el microondas!', 'images/microondas.png'),
      TareaAsignada('Vamos a lavarnos las manos', 'images/feliz.png'),
            TareaAsignada('¡Pongamos el microondas!', 'images/microondas.png'),
      TareaAsignada('Vamos a lavarnos las manos', 'images/feliz.png'),
            TareaAsignada('¡Pongamos el microondas!', 'images/microondas.png'),
      TareaAsignada('Vamos a lavarnos las manos', 'images/feliz.png'),
    ]
  ];

  int dia_actual = 0;
  int dias_totales = 3;
  int hoy = 0; //constante (porque el día de hoy siempre será el primero)
  List<String> fechas = [DateFormat('dd/MM/yy').format(DateTime(2024, 02, 12)), DateFormat('dd/MM/yy').format(DateTime(2024, 02, 11)), DateFormat('dd/MM/yy').format(DateTime(2024, 02, 10))];

  int pagina_actual = 0; //página dentro del día

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
                        //height: screenHeight * 0.61,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(176, 211, 255, 1),
                          borderRadius: BorderRadius.circular(screenWidth * 0.07),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: screenWidth * 0.9,
                              height: screenHeight * 0.6,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox( //flecha arriba
                                    width: screenWidth * 0.06,
                                    child:pagina_actual==0?null:IconButton(
                                    icon: Image.asset(
                                      'images/flecha-arriba.png',
                                      fit: BoxFit.cover,
                                    ),
                                    iconSize: screenWidth * 0.05,
                                    onPressed: () {
                                      setState(() {
                                        if (pagina_actual > 0)
                                          pagina_actual--; // Navegar a la página anterior
                                      });
                                    },
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      //Flecha para la izquierda
                                        SizedBox(
                                          width: screenWidth * 0.1,
                                          child:dia_actual==hoy?null:IconButton(
                                          icon: Image.asset(
                                            'images/flecha-izquierda.png',
                                            fit: BoxFit.cover,
                                          ),
                                          iconSize: screenWidth * 0.1,
                                          onPressed: () {
                                            setState(() {
                                              if (dia_actual > 0) {
                                                dia_actual--; // Navegar a la página anterior
                                              } else {
                                                dia_actual = (dia_actual - 1 + dias_totales) % dias_totales;
                                              }
                                                pagina_actual = 0; // Ir a la primera página del nuevo día
                                            });
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
                                                SizedBox(height: screenHeight*0.01,),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: screenWidth*0.05,
                                                    ),
                                                    Text(
                                                      dia_actual == hoy ? "HOY" : fechas[dia_actual],
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: screenWidth * 0.03,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                
                                                //for (var tarea in paginarTareas(dias[dia_actual], 1)[pagina_actual])
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          SizedBox(width: screenWidth * 0.05),
                                                          ClipRRect(
                                                            borderRadius: BorderRadius.circular(screenWidth * 0.07),
                                                            child: Image.asset(
                                                              dias[dia_actual][pagina_actual].imagen,
                                                              width: screenWidth * 0.1,
                                                              height: screenHeight * 0.1,
                                                            ),
                                                          ),
                                                          SizedBox(width: screenWidth * 0.02),
                                                          Expanded(
                                                            child: Text(
                                                              dias[dia_actual][pagina_actual].nombre,
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: screenWidth * 0.03,
                                                              ),
                                                              maxLines: 3,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: screenHeight * 0.05),
                                                    ],
                                                  ),
                                              ],
                                            )

                                          ),                                
                                        ],
                                      ),
                                      //Flecha para la derecha
                                      SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.1,
                                          child: dia_actual==dias_totales-1?null:IconButton(
                                          icon: Image.asset(
                                            'images/flecha-derecha.png',
                                            fit: BoxFit.cover,
                                          ),
                                          iconSize: MediaQuery.of(context).size.width * 0.1,
                                          onPressed: () {
                                            setState(() {
                                              if (dia_actual < dias.length - 1) {
                                                dia_actual++; // Navegar a la siguiente página
                                              } else {
                                                dia_actual = (dia_actual + 1) % dias_totales; // Navegar al siguiente día
                                              }
                                              pagina_actual = 0; // Ir a la primera página del nuevo día

                                            });
                                          },
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox( //flecha hacia abajo
                                    width: screenWidth * 0.06,
                                    child:pagina_actual==dias[dia_actual].length - 1?null:IconButton(
                                    icon: Image.asset(
                                      'images/flecha-abajo.png',
                                      fit: BoxFit.cover,
                                    ),
                                    iconSize: screenWidth * 0.05,
                                    onPressed: () {
                                      setState(() {
                                        List<List<TareaAsignada>> paginas = paginarTareas(dias[dia_actual], 1);
                                        if (pagina_actual < paginas.length - 1)
                                          pagina_actual++; // Navegar a la página siguiente
                                      });
                                    },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )));
  }
}