import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart'; // Importa para seleccionar imágenes
import 'package:dali/controlers/controladores.dart';

import '../widget/barraMenu.dart';

class AdminCreadorPerfil extends StatefulWidget {
  @override
  _AdminCreadorPerfilState createState() => _AdminCreadorPerfilState();
}

class _AdminCreadorPerfilState extends State<AdminCreadorPerfil> {
  String tipoSeleccionado = 'Alumno';
  List<String> opcionesContrasena = ['Cuadrado', 'Triángulo', 'Círculo', 'Cruz'];
  List<String> preferenciasNotificacion = ['Default', 'Mensaje', 'Mensaje+Sonido'];
  bool oculto = true;
  //PickedFile? _imageFile; // Para almacenar la imagen seleccionada
  TextEditingController nombreController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? contrasenaSeleccionada1;
  String? contrasenaSeleccionada2;
  String? contrasenaSeleccionada3;
  String? notificacionSeleccionada;

  final Controladores controladores = Controladores();
  //final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.02, top: screenHeight * 0.02),
            child: SizedBox(
              height: screenHeight * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                          "Creador de perfil",
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
                  SizedBox(width: screenWidth * 0.08),
                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: screenWidth * 0.4,
                  child: Column(
                    children: [
                      TextField(
                        controller: nombreController,
                        decoration: InputDecoration(
                          labelText: 'Nombre',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      TextField(
                        controller: nicknameController,
                        decoration: InputDecoration(
                          labelText: 'Nickname',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                DropdownButton<String>(
                  value: tipoSeleccionado,
                  onChanged: (String? newValue) {
                    setState(() {
                      tipoSeleccionado = newValue!;
                    });
                  },
                  items: <String>['Alumno', 'Profesor', 'Administrador']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: tipoSeleccionado == 'Alumno'
                  ? buildAlumnoWidgets(screenHeight, screenWidth)
                  : tipoSeleccionado == 'Profesor'
                      ? buildProfesorWidgets(screenHeight, screenWidth)
                      : buildAdministradorWidgets(screenHeight, screenWidth),
            ),
          ),

          ElevatedButton(
            onPressed: () async {
              try {
                String nombre = nombreController.text;
                String nickname = nicknameController.text;

                // Validar que todos los campos estén llenos
                if (nombre.isEmpty || nickname.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Nombre y Nickname son obligatorios')),
                  );
                  return;
                }

                String contrasena;

                // Para el tipo Alumno, se genera la contraseña con las opciones seleccionadas
                if (tipoSeleccionado == 'Alumno') {
                  if (contrasenaSeleccionada1 == null || contrasenaSeleccionada2 == null || contrasenaSeleccionada3 == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Selecciona todas las opciones para la contraseña')),
                    );
                    return;
                  }
                  contrasena = _crearContrasena(); // Concatenar opciones de contraseña
                } else {
                  // Para el Administrador o Educador, tomamos la contraseña personalizada desde el TextField
                  contrasena = passwordController.text;
                  if (contrasena.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('La contraseña personalizada es obligatoria')),
                    );
                    return;
                  }
                }

                // Guardar la imagen (si existe) o continuar sin ella
                // String? imagePath;
                // if (_imageFile != null) {
                //   imagePath = _imageFile!.path; // La ruta de la imagen seleccionada
                // }

                // Crear el nuevo usuario según el tipo
                if (tipoSeleccionado == 'Alumno') {
                  await controladores.crearEstudiante({
                    'nombre': nombre,
                    'nickname': nickname,
                    'password': contrasena,
                    'preferenciasNotificacion': notificacionSeleccionada,
                    'rutaImagenPerfil': "images/estudiante.png",
                  });
                } else if (tipoSeleccionado == 'Profesor') {
                  await controladores.crearEducador({
                    'nombre': nombre,
                    'nickname': nickname,
                    'password': contrasena,
                    'preferenciasNotificacion': notificacionSeleccionada,
                    'rutaImagenPerfil': "images/profesor.png",
                  });
                } else if (tipoSeleccionado == 'Administrador') {
                  await controladores.crearAdministrador({
                    'nombre': nombre,
                    'nickname': nickname,
                    'password': contrasena,
                    'preferenciasNotificacion': notificacionSeleccionada,
                    'rutaImagenPerfil': "images/administrador.png",
                  });
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$tipoSeleccionado creado con éxito')),
                );
                Navigator.pop(context);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $e')),
                );
              }
            },
            child: Text('Confirmar'),
          ),
        ],
      ),
      bottomNavigationBar: BarraMenu(selectedIndex: 0),
    );
  }

  // Método para crear la contraseña concatenando las opciones seleccionadas
  String _crearContrasena() {
    return contrasenaSeleccionada1!.replaceAll('á', 'a').replaceAll('é', 'e').replaceAll('í', 'i').replaceAll('ó', 'o').replaceAll('ú', 'u') +
           contrasenaSeleccionada2!.replaceAll('á', 'a').replaceAll('é', 'e').replaceAll('í', 'i').replaceAll('ó', 'o').replaceAll('ú', 'u') +
           contrasenaSeleccionada3!.replaceAll('á', 'a').replaceAll('é', 'e').replaceAll('í', 'i').replaceAll('ó', 'o').replaceAll('ú', 'u');
  }

  Widget buildAlumnoWidgets(double screenHeight, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Foto Inicio Sesión:',
              style: TextStyle(fontSize: screenHeight * 0.025),
            ),
            SizedBox(width: screenWidth * 0.02),
            ElevatedButton(
              onPressed: () async {
                // Usamos ImagePicker para seleccionar una imagen
                // final pickedFile = await _picker.getImage(source: ImageSource.gallery);
                // setState(() {
                //   _imageFile = pickedFile;
                // });
              },
              child: Text('Examinar foto', style: TextStyle(fontSize: screenHeight * 0.02)),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.02),

        Row(
          children: [
            Text(
              'Preferencias de Notificación:',
              style: TextStyle(fontSize: screenHeight * 0.025),
            ),
            SizedBox(width: screenWidth * 0.02),
            DropdownButton<String>(
              value: notificacionSeleccionada,
              onChanged: (String? newValue) {
                setState(() {
                  notificacionSeleccionada = newValue;
                });
              },
              items: preferenciasNotificacion.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text('Seleccione Preferencias de Notificación'),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.02),

        Row(
          children: [
            Text(
              'Contraseña:',
              style: TextStyle(fontSize: screenHeight * 0.025),
            ),
            SizedBox(width: screenWidth * 0.02),
            SizedBox(
              width: screenWidth * 0.25,
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
                isExpanded: true,
                iconSize: screenHeight * 0.03,
              ),
            ),
            SizedBox(width: screenWidth * 0.02),
            SizedBox(
              width: screenWidth * 0.25,
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
                isExpanded: true,
                iconSize: screenHeight * 0.03,
              ),
            ),
            SizedBox(width: screenWidth * 0.02),
            SizedBox(
              width: screenWidth * 0.25,
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
                isExpanded: true,
                iconSize: screenHeight * 0.03,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildProfesorWidgets(double screenHeight, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Contraseña Personalizada:',
              style: TextStyle(fontSize: screenHeight * 0.025),
            ),
            SizedBox(width: screenWidth * 0.02),
            SizedBox(
              width: screenWidth * 0.5,
              child: TextField(
                controller: passwordController,
                obscureText: oculto,
                decoration: InputDecoration(
                  labelText: 'Ingrese su contraseña',
                  suffixIcon: IconButton(
                    icon: Icon(oculto ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        oculto = !oculto;
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'Preferencias de Notificación:',
              style: TextStyle(fontSize: screenHeight * 0.025),
            ),
            SizedBox(width: screenWidth * 0.02),
            DropdownButton<String>(
              value: notificacionSeleccionada,
              onChanged: (String? newValue) {
                setState(() {
                  notificacionSeleccionada = newValue;
                });
              },
              items: preferenciasNotificacion.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text('Seleccione Preferencias de Notificación'),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildAdministradorWidgets(double screenHeight, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Contraseña Personalizada:',
              style: TextStyle(fontSize: screenHeight * 0.025),
            ),
            SizedBox(width: screenWidth * 0.02),
            SizedBox(
              width: screenWidth * 0.5,
              child: TextField(
                controller: passwordController,
                obscureText: oculto,
                decoration: InputDecoration(
                  labelText: 'Ingrese su contraseña',
                  suffixIcon: IconButton(
                    icon: Icon(oculto ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        oculto = !oculto;
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'Preferencias de Notificación:',
              style: TextStyle(fontSize: screenHeight * 0.025),
            ),
            SizedBox(width: screenWidth * 0.02),
            DropdownButton<String>(
              value: notificacionSeleccionada,
              onChanged: (String? newValue) {
                setState(() {
                  notificacionSeleccionada = newValue;
                });
              },
              items: preferenciasNotificacion.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text('Seleccione Preferencias de Notificación'),
            ),
          ],
        ),
      ],
    );
  }
}
