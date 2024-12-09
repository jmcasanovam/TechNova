import 'package:dali/widget/botonCerrarSesion.dart';
import 'package:flutter/material.dart';
// import 'loginScreen.dart';
import 'passwordAlumnos.dart';



class LoginAlumnos extends StatefulWidget {
  @override
  _LoginAlumnosState createState() => _LoginAlumnosState();
}

class _LoginAlumnosState extends State<LoginAlumnos> {
  int currentPage = 0;

  // Lista de pares de imagen y nombre
  final List<Map<String, String>> imagesData = [
    // 'images/pingüino.png',
    // 'images/serpiente.png',
    // 'images/tortuga.png',

    {'image': 'images/panda.png', 'name': 'EDU'},
    {'image': 'images/panda.png', 'name': 'EDU'},
    {'image': 'images/panda.png', 'name': 'EDU'},
    {'image': 'images/panda.png', 'name': 'EDU'},
    {'image': 'images/cocodrilo.png', 'name': 'MANU'},
    {'image': 'images/cisne.png', 'name': 'MARTA'},
    {'image': 'images/hamster.png', 'name': 'JORGE'},
    {'image': 'images/gorila.png', 'name': 'LAURA'},
    {'image': 'images/hipopotamo.png', 'name': 'CELIA'},
    {'image': 'images/murcielago.png', 'name': 'MARTÍN'},
    {'image': 'images/perro.png', 'name': 'PAULA'},
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Quitar la flecha de retroceso
        toolbarHeight: screenHeight*0.15,
        actions: [

          // Icono de cerrar sesión
          Semantics(
            label: 'Cerrar Sesión',
            child: Padding(
              padding: EdgeInsets.only(right: screenWidth *0.05, top: screenHeight*0.02),
              child: const BotonCerrarSesion()
            ),
          )          
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Flecha izquierda
                Semantics(
                  label: 'Flecha izquierda',
                  child: IconButton(
                    icon: Image.asset('images/left-arrow-accesible.png', width: screenWidth * 0.08,),
                    onPressed: () {
                      setState(() {
                        if (currentPage > 0) currentPage--;
                      });
                    },
                  ),
                ),
                
                // Grid de imágenes y nombres
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: screenHeight * 0.05,
                    ),
                    itemCount: (currentPage + 1) * 8 <= imagesData.length ? 8 : imagesData.length - currentPage * 8,
                    itemBuilder: (context, index) {
                      final itemIndex = currentPage * 8 + index;
                      return Column(
                        children: [
                          Semantics(
                            label: "Perfil de $imagesData[itemIndex]['name']" ,
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenWidth * 0.02), side:BorderSide(color: Colors.black, width: screenWidth * 0.001)),
                                backgroundColor: Colors.transparent,
                                minimumSize: Size(screenWidth * 0.7/4, screenHeight * 0.6/2),
                                maximumSize: Size(screenWidth * 0.7/4, screenHeight * 0.6/2),
                                
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PasswordAlumnos(
                                      image: imagesData[itemIndex]['image']!,
                                      username: imagesData[itemIndex]['name']!,
                                      // name: imagesData[itemIndex]['name']!,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                Image.asset(
                                  imagesData[itemIndex]['image']!,
                                  height: screenHeight * 0.6/2*0.8,
                                  width: screenWidth * 0.7/4,
                                ),
                                SizedBox(
                                  height: screenHeight * 0.6/2*0.1,
                                  child : FittedBox(
                                    child: Text(
                                      imagesData[itemIndex]['name']!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: screenHeight * 0.05,
                                        fontFamily: 'OpenSans',
                                        ),
                                      ),
                                  )
                                )
                              ],)
                            ),
                          )
                        ],
                      );
                      
                    },
                  ),
                ),

                // Flecha derecha
                Semantics(
                  label: 'Flecha derecha',
                  child: IconButton(
                    icon: Image.asset('images/right-arrow-accesible.png', width: screenWidth * 0.08,),
                    onPressed: () {
                      setState(() {
                        if ((currentPage + 1) * 8 < imagesData.length) currentPage++;
                      });
                    },
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


//Codigo nuevo :

// import 'package:dali/screen/passwordAlumnos.dart';
// import 'package:dali/widget/botonCerrarSesion.dart';
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class LoginAlumnos extends StatefulWidget {
//   @override
//   _LoginAlumnosState createState() => _LoginAlumnosState();
// }

// class _LoginAlumnosState extends State<LoginAlumnos> {
//   int currentPage = 0;
//   late Future<List<Map<String, String>>> estudiantesFuture;

//   @override
//   void initState() {
//     super.initState();
//     estudiantesFuture = getEstudiantesNicknameyPerfil(); // Llama a la función para cargar datos dinámicos
//   }

//   Future<List<Map<String, String>>> getEstudiantesNicknameyPerfil() async {
//     final url = Uri.parse('http://127.0.0.1:5000/get_estudiantes_foto_nickname/');

//     try {
//       final response = await http.get(
//         url,
//         headers: {'Content-Type': 'application/json'},
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> data = jsonDecode(response.body);
//         print('Datos recibidos: $data'); // Para depuración
//         return data.map<Map<String, String>>((estudiante) {
//           return {
//             'nickname': estudiante['nickname'],
//             'rutaImagenPerfil': estudiante['rutaImagenPerfil'],
//           };
//         }).toList();
//       } else {
//         print('Error del servidor: ${response.statusCode}');
//         return [];
//       }
//     } catch (e) {
//       print('Error al realizar la solicitud: $e');
//       return [];
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         toolbarHeight: screenHeight * 0.15,
//         actions: [
//           Semantics(
//             label: 'Cerrar Sesión',
//             child: Padding(
//               padding: EdgeInsets.only(right: screenWidth * 0.05, top: screenHeight * 0.02),
//               child: const BotonCerrarSesion(),
//             ),
//           ),
//         ],
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: FutureBuilder<List<Map<String, String>>>(
//         future: estudiantesFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator()); // Indicador de carga
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error al cargar los datos: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No hay estudiantes disponibles.'));
//           }

//           final estudiantesData = snapshot.data!;
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Flecha izquierda
//                   IconButton(
//                     icon: Image.asset(
//                       'images/left-arrow-accesible.png',
//                       width: screenWidth * 0.08,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         if (currentPage > 0) currentPage--;
//                       });
//                     },
//                   ),

//                   // Grid de imágenes y nombres
//                   Expanded(
//                     child: GridView.builder(
//                       shrinkWrap: true,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 4,
//                         mainAxisSpacing: 0,
//                         crossAxisSpacing: screenHeight * 0.05,
//                       ),
//                       itemCount: (currentPage + 1) * 8 <= estudiantesData.length
//                           ? 8
//                           : estudiantesData.length - currentPage * 8,
//                       itemBuilder: (context, index) {
//                         final itemIndex = currentPage * 8 + index;
//                         final estudiante = estudiantesData[itemIndex];
//                         return Column(
//                           children: [
//                             FilledButton(
//                               style: FilledButton.styleFrom(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(screenWidth * 0.02),
//                                   side: BorderSide(color: Colors.black, width: screenWidth * 0.001),
//                                 ),
//                                 backgroundColor: Colors.transparent,
//                                 minimumSize: Size(
//                                   screenWidth * 0.7 / 4,
//                                   screenHeight * 0.6 / 2,
//                                 ),
//                                 maximumSize: Size(
//                                   screenWidth * 0.7 / 4,
//                                   screenHeight * 0.6 / 2,
//                                 ),
//                               ),
//                               onPressed: () {
//                               //   Navegar a la pantalla de contraseña
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => PasswordAlumnos(
//                                       image: estudiante['rutaImagenPerfil']!,
//                                       username: estudiante['nickname']!,
//                                     ),
//                                   ),
//                                 );
//                               },
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Image.network(
//                                     estudiante['rutaImagenPerfil']!,
//                                     height: screenHeight * 0.6 / 2 * 0.8,
//                                     width: screenWidth * 0.7 / 4,
//                                     errorBuilder: (context, error, stackTrace) =>
//                                         Icon(Icons.error, color: Colors.red),
//                                   ),
//                                   SizedBox(
//                                     height: screenHeight * 0.6 / 2 * 0.1,
//                                     child: FittedBox(
//                                       child: Text(
//                                         estudiante['nickname']!,
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                           color: Colors.black,
//                                           fontSize: screenHeight * 0.05,
//                                           fontFamily: 'OpenSans',
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),

//                   // Flecha derecha
//                   IconButton(
//                     icon: Image.asset(
//                       'images/right-arrow-accesible.png',
//                       width: screenWidth * 0.08,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         if ((currentPage + 1) * 8 < estudiantesData.length) currentPage++;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
