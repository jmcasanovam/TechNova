import 'package:flutter/material.dart';
import 'package:dali/models/tareaAsignada.dart';
import 'package:dali/controlers/controladores.dart';
import 'package:intl/intl.dart';

class Historial extends StatefulWidget {
  final String _username;
  const Historial({super.key, required String username}) : _username = username;

  @override
  _HistorialState createState() => _HistorialState();
}

class _HistorialState extends State<Historial> {
  List<TareaAsignada> tareasCompletadas = [];
  List<List<TareaAsignada>> tareasAgrupadas = [];
  final Controladores controladores = Controladores();
  int diaActual = 0; // Variable para controlar el día actual

  @override
  void initState() {
    super.initState();
    _cargarTareas();
  }

  // Cargar tareas desde la API
  void _cargarTareas() async {
    try {
      // Obtener tareas usando el controlador
      List<TareaAsignada> tareas = await controladores.obtenerTareasMiniaturaTituloFechaCompletada(widget._username);

      // Filtrar tareas completadas
      List<TareaAsignada> completadas = tareas.where((t) => t.fechaCompletada != null).toList();

      // Ordenar las tareas por fecha de completado (más recientes primero)
      completadas.sort((a, b) {
        return a.fechaCompletada!.compareTo(b.fechaCompletada!);
      });

      // Agrupar tareas por día
      List<List<TareaAsignada>> agrupadas = [];
      bool _esMismoDia(DateTime fecha1, DateTime fecha2) {
        return fecha1.year == fecha2.year && fecha1.month == fecha2.month && fecha1.day == fecha2.day;
      }

      for (var tarea in completadas) {
        DateTime fechaTarea = tarea.fechaCompletada!;

        if (agrupadas.isEmpty || !_esMismoDia(fechaTarea, agrupadas.last.first.fechaCompletada!)) {
          agrupadas.add([tarea]);
        } else {
          agrupadas.last.add(tarea);
        }
      }

      // Actualizar el estado de la UI
      setState(() {
        tareasCompletadas = completadas;
        tareasAgrupadas = agrupadas;
      });
    } catch (e) {
      print('Error al cargar tareas: $e');
      // Mostrar mensaje de error si no se pueden cargar las tareas
      setState(() {
        tareasCompletadas = [];
        tareasAgrupadas = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (tareasAgrupadas.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text('No hay tareas disponibles para este usuario.'),
        ),
      );
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.01),
        child: Column(
          children: [
            // Primera fila: Back, Texto
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Image(
                    image: const AssetImage('images/back-arrow.png'),
                    width: screenWidth * 0.04,
                    height: screenWidth * 0.04,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Text('Historial',
                    style: TextStyle(
                      fontFamily: 'Roboto', 
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(width: screenWidth * 0.03)
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            // Segunda fila: Botones de opciones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Contenedor de tarea
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: screenWidth * 0.9,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Flecha para la izquierda
                                  SizedBox(
                                    width: screenWidth * 0.1,
                                    child: (diaActual == 0 || tareasAgrupadas.isEmpty)
                                        ? null
                                        : IconButton(
                                            icon: Image.asset(
                                              'images/flecha-izquierda.png',
                                              fit: BoxFit.cover,
                                            ),
                                            iconSize: screenWidth * 0.1,
                                            onPressed: () {
                                              setState(() {
                                                if (diaActual > 0) {
                                                  diaActual--; // Navegar al día anterior
                                                }
                                              });
                                            },
                                          ),
                                  ),
                                  Column(
                                    children: [
                                      // Mostrar el día y las tareas de ese día
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(5, 153, 159, 1),
                                          borderRadius: BorderRadius.circular(screenWidth * 0.02),
                                        ),
                                        width: screenWidth * 0.6,
                                        child: Column(
                                          children: [
                                            SizedBox(height: screenHeight * 0.01),
                                            Row(
                                              children: [
                                                SizedBox(width: screenWidth * 0.05),
                                                Text(
                                                  'Día: ${tareasAgrupadas.isNotEmpty ? DateFormat('dd/MM/yyyy').format(tareasAgrupadas[diaActual][0].fechaCompletada!) : ""}',
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto', 
                                                    color: Colors.white,
                                                    fontSize: screenWidth * 0.03,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                if (tareasAgrupadas.isNotEmpty && diaActual < tareasAgrupadas.length)
                                                  ...tareasAgrupadas[diaActual].map((tarea) => Row(
                                                        children: [
                                                          SizedBox(width: screenWidth * 0.05),
                                                          ClipRRect(
                                                            borderRadius: BorderRadius.circular(screenWidth * 0.07),
                                                            child: Image.asset(
                                                              tarea.miniatura,
                                                              width: screenWidth * 0.1,
                                                              height: screenHeight * 0.1,
                                                            ),
                                                          ),
                                                          SizedBox(width: screenWidth * 0.02),
                                                          Expanded(
                                                            child: Text(
                                                              tarea.titulo,
                                                              style: TextStyle(
                                                                fontFamily: 'Roboto', 
                                                                color: Colors.white,
                                                                fontSize: screenWidth * 0.03,
                                                              ),
                                                              maxLines: 3,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Flecha para la derecha
                                  SizedBox(
                                    width: screenWidth * 0.1,
                                    child: (diaActual == tareasAgrupadas.length - 1 || tareasAgrupadas.isEmpty)
                                        ? null
                                        : IconButton(
                                            icon: Image.asset(
                                              'images/flecha-derecha.png',
                                              fit: BoxFit.cover,
                                            ),
                                            iconSize: screenWidth * 0.1,
                                            onPressed: () {
                                              setState(() {
                                                if (diaActual < tareasAgrupadas.length - 1) {
                                                  diaActual++; // Navegar al siguiente día
                                                }
                                              });
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
            ),
          ],
        ),
      ),
    );
  }
}
