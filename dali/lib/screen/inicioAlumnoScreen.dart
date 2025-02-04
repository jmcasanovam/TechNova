import 'package:dali/controlers/controladores.dart';
import 'package:dali/screen/comandasAlumno.dart';
import 'package:dali/screen/menuAlumnoScreen.dart';
import 'package:dali/models/tareaAsignada.dart';
import 'package:dali/screen/presentacionTarea.dart';
import 'package:flutter/material.dart';

class InicioAlumnoScreen extends StatefulWidget {
  String _iconoPerfil = '';
  String _username = '';
  InicioAlumnoScreen({super.key, required String iconoPerfil, required String username}) {
    _iconoPerfil = iconoPerfil;
    _username = username;
  }

  @override
  State<InicioAlumnoScreen> createState() => _InicioAlumnoScreenState();
}

class _InicioAlumnoScreenState extends State<InicioAlumnoScreen> {
  List<TareaAsignada> _tareas = [];
  
  int _tareaActual = 0;


  // onInitState() async{
  //   super.initState();
  //   setState(() async{
  //     List<TareaAsignada> aux = await _cargarTareas();
  //     _tareas = aux;
  //   });
  // }
  @override
void initState() {
  super.initState();
  _cargarTareas(); // Llamada a la carga de tareas sin usar setState dentro de la función async
}


  void accederTarea(BuildContext context) {
     if (_tareas.isNotEmpty) {
    if (_tareas.elementAt(_tareaActual).formato == 'menu') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ComandasAlumno()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PresentacionTarea(idTareaAsignada: _tareas.elementAt(_tareaActual).idTareaAsignada)),
      );
    }
  }
  }

 void tareaAnterior() {
  setState(() {
    if (_tareas.isNotEmpty && _tareaActual > 0) {
      _tareaActual--;
    } else if (_tareas.isNotEmpty) {
      _tareaActual = _tareas.length - 1;
    }
  });
}

void tareaSiguiente() {
  setState(() {
    if (_tareas.isNotEmpty && _tareaActual < _tareas.length - 1) {
      _tareaActual++;
    } else if (_tareas.isNotEmpty) {
      _tareaActual = 0;
    }
  });
}
  // Método para cargar y procesar las tareas
Future<void> _cargarTareas() async {
  try {
    final controladores = Controladores(); // Crear instancia de Controladores
    final List<TareaAsignada> tareas = await controladores.obtenerTareasNoCompletadas(widget._username);

    // Actualizar la lista de tareas
    setState(() {
      _tareas = tareas;
    });
  } catch (e) {
    print("Error al cargar las tareas: $e");
  }
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
                    Semantics(label: "Foto de Perfil",
                    child: Image.asset(widget._iconoPerfil,
                        width: screenWidth * 0.1,
                        height: screenHeight *
                            0.2),), // Icono de perfil
                    Text('Agenda',
                        style: TextStyle(
                          fontFamily: 'Roboto', 
                          fontSize: screenHeight * 0.08,
                          fontWeight: FontWeight.bold,
                        )),

                    Semantics(label: "Botón para acceder al menú", child: BotonMenu(username: widget._username)),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),
                //Segunda fila: Botones de opciones
                

                _tareas.isEmpty
                ? Semantics(label: "Tareas para hoy", child: Container(
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.5,
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
                            width: screenWidth * 0.7,
                            height: screenHeight * 0.3,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(
                                    5, 153, 159, 1),
                                borderRadius:
                                    BorderRadius.circular(screenWidth * 0.02),
                              ),
                              width: screenWidth * 0.2,
                              height: screenHeight * 0.3,
                              child: Text("No hay mas tareas!!", style: TextStyle(fontFamily: 'Roboto', fontSize: screenHeight*0.04),),
                            )
                          ),
                        ],
                      ),
                    )
                ,)
                :GestureDetector(
                    onTap: () {
                      accederTarea(context);
                    },
                    child: Semantics(label: "Tareas para hoy", child: Container(
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
                                        child: Semantics(label: "Botón Izquierda", child: IconButton(
                                        icon: Image.asset(
                                          'images/flecha-izquierda.png',
                                          fit: BoxFit.cover,
                                        ),
                                        iconSize: screenWidth * 0.1,
                                        onPressed: () {
                                          tareaAnterior();
                                        },
                                        ),)
                                      ),
                                    Column(
                                      children: [
                                        Semantics(label: "Botón acceso a tarea $_tareas.elementAt(_tareaActual).titulo",
                                        child: Container(
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
                                              _tareas.elementAt(_tareaActual).miniatura,
                                              width: screenWidth*0.16,
                                              height: screenHeight * 0.2,
                                            ),
                                          ),
                                        ),),
                                        Text(
                                          _tareas.elementAt(_tareaActual).titulo,
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
                                        child: Semantics(label: "Botón Derecha", child: IconButton(
                                        icon: Image.asset(
                                          'images/flecha-derecha.png',
                                          fit: BoxFit.cover,
                                        ),
                                        iconSize: MediaQuery.of(context).size.width * 0.1,
                                        onPressed: () {
                                          tareaSiguiente();
                                        },
                                        ),)
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),)
                  )
              ],
            )));
  }
}


class BotonMenu extends StatelessWidget {
String _username = '';
   BotonMenu({super.key,required String username}) {
    _username = username;
  }

  void abrirMenu(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  MenuAlumnoScreen(username: _username)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: MediaQuery.of(context).size.width * 0.085,
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
              color: Colors.white,
            ),
            onPressed: () => abrirMenu(context),
          ),
           Text('MENÚ',
              style: TextStyle(
                fontSize: screenHeight*0.035,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                color: Colors.white
              )),
        ],
      ),
    );
  }
}
