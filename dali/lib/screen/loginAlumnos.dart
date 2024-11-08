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
    {'image': 'images/hámster.png', 'name': 'JORGE'},
    {'image': 'images/gorila.png', 'name': 'LAURA'},
    {'image': 'images/hipopótamo.png', 'name': 'CELIA'},
    {'image': 'images/murciélago.png', 'name': 'MARTÍN'},
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
          Padding(
            padding: EdgeInsets.only(right: screenWidth *0.05, top: screenHeight*0.02),
            child: const BotonCerrarSesion()
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
                IconButton(
                  icon: Image.asset('images/left-arrow-accesible.png', width: screenWidth * 0.08,),
                  onPressed: () {
                    setState(() {
                      if (currentPage > 0) currentPage--;
                    });
                  },
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
                          FilledButton(
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
                          )
                        ],
                      );
                      
                    },
                  ),
                ),

                // Flecha derecha
                IconButton(
                  icon: Image.asset('images/right-arrow-accesible.png', width: screenWidth * 0.08,),
                  onPressed: () {
                    setState(() {
                      if ((currentPage + 1) * 8 < imagesData.length) currentPage++;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}