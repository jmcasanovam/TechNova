import 'package:flutter/material.dart';
import 'dart:convert'; // Para serializar los datos
import 'package:http/http.dart' as http; // Para hacer la solicitud PUT
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
  String? notificacionSeleccionada = 'Nada';
  String? contrasenaSeleccionada1 = 'Cuadrado';
  String? contrasenaSeleccionada2 = 'Cuadrado';
  String? contrasenaSeleccionada3 = 'Cuadrado';
    final Controladores controladores = Controladores();

  List<String> formatos = ['Texto', 'Video', 'Imagen', 'Pictograma', 'Audio'];
  List<String> preferenciasNotificacion = ['Nada', 'Audio', 'Texto'];
  List<String> opcionesContrasena = ['Cuadrado', 'Triángulo', 'Círculo', 'Cruz'];
  String foto = 'images/panda.png';

  @override
  void initState() {
    super.initState();
    obtenerNombre(widget.nickname);
  }

  void obtenerNombre(String nickname) async {
    // Aquí deberías hacer la solicitud para obtener el nombre basado en el nickname
    // Por simplicidad, vamos a simularlo con un nombre fijo
    setState(() {
      nombre = "Nombre del usuario"; // Reemplaza esto con el nombre obtenido
    });
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Image.asset(
                      'images/back-arrow.png',
                      width: screenWidth * 0.08,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          "Editar Perfil",
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
                  SizedBox(
                    width: screenWidth * 0.08,
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
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
                      ],
                    ),
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
