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
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: screenHeight*0.03,
                              crossAxisSpacing: screenWidth * 0.02,
                              mainAxisExtent: screenHeight * 0.35,
                            ),
                            itemCount: (currentPage + 1) * 8 <= estudiantesData.length
                                ? 8
                                : estudiantesData.length - currentPage * 8,
                            itemBuilder: (context, index) {
                              final itemIndex = currentPage * 8 + index;
                              final estudiante = estudiantesData[itemIndex];
                              return Semantics(
                                label: "Botón Alumno $estudiante['nickname']",
                                child: FilledButton(
                                  style: FilledButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(screenWidth * 0.02),
                                      side: BorderSide(color: Colors.black, width: screenWidth * 0.001),
                                    ),
                                    backgroundColor: Colors.transparent,
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
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: screenHeight*0.015,),
                                      Image.asset(
                                        estudiante['rutaImagenPerfil']!,
                                        // fit: BoxFit.contain,
                                        width: screenWidth*0.3,
                                        height: screenHeight*0.2,
                                        errorBuilder: (context, error, stackTrace) =>
                                            Icon(Icons.error, color: Colors.red),
                                      ),
                                      Expanded(
                                        child: Text(
                                          estudiante['nickname']!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: screenHeight * 0.02,
                                            fontFamily: 'Roboto',
                                          ),
                                          maxLines: 5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
