// import 'package:dali/screen/adminAlumnoTareas.dart';
// import 'package:dali/screen/adminCreadorTareas.dart';
// import 'package:dali/screen/adminEditarPerfil.dart';
// import 'package:dali/screen/adminEditarTareaPlantilla.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// import '../widget/barraMenu.dart';

// class AdminTareasPlantilla extends StatefulWidget {
//   @override
//   _AdminTareasPlantillaState createState() => _AdminTareasPlantillaState();
// }

// class _AdminTareasPlantillaState extends State<AdminTareasPlantilla> {
//   String? _ordenActual = 'Ordenar A-Z';
//   List<String> tareas = ['Poner lavadora', 'Abrir puerta', 'Limpiar los platos'];

//   @override
//   void initState(){
//     super.initState();
//     _ordenarLista();
//   }

//   void _ordenarLista() {
//     setState(() {
//       if (_ordenActual == 'Ordenar A-Z') {
//         tareas.sort((a, b) => a.compareTo(b));
//       } else {
//         tareas.sort((a, b) => b.compareTo(a));
//       }
//     });
//   }

//   void borrarTarea(int index) {
//     String nombreTarea = tareas[index];
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         final screenHeight = MediaQuery.of(context).size.height;
//         final screenWidth = MediaQuery.of(context).size.width;
//         return AlertDialog(
//           title: Text("Confirmación", style: TextStyle(fontSize: screenHeight * 0.03),),
//           content: Text("¿Seguro que quieres borrar la tarea \"$nombreTarea\"?", style: TextStyle(fontSize: screenHeight*0.025),),
//           actions: [
//             TextButton(
//               style: TextButton.styleFrom(
//                 backgroundColor: Colors.grey[200],
//                 minimumSize: Size(screenWidth*0.1, screenHeight*0.07),
//                 maximumSize: Size(screenWidth*0.1, screenHeight*0.07),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Cierra el diálogo
//               },
//               child: Text("No", style: TextStyle(fontSize: screenHeight*0.02, color: Colors.black),),
//             ),
//             TextButton(
//               style: TextButton.styleFrom(
//                 backgroundColor: Colors.red,
//                 minimumSize: Size(screenWidth*0.1, screenHeight*0.07),
//                 maximumSize: Size(screenWidth*0.1, screenHeight*0.07),
//               ),
//               onPressed: () {
//                 setState(() {
//                   tareas.removeAt(index); // Elimina la tarea del array
//                   //logica para borrar en la base de datos
//                 });
//                 Navigator.of(context).pop(); // Cierra el diálogo
//               },
//               child: Text("Sí", style: TextStyle(fontSize: screenHeight*0.02, color: Colors.white),),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     _ordenActual;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(

//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(bottom: screenHeight * 0.02, top: screenHeight * 0.02,),
//             child: SizedBox(
//               height: screenHeight * 0.1,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [

//                   Expanded(
//                     child: Center(
//                       child: FittedBox(
//                         child: Text(
//                           "Tareas Plantilla",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontFamily: 'Roboto',
//                             fontSize: screenHeight * 0.08,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             ),
//           ),

//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.only(right: screenWidth * 0.05, left: screenWidth * 0.05),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Botones de "Ordenar" y "Crear Tarea Plantilla"
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       //Boton desplegable ordenar
//                       Container(
//                         alignment: Alignment.center,
//                         width: screenWidth*0.1,
//                         height: screenHeight * 0.06,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(screenWidth * 0.01),
//                           color: Colors.green, // Color de fondo del contenedor
//                         ),
//                         child: DropdownButton<String>(
//                           value: _ordenActual,
//                           onChanged: (String? nuevoValor) {
//                             setState(() {
//                               _ordenActual = nuevoValor;
//                               _ordenarLista();
//                             });
//                           },
//                           items: <String>['Ordenar A-Z', 'Ordenar Z-A']
//                               .map<DropdownMenuItem<String>>((String valor) {
//                             return DropdownMenuItem<String>(
//                               value: valor,
//                               child: Text(valor),
//                             );
//                           }).toList(),
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontFamily: 'Roboto',
//                             fontSize: screenHeight * 0.02,
//                           ),
//                           icon: Icon(Icons.arrow_drop_down, color: Colors.white, size: screenWidth*0.02,),
//                           dropdownColor: Colors.green,
//                           borderRadius:  BorderRadius.circular(screenWidth * 0.01),
//                           underline: Container(height: 0,),
//                           // padding: EdgeInsets.only(left: screenWidth*0.02),
//                         ),
//                       ),

//                       //Boton de crear tarea plantilla
//                       ElevatedButton.icon(
//                         style: ElevatedButton.styleFrom(
//                           // fixedSize: Size(screenWidth*0.1, screenHeight * 0.06),
//                           minimumSize: Size(screenWidth*0.2, screenHeight * 0.06),
//                           maximumSize: Size(screenWidth*0.2, screenHeight * 0.06),
//                           backgroundColor: Colors.green,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(screenWidth * 0.01),
//                           ),
//                         ),
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => AdminCreadorTareas()),
//                           );
//                         },
//                         icon: Icon(Icons.add, color: Colors.white,size: screenWidth*0.02),
//                         label: Text(
//                           'Crear tarea plantilla',
//                           style: TextStyle(
//                             fontSize: screenHeight * 0.02,
//                             fontFamily: 'Roboto',
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   SizedBox(height: screenHeight * 0.02),

//                   // Lista de tareas

//                   Text("Tareas Plantilla", style: TextStyle(
//                     fontSize: screenHeight * 0.03,
//                     fontFamily: 'Roboto',
//                     color: Colors.black,
//                   ),),
//                   Divider(color: Colors.black, thickness: screenHeight*0.006,),
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(screenWidth * 0.01),
//                         color: Colors.grey[200], // Color de fondo del contenedor
//                       ),
//                       child: ListView.builder(
//                         padding: EdgeInsets.only(top: screenHeight * 0.01, bottom: screenHeight * 0.01, left: screenWidth * 0.01, right: screenWidth * 0.01),
//                         itemCount: tareas.length,
//                         itemBuilder: (context, index) {
//                           return Padding(
//                             padding: EdgeInsets.only(bottom: screenHeight * 0.01),
//                             child: Container(
//                               // height: screenHeight*0.07,
//                               decoration: BoxDecoration(
//                                 color: Colors.green,
//                                 borderRadius: BorderRadius.circular(screenWidth * 0.02),
//                               ),
//                               child: ListTile(
//                                 title: Text(tareas[index], style: TextStyle(fontSize: screenHeight * 0.03, fontWeight: FontWeight.bold,fontFamily: 'Roboto', color: Colors.white)),
//                                 trailing: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     TextButton(
//                                       onPressed: () {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) => AdminEditarTareaPlantilla(titulo: tareas[index]),
//                                           ),
//                                         );
//                                       },
//                                       style: TextButton.styleFrom(
//                                         backgroundColor: Colors.green[100]
//                                       ),
//                                       child: Text("Editar tarea plantilla", style: TextStyle(fontSize: screenHeight * 0.03, fontWeight: FontWeight.bold,fontFamily: 'Roboto', color: Colors.black)),
//                                     ),
//                                     SizedBox(width: screenWidth*0.01,),
//                                     TextButton(
//                                       onPressed: () {
//                                         borrarTarea(index);
//                                       },
//                                       style: TextButton.styleFrom(
//                                         backgroundColor: Colors.green[100]
//                                       ),
//                                       child: Text("Borrar tarea plantilla", style: TextStyle(fontSize: screenHeight * 0.03, fontWeight: FontWeight.bold,fontFamily: 'Roboto',  color: Colors.black)),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       // Barra de menú
//       bottomNavigationBar: BarraMenu(selectedIndex: 1,),
//     );
//   }
// }

import 'package:dali/screen/adminCreadorTareas.dart';
import 'package:dali/screen/adminEditarTareaPlantilla.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widget/barraMenu.dart';
import 'package:dali/controlers/controladores.dart';

class AdminTareasPlantilla extends StatefulWidget {
  @override
  _AdminTareasPlantillaState createState() => _AdminTareasPlantillaState();
}

class _AdminTareasPlantillaState extends State<AdminTareasPlantilla> {
  String? _ordenActual = 'Ordenar A-Z';
  List<Map<String, dynamic>> tareas = [];
  bool _isLoading = true; // Indicador de carga

  @override
  void initState() {
    super.initState();
    _cargarTareas();
  }

  Future<void> _cargarTareas() async {
    setState(() {
      _isLoading = true;
    });
    final List<Map<String, dynamic>> tareasCargadas =
        await Controladores().cargarTareasPlantilla();
    setState(() {
      tareas = tareasCargadas;
      _ordenarLista(); // Ordena después de cargar
      _isLoading = false;
    });
  }

  void _ordenarLista() {
    setState(() {
      if (_ordenActual == 'Ordenar A-Z') {
        tareas.sort((a, b) => a['titulo'].compareTo(b['titulo']));
      } else {
        tareas.sort((a, b) => b['titulo'].compareTo(a['titulo']));
      }
    });
  }

  void borrarTarea(int index) {
    String nombreTarea = tareas[index]['titulo'];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;
        return AlertDialog(
          title: Text(
            "Confirmación",
            style: TextStyle(fontSize: screenHeight * 0.03),
          ),
          content: Text(
            "¿Seguro que quieres borrar la tarea \"$nombreTarea\"?",
            style: TextStyle(fontSize: screenHeight * 0.025),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey[200],
                minimumSize: Size(screenWidth * 0.1, screenHeight * 0.07),
                maximumSize: Size(screenWidth * 0.1, screenHeight * 0.07),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: Text(
                "No",
                style: TextStyle(
                    fontSize: screenHeight * 0.02, color: Colors.black),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(screenWidth * 0.1, screenHeight * 0.07),
                maximumSize: Size(screenWidth * 0.1, screenHeight * 0.07),
              ),
              onPressed: () async {
                int id = tareas[index]['idTareaPlantilla'];

                int resultado = await _borrarTareaAsync(id, index);

                if (resultado != 200) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error al borrar la tarea'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Tarea borrada correctamente'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }

                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: Text(
                "Sí",
                style: TextStyle(
                    fontSize: screenHeight * 0.02, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<int> _borrarTareaAsync(int id, int index) async {
    try {
      int respuesta = await Controladores().borrarTareaPlantilla(id);

      if (respuesta == 200) {
        // Actualiza el estado después del borrado exitoso
        setState(() {
          tareas.removeAt(index); // Elimina la tarea localmente
        });
      }
      return respuesta; // Indica éxito
    } catch (e) {
      print("Error al borrar la tarea: $e");
      return 400; // Indica error
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: screenHeight * 0.02,
              top: screenHeight * 0.02,
            ),
            child: SizedBox(
              height: screenHeight * 0.1,
              child: Center(
                child: FittedBox(
                  child: Text(
                    "Tareas Plantilla",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontSize: screenHeight * 0.08,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Botones de "Ordenar" y "Crear Tarea Plantilla"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Botón desplegable ordenar
                      Container(
                        alignment: Alignment.center,
                        width: screenWidth * 0.1,
                        height: screenHeight * 0.06,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.01),
                          color: Colors.green,
                        ),
                        child: DropdownButton<String>(
                          value: _ordenActual,
                          onChanged: (String? nuevoValor) {
                            setState(() {
                              _ordenActual = nuevoValor;
                              _ordenarLista();
                            });
                          },
                          items: <String>['Ordenar A-Z', 'Ordenar Z-A']
                              .map<DropdownMenuItem<String>>((String valor) {
                            return DropdownMenuItem<String>(
                              value: valor,
                              child: Text(valor),
                            );
                          }).toList(),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontSize: screenHeight * 0.02,
                          ),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                            size: screenWidth * 0.02,
                          ),
                          dropdownColor: Colors.green,
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.01),
                          underline: Container(height: 0),
                        ),
                      ),
                      // Botón de crear tarea plantilla
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(screenWidth * 0.2, screenHeight * 0.06),
                          maximumSize:
                              Size(screenWidth * 0.2, screenHeight * 0.06),
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.01),
                          ),
                        ),
                        onPressed: () async {
                          final shouldReload = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminCreadorTareas()),
                          );

                          if (shouldReload == true) {
                            _cargarTareas();
                          }
                        },
                        icon: Icon(Icons.add,
                            color: Colors.white, size: screenWidth * 0.02),
                        label: Text(
                          'Crear tarea plantilla',
                          style: TextStyle(
                            fontSize: screenHeight * 0.02,
                            fontFamily: 'Roboto',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Lista de tareas
                  Text(
                    "Tareas Plantilla",
                    style: TextStyle(
                      fontSize: screenHeight * 0.03,
                      fontFamily: 'Roboto',
                      color: Colors.black,
                    ),
                  ),
                  Divider(color: Colors.black, thickness: screenHeight * 0.006),
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.01),
                              color: Colors.grey[200],
                            ),
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.01),
                              itemCount: tareas.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: screenHeight * 0.01),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(
                                          screenWidth * 0.02),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        tareas[index]['titulo'],
                                        style: TextStyle(
                                          fontSize: screenHeight * 0.03,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Roboto',
                                          color: Colors.white,
                                        ),
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextButton(
                                            onPressed: () async {
                                              final shouldReload =
                                                  await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AdminEditarTareaPlantilla(
                                                          idTareaPlantilla:
                                                              (tareas[index][
                                                                      'idTareaPlantilla'])
                                                                  .toString()),
                                                ),
                                              );
                                              if (shouldReload == true) {
                                                _cargarTareas();
                                              }
                                            },
                                            style: TextButton.styleFrom(
                                              backgroundColor:
                                                  Colors.green[100],
                                            ),
                                            child: Text(
                                              "Editar tarea plantilla",
                                              style: TextStyle(
                                                fontSize: screenHeight * 0.03,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Roboto',
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: screenWidth * 0.01),
                                          TextButton(
                                            onPressed: () {
                                              borrarTarea(index);
                                            },
                                            style: TextButton.styleFrom(
                                              backgroundColor:
                                                  Colors.green[100],
                                            ),
                                            child: Text(
                                              "Borrar tarea plantilla",
                                              style: TextStyle(
                                                fontSize: screenHeight * 0.03,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Roboto',
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BarraMenu(selectedIndex: 1),
    );
  }
}
