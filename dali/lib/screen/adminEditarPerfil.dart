import 'package:dali/models/usuario.dart';
import 'package:dali/widget/adminTitulo.dart';
import 'package:flutter/material.dart';
import 'dart:convert'; // Para serializar los datos
import 'package:dali/controlers/controladores.dart';

import '../widget/barraMenu.dart';

class AdminEditarPerfil extends StatefulWidget {
  final String nickname;

  AdminEditarPerfil({required this.nickname});

  @override
  _AdminEditarPerfilState createState() => _AdminEditarPerfilState();
}

class _AdminEditarPerfilState extends State<AdminEditarPerfil> {
  String nombre = '';
  String? formatoSeleccionado = 'Texto';
  String? notificacionSeleccionada = 'Default';
  String? contrasenaSeleccionada1 = 'Cuadrado';
  String? contrasenaSeleccionada2 = 'Cuadrado';
  String? contrasenaSeleccionada3 = 'Cuadrado';
    final Controladores controladores = Controladores();

  List<String> formatos = ['Texto', 'Video', 'Imagen', 'Pictograma', 'Audio'];
  List<String> preferenciasNotificacion = ['Default', 'Mensaje', 'Mensaje+Audio'];
  List<String> opcionesContrasena = ['Cuadrado', 'Triángulo', 'Círculo', 'Cruz'];
  String foto = 'images/panda.png';

  late Usuario? usuario;

  @override
  void initState() {
    super.initState();
    _cargarDatosUsuario();
  }

  void _cargarDatosUsuario() async {
    usuario = await controladores.getInfoEstudiante2(widget.nickname);

    if(usuario == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al cargar los datos del usuario.")),
      );
      return;
    }

    setState(() {
      nombre = usuario!.nombre;
      formatoSeleccionado = usuario!.formato;
      print("El formato es ${usuario!.formato}");
      print(usuario!.preferenciasNotificacion);
      notificacionSeleccionada = usuario!.preferenciasNotificacion;
      
    });
  }

  

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          AdminTitulo(atras: true, titulo: "Editar Perfil"),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nombre
                          Row(
                            children: [
                              Text(
                                'Nombre:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenHeight * 0.025,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              SizedBox(
                                width: screenWidth * 0.2,
                                child: TextField(
                                  controller: TextEditingController(text: nombre),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: screenHeight * 0.025,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      nombre = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.02),
                  
                          // Desplegable de Formato
                          Row(
                            children: [
                              Text(
                                'Formato:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenHeight * 0.025,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              DropdownButton<String>(
                                value: formatoSeleccionado,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    formatoSeleccionado = newValue;
                                  });
                                },
                                items: formatos.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                style: TextStyle(
                                  fontSize: screenHeight * 0.02,
                                  color: Colors.black,
                                ),
                                icon: Icon(Icons.arrow_drop_down, size: screenHeight * 0.04),
                                underline: Container(height: 0),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.02),
                  
                          // Preferencias de Notificación
                          Row(
                            children: [
                              Text(
                                'Preferencias de Notificación:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenHeight * 0.025,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              DropdownButton<String>(
                                value: notificacionSeleccionada,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    notificacionSeleccionada = newValue;
                                  });
                                },
                                items: preferenciasNotificacion.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                style: TextStyle(
                                  fontSize: screenHeight * 0.02,
                                  color: Colors.black,
                                ),
                                icon: Icon(Icons.arrow_drop_down, size: screenHeight * 0.04),
                                underline: Container(height: 0),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          // Contraseña
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Contraseña:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenHeight * 0.025,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Container(
                                alignment: Alignment.center,
                                width: screenWidth*0.1,
                                height: screenHeight * 0.06,
                                decoration: BoxDecoration(  
                                  borderRadius: BorderRadius.circular(screenWidth * 0.01),
                                  color: Colors.grey[200], // Color de fondo del contenedor
                                ),
                                child: DropdownButton<String>(
                                  value: contrasenaSeleccionada1,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      contrasenaSeleccionada1 = newValue;
                                    });
                                  },
                                  items: opcionesContrasena.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: screenHeight * 0.02,
                                    color: Colors.black,
                                  ),
                                  icon: Icon(Icons.arrow_drop_down, size: screenHeight*0.04,), 
                                  borderRadius:  BorderRadius.circular(screenWidth * 0.01), 
                                  underline: Container(height: 0,),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.01),
                              Container(
                                alignment: Alignment.center,
                                width: screenWidth*0.1,
                                height: screenHeight * 0.06,
                                decoration: BoxDecoration(  
                                  borderRadius: BorderRadius.circular(screenWidth * 0.01),
                                  color: Colors.grey[200], // Color de fondo del contenedor
                                ),
                                child: DropdownButton<String>(
                                  value: contrasenaSeleccionada2,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      contrasenaSeleccionada2 = newValue;
                                    });
                                  },
                                  items: opcionesContrasena.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: screenHeight * 0.02,
                                    color: Colors.black,
                                  ),
                                  icon: Icon(Icons.arrow_drop_down, size: screenHeight*0.04,), 
                                  borderRadius:  BorderRadius.circular(screenWidth * 0.01), 
                                  underline: Container(height: 0,),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.01),
                              Container(
                                alignment: Alignment.center,
                                width: screenWidth*0.1,
                                height: screenHeight * 0.06,
                                decoration: BoxDecoration(  
                                  borderRadius: BorderRadius.circular(screenWidth * 0.01),
                                  color: Colors.grey[200], // Color de fondo del contenedor
                                ),
                                child: DropdownButton<String>(
                                  value: contrasenaSeleccionada3,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      contrasenaSeleccionada3 = newValue;
                                    });
                                  },
                                  items: opcionesContrasena.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: screenHeight * 0.02,
                                    color: Colors.black,
                                  ),
                                  icon: Icon(Icons.arrow_drop_down, size: screenHeight*0.04,), 
                                  borderRadius:  BorderRadius.circular(screenWidth * 0.01), 
                                  underline: Container(height: 0,),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.04),
                          Row(
                            children: [
                              Text(
                                'Foto Inicio Sesión:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenHeight * 0.025,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(screenWidth * 0.1, screenHeight * 0.05),
                                  maximumSize: Size(screenWidth * 0.13, screenHeight * 0.05),
                                  // backgroundColor: Colors.red, // Color del botón
                                ),
                                
                                onPressed: () {
                                  // Lógica para examinar foto
                                },
                                child: Text('Examinar foto', style: TextStyle(
                                  fontSize: screenHeight * 0.02,
                                ),),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // boton de confirmar
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: screenHeight * 0.05,
                          top: screenHeight * 0.05,
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(screenWidth * 0.2, screenHeight * 0.1),
                            maximumSize: Size(screenWidth * 0.2, screenHeight * 0.1),
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () async {
                            Map<String, dynamic> datosActualizados = {
                              'nombre': nombre,
                              'formato': formatoSeleccionado,
                              'notificacion': notificacionSeleccionada,
                              'contrasena': [
                                contrasenaSeleccionada1,
                                contrasenaSeleccionada2,
                                contrasenaSeleccionada3
                              ].join(", "),
                            };
                  
                            bool resultado = await controladores.editarPerfilAlumno(
                              widget.nickname,
                              datosActualizados,
                            );
                  
                            if (resultado) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Perfil actualizado con éxito.")),
                              );
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Error al actualizar el perfil.")),
                              );
                            }
                          },
                          child: Text(
                            'Confirmar',
                            style: TextStyle(
                              fontSize: screenHeight * 0.03,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width: screenWidth * 0.1),
                Image.asset(foto, width: screenWidth * 0.15),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BarraMenu(selectedIndex: 0),
    );
  }
}
