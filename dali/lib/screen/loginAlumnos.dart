import 'package:dali/widget/adminTitulo.dart';
import 'package:flutter/material.dart';
import 'loginPasswordAlumnos.dart';
import 'package:dali/controlers/controladores.dart';

class LoginAlumnos extends StatefulWidget {
  @override
  _LoginAlumnosState createState() => _LoginAlumnosState();
}

class _LoginAlumnosState extends State<LoginAlumnos> {
  int currentPage = 0;
  late Future<List<Map<String, String>>> estudiantesFuture; 
  final Controladores controladores = Controladores();

  @override
  void initState() {
    super.initState();
    estudiantesFuture = controladores.getEstudiantesNicknameyPerfil(); // Llama a la función para cargar datos dinámicos
    //controladores.getEstudiantesNicknameyPerfil();
  }

  
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          AdminTitulo(atras: false, titulo: "Elige tu foto"),
          Expanded(
            child: FutureBuilder<List<Map<String, String>>>(
              future: estudiantesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator()); // Indicador de carga
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error al cargar los datos: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No hay estudiantes disponibles.'));
                }
            
                final estudiantesData = snapshot.data!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Flecha izquierda
                        currentPage > 0?Semantics(
                          label: "Botón izquierda",
                          child: IconButton(
                          icon: Image.asset(
                            'images/left-arrow-accesible.png',
                            width: screenWidth * 0.08,
                          ),
                          onPressed: () {
                            setState(() {
                              currentPage--;
                            });
                          },
                        ),):SizedBox(width: screenWidth * 0.08),
            
                        // Grid de imágenes y nombres
                        Expanded(
                          child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: screenHeight*0.02,
                              crossAxisSpacing: screenWidth * 0.02,
                            ),
                            itemCount: (currentPage + 1) * 8 <= estudiantesData.length
                                ? 8
                                : estudiantesData.length - currentPage * 8,
                            itemBuilder: (context, index) {
                              final itemIndex = currentPage * 8 + index;
                              final estudiante = estudiantesData[itemIndex];
                              return Column(
                                children: [
                                  Semantics(label: "Botón Alumno $estudiante['nickname']",
                                  child: FilledButton(
                                    style: FilledButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                                        side: BorderSide(color: Colors.black, width: screenWidth * 0.001),
                                      ),
                                      backgroundColor: Colors.transparent,
                                      minimumSize: Size(
                                        screenWidth * 0.7 / 4,
                                        screenHeight * 0.6 / 2,
                                      ),
                                      maximumSize: Size(
                                        screenWidth * 0.7 / 4,
                                        screenHeight * 0.6 / 2,
                                      ),
                                    ),
                                    onPressed: () {
                                    //   Navegar a la pantalla de contraseña
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PasswordAlumnos(
                                            image: estudiante['rutaImagenPerfil']!,
                                            username: estudiante['nickname']!,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          estudiante['rutaImagenPerfil']!,
                                          height: screenHeight * 0.6 / 2 * 0.8,
                                          width: screenWidth * 0.7 / 4,
                                          errorBuilder: (context, error, stackTrace) =>
                                              Icon(Icons.error, color: Colors.red),
                                        ),
                                        SizedBox(
                                          height: screenHeight * 0.6 / 2 * 0.1,
                                          child: FittedBox(
                                            child: Text(
                                              estudiante['nickname']!,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: screenHeight * 0.05,
                                                fontFamily: 'OpenSans',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),),
                                ],
                              );
                            },
                          ),
                        ),
            
                        // Flecha derecha
                        (currentPage + 1) * 8 < estudiantesData.length?Semantics(
                          label: "Botón derecha",
                          child: IconButton(
                          icon: Image.asset(
                            'images/right-arrow-accesible.png',
                            width: screenWidth * 0.08,
                          ),
                          onPressed: () {
                            setState(() {
                              currentPage++;
                            });
                          },
                        ),):SizedBox(width: screenWidth*0.08)
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
