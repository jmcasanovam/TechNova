  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter/widgets.dart';

import '../widget/barraMenu.dart';

  class AdminCreadorPerfil extends StatefulWidget {
    @override
    _AdminCreadorPerfilState createState() => _AdminCreadorPerfilState();
  }

  class _AdminCreadorPerfilState extends State<AdminCreadorPerfil> {
    String tipoSeleccionado = 'Alumno';
    List<String> formatos = ['Texto', 'Video', 'Imagen', 'Pictograma'];
    List<String> preferenciasNotificacion = ['Nada', 'Audio', 'Texto'];
    List<String> opcionesContrasena = ['Cuadrado', 'Triángulo', 'Círculo', 'Cruz'];
    bool oculto = true;

    

    String? formatoSeleccionado;
    String? notificacionSeleccionada;
    String? contrasenaSeleccionada1;
    String? contrasenaSeleccionada2;
    String? contrasenaSeleccionada3;

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

            // LO COMUN A TODOS elegir profesor/admin/alumno y nickname nombre
            Padding(
              padding: EdgeInsets.only(right: screenWidth * 0.05, left: screenWidth * 0.05),
              child: SizedBox(
                height: screenHeight*0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // nombre y nickname
                    SizedBox( 
                      width: screenWidth*0.4,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: screenHeight*0.01, right: screenWidth * 0.05, left: screenWidth * 0.05),
                            // nombre
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  height: screenHeight * 0.07,
                                  child: TextField(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenHeight * 0.025,
                                    ),
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black,), borderRadius:BorderRadius.circular(screenWidth * 0.01)),
                                      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black,), borderRadius:BorderRadius.circular(screenWidth * 0.01)),
                                      hintText: 'Ingrese su nombre',
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: screenHeight * 0.025,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: screenHeight*0.01, right: screenWidth * 0.05, left: screenWidth * 0.05),
                            // nickname
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Nickname:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: screenHeight * 0.025,
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                SizedBox(
                                  width: screenWidth * 0.2,
                                  height: screenHeight * 0.07,
                                  child: TextField(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenHeight * 0.025,
                                    ),
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black,), borderRadius:BorderRadius.circular(screenWidth * 0.01)),
                                      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black,), borderRadius:BorderRadius.circular(screenWidth * 0.01)),
                                      hintText: 'Ingrese su nickname',
                                      hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: screenHeight * 0.025,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // desplegable tipo usuario
                    Container(
                      alignment: Alignment.center,
                      width: screenWidth*0.2,
                      height: screenHeight * 0.12,
                      decoration: BoxDecoration(  
                        borderRadius: BorderRadius.circular(screenWidth * 0.01),
                        color: Colors.red,
                      ),
                      child: DropdownButton<String>(
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
                        style: TextStyle(
                          color: Colors.grey[200],
                          fontFamily: 'Roboto',
                          fontSize: screenHeight * 0.035,
                        ),
                        icon: Icon(Icons.arrow_drop_down, color: Colors.white, size: screenWidth*0.02,), 
          
                        underline: Container(height: 0,),
                        dropdownColor: Colors.red,
          
          
                      ),
                    ),
                  ],
                ),
              ),
            ),
            

            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: tipoSeleccionado == 'Alumno'
                        ? buildAlumnoWidgets(screenHeight, screenWidth)
                        : tipoSeleccionado == 'Profesor'
                            ? buildProfesorWidgets(screenHeight, screenWidth)
                            : buildAdministradorWidgets(screenHeight, screenWidth),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: screenHeight*0.05, top: screenHeight*0.05),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(screenWidth * 0.2, screenHeight * 0.1),
                        maximumSize: Size(screenWidth * 0.2, screenHeight * 0.1),
                        backgroundColor: Colors.red, // Color del botón
                      ),
                      onPressed: () {
                        //logica de crear el perfil
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
            ),

            
          ]
        ),
        bottomNavigationBar: BarraMenu(selectedIndex: 0),
      );
    }



    Widget buildAlumnoWidgets(double screenHeight, double screenWidth) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Botón de Examinar Foto
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
      );
    }

    Widget buildProfesorWidgets(double screenHeight, double screenWidth) {
      return Padding(
        padding: EdgeInsets.only(left:screenWidth*0.15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenWidth * 0.2,
              child: TextField(
                style: TextStyle(
                  fontSize: screenHeight * 0.025,
                ),
                obscureText: oculto,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black), borderRadius:BorderRadius.circular(screenWidth * 0.01)),
                  focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black), borderRadius:BorderRadius.circular(screenWidth * 0.01)),
                  hintText: 'Ingrese su contraseña',
                  hintStyle: TextStyle(
                    fontSize: screenHeight * 0.025,
                  ),
                  suffixIcon: IconButton(
                    icon: oculto?Icon(Icons.visibility,  size: screenWidth * 0.03):Icon(Icons.visibility_off, size: screenWidth * 0.03),
                    onPressed: (){
                      setState((){
                        oculto=!oculto;
                      });
                    } ,
                  )
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget buildAdministradorWidgets(double screenHeight, double screenWidth) {
      return Padding(
        padding: EdgeInsets.only(left:screenWidth*0.15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenWidth * 0.2,
              child: TextField(
                style: TextStyle(
                  fontSize: screenHeight * 0.025,
                ),
                obscureText: oculto,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black), borderRadius:BorderRadius.circular(screenWidth * 0.01)),
                  focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black), borderRadius:BorderRadius.circular(screenWidth * 0.01)),
                  hintText: 'Ingrese su contraseña',
                  hintStyle: TextStyle(
                    fontSize: screenHeight * 0.025,
                  ),
                  suffixIcon: IconButton(
                    icon: oculto?Icon(Icons.visibility,  size: screenWidth * 0.03):Icon(Icons.visibility_off, size: screenWidth * 0.03),
                    onPressed: (){
                      setState((){
                        oculto=!oculto;
                      });
                    } ,
                  )
                ),
              ),
            ),
          ],
        ),
      );
    }
  }