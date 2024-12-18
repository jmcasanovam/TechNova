import 'package:dali/widget/adminTitulo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dali/controlers/controladores.dart';

import '../widget/barraMenu.dart';
import 'package:dali/models/menu.dart';



class AdminMenus extends StatefulWidget {

  AdminMenus();

  @override
  _AdminMenusState createState() => _AdminMenusState();
}

class _AdminMenusState extends State<AdminMenus> {

  int numero_menus = 0;
  bool comanda_tomada = false;
  bool tarea_asignada = false;
  bool confirmable = false;
  List<Menu> menus = [];
  List<TextEditingController> controllers = [];
    final TextEditingController controladorNumMenus = TextEditingController();
    final Controladores controladores = Controladores();


  void volverAtras(BuildContext context) {
    Navigator.of(context).pop();
  }
  @override
  void initState() {
    super.initState();
    // Aquí podrías cargar datos específicos del alumno basado en el nickname.
    cargarCantidadMenus();
  }

  /// Función para obtener el número de menús desde una fuente externa
  Future<void> cargarCantidadMenus() async {
    try {
      // String fecha = '${DateTime.now().day.toString().padLeft(2, '0')}/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().year}';
      String fecha = '01/01/2024';

      // Aquí llamamos a la función que devuelve el número de menús dinámicamente
      int cantidad = await controladores.obtenerCantidadMenus(fecha); // Usamos la fecha actual
      setState(() {
        numero_menus = cantidad;
        controladorNumMenus.text = numero_menus.toString();

        // Actualizamos la lista de menús y los controladores
        while (menus.length < numero_menus) {
          menus.add(Menu("Menu ${menus.length + 1}", 'images/menus.png'));
        }
        while (menus.length > numero_menus) {
          menus.removeLast();
        }

        controllers = List.generate(menus.length, (index) {
          return TextEditingController(text: menus[index].nombre);
        });
      });
    } catch (error) {
      print("Error al obtener la cantidad de menús: $error");
    }
  }

  // /// Función simulada para obtener la cantidad de menús. Reemplazar con la real.
  // Future<int> obtenerCantidadMenus(String fecha) async {
  //   // Simulamos un retraso para la carga de datos
  //   await Future.delayed(Duration(seconds: 2));
  //   return 5; // Por ejemplo, retornamos 5 menús dinámicamente
  // }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final controladorNumMenus = TextEditingController(text: numero_menus.toString());

    
      return Scaffold(
        body: Column(
          children:[
            AdminTitulo(atras: false, titulo: "Menús"),

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
                          Row(
                            children: [
                              Text(
                                'Número de menús disponibles:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenHeight * 0.025,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              // SizedBox(height: screenHeight * 0.02),
                              SizedBox(
                                width: screenWidth * 0.02,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: controladorNumMenus,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: screenHeight * 0.025,
                                  ),
                                ),
                              ),
                              TextButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(screenWidth * 0.15, screenHeight * 0.07),
                                  maximumSize: Size(screenWidth * 0.15, screenHeight * 0.07),
                                  backgroundColor: Colors.grey[300]
                                ),
                                
                                onPressed: () {
                                  setState(() {
                                  numero_menus = int.parse(controladorNumMenus.text);
                                  while(menus.length < numero_menus){
                                    menus.add(Menu("Menu " + (menus.length+1).toString(), 'images/menus.png'));
                                  }

                                  });

                                  while(menus.length > numero_menus)
                                    menus.removeLast();

                                  controllers = List.generate(menus.length, (index) {
                                    return TextEditingController(text: menus[index].nombre);
                                  });
                                },
                                
                                child: Text('Actualizar Cantidad', style: TextStyle(
                                  fontSize: screenHeight * 0.02,
                                  color: Colors.black
                                ),),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              TextButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(screenWidth * 0.15, screenHeight * 0.07),
                                  maximumSize: Size(screenWidth * 0.15, screenHeight * 0.07),
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: menus.length > 0 ?() {
                                  setState(() {
                                    for (int i = 0; i < menus.length; i++)
                                      menus[i].set_nombre(controllers[i].text);
                                    
                                    confirmable = false;
                                  });
                                }:null,
                                child: Text(
                                  'Confirmar Cambios',
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.02,
                                    color: Colors.white
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: screenHeight*0.18,
                            child: SingleChildScrollView(
                            child: Column(children: [
                              for(int i = 0; i < menus.length; i++)
                                Row(children: [
                                    Image.asset(menus[i].picto, width: screenWidth*0.02, height: screenWidth*0.02),
                                    SizedBox(
                                      width: screenWidth * 0.2,
                                      child: TextField(
                                        controller: controllers[i],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screenHeight * 0.025,
                                        ),
                                      onChanged: (text){ confirmable = true;},
                                      ),
                                    ),
                                  SizedBox(width: screenWidth*0.02),
                                  TextButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(screenWidth * 0.15, screenHeight * 0.07),
                                      maximumSize: Size(screenWidth * 0.15, screenHeight * 0.07),
                                      backgroundColor: Colors.grey[200]
                                    ),
                                    onPressed: (){
                                      // Lógica de examinar imagen
                                    },

                                    child: Text('Examinar imagen', style: TextStyle(
                                      fontSize: screenHeight * 0.02,
                                      color: Colors.black
                                    ),),
                                  ),
                                  SizedBox(width: screenWidth*0.01,),
                                  TextButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(screenWidth * 0.15, screenHeight * 0.07),
                                      maximumSize: Size(screenWidth * 0.15, screenHeight * 0.07),
                                      backgroundColor: const Color.fromRGBO(179, 11, 0, 1),
                                    ),
                                    
                                    onPressed: () {
                                      // Lógica para examinar PDF
                                    },
                                    child: Text('Examinar PDF', style: TextStyle(
                                      fontSize: screenHeight * 0.02,
                                      color: Colors.white
                                    ),),
                                  ),
                                ],)
                            ],))),

                          SizedBox(height: screenHeight*0.05),
                          // Tarea asignada?
                          Row(
                            children: [
                              Text(
                                'Tarea asignada:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenHeight * 0.025,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Text(
                                tarea_asignada?'SI':'NO',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenHeight * 0.025,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.02),

                          // Comanda tomada?
                          Row(
                            children: [
                              Text(
                                'Comanda tomada:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenHeight * 0.025,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Text(
                                comanda_tomada?'SI':'NO',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenHeight * 0.025,
                                ),
                              ),
                              SizedBox(width: screenWidth*0.05),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(screenWidth * 0.24, screenHeight * 0.1),
                                  maximumSize: Size(screenWidth * 0.24, screenHeight * 0.1),
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: () {
                                  setState((){
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context){
                                        return AlertDialog(
                                          content: Container(height: screenHeight*0.6, child: Column(children: [
                                            const Text("Menus asignados",
                                              style: TextStyle(
                                                fontFamily: 'Open Sans',
                                                fontSize: 40,
                                                color: Colors.red
                                              )),
                                            Container(height: screenHeight*0.4, child: SingleChildScrollView(
                                              child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                for(var menu in menus)
                                                  Row(
                                                    children:[
                                                      Image.asset(menu.picto, width: screenWidth*0.1, height: screenWidth*0.1,),
                                                      Text(menu.nombre + ": " + menu.get_cant().toString(),
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                      ),)]),
                                              ],
                                            ))),
                                            //SizedBox(height: screenHeight*0.02),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                minimumSize: Size(screenWidth * 0.1, screenHeight * 0.05),
                                                maximumSize: Size(screenWidth * 0.13, screenHeight * 0.05),
                                              ),
                                              onPressed: (){
                                                setState(() {
                                                  volverAtras(context);
                                                });
                                              },

                                              child: Text('Volver', style: TextStyle(
                                                fontSize: screenHeight * 0.02,
                                              ),),
                                            ),
                                          ],) )
                                          
                                        );
                                      }
                                    );
                                  });
                                },
                                child: Text(
                                  'Consultar Comanda',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.015,
                                    color: Colors.white,
                                  ),
                                  ),
                              ),
                            ],
                          ),
                    ],
                  ),
                ],
              ),
          ]),

            
        )]
        ),
        bottomNavigationBar: BarraMenu(selectedIndex: 3),
      );
    }

}