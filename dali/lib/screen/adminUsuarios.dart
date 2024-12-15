import 'package:dali/controlers/controladores.dart';
import 'package:dali/screen/adminAlumnoTareas.dart';
import 'package:dali/screen/adminCreadorPerfil2.dart';
import 'package:dali/screen/adminEditarPerfil.dart';
import 'package:dali/widget/adminTitulo.dart';
import 'package:flutter/material.dart';
import '../widget/barraMenu.dart';

class AdminUsuarios extends StatefulWidget {
  @override
  _AdminUsuariosState createState() => _AdminUsuariosState();
}

class _AdminUsuariosState extends State<AdminUsuarios> {
  String? _ordenActual = 'Ordenar A-Z';
  List<Map<String, dynamic>> estudiantes = []; // Lista para estudiantes
  final Controladores controladores = Controladores(); // Instancia de controladores

  @override
  void initState() {
    super.initState();
    _cargarEstudiantes(); // Carga los estudiantes al iniciar
  }

  Future<void> _cargarEstudiantes() async {
    try {
      final data = await controladores.cargarNicknamesEstudiantes(); // Llama a la función desde controladores
      setState(() {
        estudiantes = data;
        _ordenarLista();
      });
    } catch (e) {
      print('Error al cargar estudiantes: $e');
    }
  }

  void _ordenarLista() {
    setState(() {
      if (_ordenActual == 'Ordenar A-Z') {
        estudiantes.sort((a, b) => a['nickname'].compareTo(b['nickname']));
      } else {
        estudiantes.sort((a, b) => b['nickname'].compareTo(a['nickname']));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          AdminTitulo(atras: false, titulo: "Alumnos"),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: screenWidth * 0.05,
                left: screenWidth * 0.05,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: screenWidth * 0.1,
                        height: screenHeight * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(screenWidth * 0.01),
                          color: Colors.red,
                        ),
                        child: DropdownButton<String>(
                          value: _ordenActual,
                          onChanged: (String? nuevoValor) {
                            setState(() {
                              _ordenActual = nuevoValor;
                              _ordenarLista();
                            });
                          },
                          items: <String>['Ordenar A-Z', 'Ordenar Z-A']
                              .map<DropdownMenuItem<String>>((String valor) {
                            return DropdownMenuItem<String>(
                              value: valor,
                              child: Text(valor),
                            );
                          }).toList(),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontSize: screenHeight * 0.02,
                          ),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                            size: screenWidth * 0.02,
                          ),
                          dropdownColor: Colors.red,
                          borderRadius: BorderRadius.circular(screenWidth * 0.01),
                          underline: Container(
                            height: 0,
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(screenWidth * 0.1, screenHeight * 0.06),
                          maximumSize: Size(screenWidth * 0.1, screenHeight * 0.06),
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.01),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminCreadorPerfil(),
                            ),
                          );
                        },
                        icon: Icon(Icons.add, color: Colors.white, size: screenWidth * 0.02),
                        label: Text(
                          'Crear perfil',
                          style: TextStyle(
                            fontSize: screenHeight * 0.02,
                            fontFamily: 'Roboto',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    "Nickname",
                    style: TextStyle(
                      fontSize: screenHeight * 0.03,
                      fontFamily: 'Roboto',
                      color: Colors.black,
                    ),
                  ),
                  Divider(color: Colors.black, thickness: screenHeight * 0.006),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(screenWidth * 0.01),
                        color: Colors.grey[200],
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.all(screenWidth * 0.01),
                        itemCount: estudiantes.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: screenHeight * 0.01),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(screenWidth * 0.02),
                              ),
                              child: ListTile(
                                title: Text(
                                  estudiantes[index]['nickname'],
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.03,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                    color: Colors.white,
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AdminAlumnoTareas(
                                              nickname: estudiantes[index]['nickname'],
                                            ),
                                          ),
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.red[100],
                                      ),
                                      child: Text(
                                        "Tareas",
                                        style: TextStyle(
                                          fontSize: screenHeight * 0.03,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Roboto',
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: screenWidth * 0.01),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AdminEditarPerfil(
                                              nickname: estudiantes[index]['nickname'],
                                            ),
                                          ),
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.red[100],
                                      ),
                                      child: Text(
                                        "Editar perfil",
                                        style: TextStyle(
                                          fontSize: screenHeight * 0.03,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Roboto',
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BarraMenu(selectedIndex: 0),
    );
  }
}