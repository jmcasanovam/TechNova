import 'package:flutter/material.dart';

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
  String? contrasenaSeleccionada1 = 'Cuadrado' ;
  String? contrasenaSeleccionada2 = 'Cuadrado';
  String? contrasenaSeleccionada3 = 'Cuadrado';

  List<String> formatos = ['Texto', 'Video', 'Imagen', 'Pictograma'];
  List<String> preferenciasNotificacion = ['Nada', 'Audio', 'Texto'];
  List<String> opcionesContrasena = ['Cuadrado', 'Triángulo', 'Círculo', 'Cruz'];
  String foto = 'images/panda.png';


  @override
  void initState() {
    super.initState();
    // Aquí podrías cargar datos específicos del alumno basado en el nickname.
    nombre = widget.nickname; // Por simplicidad, se asume que el nombre es igual al nickname.
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    
      return Scaffold(
        body: Column(
          children:[
            Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.02, top: screenHeight * 0.02,),
              child: SizedBox(
                height: screenHeight * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Image.asset('images/back-arrow.png', width: screenWidth * 0.08,),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Center(
                        child: FittedBox(
                          child: Text(
                            "Creador de perfil",
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
                )
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
                          // nombre
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
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.02),

                
                          // Botón de Examinar Foto
                          Row(
                            children: [
                              Text(
                                'Cambiar foto Inicio Sesión:',
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
                              Container(
                                alignment: Alignment.center,
                                width: screenWidth*0.1,
                                height: screenHeight * 0.06,
                                decoration: BoxDecoration(  
                                  borderRadius: BorderRadius.circular(screenWidth * 0.01),
                                  color: Colors.grey[200], // Color de fondo del contenedor
                                ),
                                child: DropdownButton<String>(
                                  value: formatoSeleccionado,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      formatoSeleccionado = newValue;
                                    });
                                  },
                                  items: formatos.map<DropdownMenuItem<String>>((String value) {
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
                          SizedBox(height: screenHeight * 0.02),
                          
                          // Desplegable de Preferencias Notificación
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
                              Container(
                                alignment: Alignment.center,
                                width: screenWidth*0.1,
                                height: screenHeight * 0.06,
                                decoration: BoxDecoration(  
                                  borderRadius: BorderRadius.circular(screenWidth * 0.01),
                                  color: Colors.grey[200], // Color de fondo del contenedor
                                ),
                                child: DropdownButton<String>(
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
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: screenHeight*0.05, top: screenHeight*0.05),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(screenWidth * 0.2, screenHeight * 0.1),
                            maximumSize: Size(screenWidth * 0.2, screenHeight * 0.1),
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            //añadir logica del cambio
                            Navigator.pop(context);
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
                  SizedBox(width: screenWidth*0.1,),
                  Image.asset(foto, width: screenWidth * 0.15,),

                ],
              ),
            ),

            
          ]
        ),
        bottomNavigationBar: BarraMenu(selectedIndex: 0),
      );
    }

}
