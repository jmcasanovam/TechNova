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
                            "Menús",
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
                              SizedBox(height: screenHeight * 0.02),
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
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(screenWidth * 0.1, screenHeight * 0.05),
                                  maximumSize: Size(screenWidth * 0.13, screenHeight * 0.05),
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
                                child: Text('Actualizar', style: TextStyle(
                                  fontSize: screenHeight * 0.02,
                                ),),
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
                                        keyboardType: TextInputType.number,
                                        controller: controllers[i],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screenHeight * 0.025,
                                        ),
                                      ),
                                    ),
                                  SizedBox(width: screenWidth*0.01),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(screenWidth * 0.1, screenHeight * 0.05),
                                      maximumSize: Size(screenWidth * 0.13, screenHeight * 0.05),
                                    ),
                                    onPressed: (){
                                      // Lógica de examinar imagen
                                    },

                                    child: Text('Examinar imagen', style: TextStyle(
                                      fontSize: screenHeight * 0.02,
                                    ),),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(screenWidth * 0.1, screenHeight * 0.05),
                                      maximumSize: Size(screenWidth * 0.13, screenHeight * 0.05),
                                    ),
                                    onPressed: (){
                                      setState(() {
                                        menus[i].set_nombre(controllers[i].text);
                                      });
                                    },

                                    child: Text('Actualizar Nombre', style: TextStyle(
                                      fontSize: screenHeight * 0.02,
                                    ),),
                                    
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(screenWidth * 0.1, screenHeight * 0.05),
                                      maximumSize: Size(screenWidth * 0.13, screenHeight * 0.05),
                                    ),
                                    
                                    onPressed: () {
                                      // Lógica para examinar PDF
                                    },
                                    child: Text('Examinar PDF', style: TextStyle(
                                      fontSize: screenHeight * 0.02,
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
                              SizedBox(width: screenWidth * 0.02),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(screenWidth * 0.2, screenHeight * 0.1),
                                  maximumSize: Size(screenWidth * 0.2, screenHeight * 0.1),
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: () {
                                  setState((){
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context){
                                        return AlertDialog(
                                          content: Column(children: [
                                            const Text("Menus asignados",
                                              style: TextStyle(
                                                fontFamily: 'Open Sans',
                                                fontSize: 40,
                                                color: Colors.red
                                              )),
                                            Container(height: screenHeight*0.7, child: SingleChildScrollView(
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
                                            SizedBox(height: screenHeight*0.05),
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
                                          ],) 
                                          
                                        );
                                      }
                                    );
                                  });
                                },
                                child: Text(
                                  'Consultar Comanda',
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.03,
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