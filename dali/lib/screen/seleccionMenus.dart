import 'package:dali/screen/comandasAlumno.dart';
import 'package:flutter/material.dart';
import 'package:dali/models/aula.dart';
import 'package:dali/models/menu.dart';

class SeleccionMenus extends StatefulWidget {

  Aula aula = Aula("nombre", "imagen", [Menu("nombre", "imagen")]);
  bool modo_picto = false;

  SeleccionMenus(Aula actual, bool modo_picto){
    this.aula = actual;
    this.modo_picto = modo_picto;
  }

  @override
  _SeleccionMenusState createState() => _SeleccionMenusState(this.aula, this.modo_picto);
}

class _SeleccionMenusState extends State<SeleccionMenus> {
  Aula aula = Aula("nombre", "imagen", [Menu("nombre", "imagen")]);
  bool modo_picto = false;
  int menu_actual = 0;

  _SeleccionMenusState(Aula actual, bool modo_picto){
    this.aula = actual;
    this.modo_picto = modo_picto;
  }

  void volverAtras(BuildContext context) {
    Navigator.of(context).pop();
  }
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(screenWidth * 0.01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Primera fila: Back, Texto
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      IconButton(
                        icon: Image(
                          image: const AssetImage('images/back-arrow.png'),
                          width: MediaQuery.of(context).size.width * 0.04,
                          height: MediaQuery.of(context).size.width * 0.04,
                        ),
                        onPressed: () => volverAtras(context),
                      ), // Icono de perfil
                    Text('Pedir Comandas',
                        style: TextStyle(
                          fontSize: screenWidth * 0.08,
                          fontWeight: FontWeight.bold,
                        )),

                    SizedBox(width: screenWidth * 0.03)
                  ],
                ),
                Row(children: [
                  
                  Column(children: [
                    Text("Pedir menús (" + aula.nombre + ")",
                        style: TextStyle(
                          fontSize: screenWidth * 0.03,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(5, 153, 159, 1),
                        ),),
                  Column(children: [
                      Column(
                        children: [
                          Row(
                          children: [
                          SizedBox(
                            width: screenWidth * 0.1,
                            child: IconButton(
                              icon: Image.asset(
                                'images/flecha-izquierda.png',
                              ),
                              iconSize: screenWidth * 0.1,
                              onPressed: () {
                                setState(() {
                                  if(menu_actual > 0)
                                    menu_actual--;
                                  else
                                    menu_actual = aula.menus.length - 1;
                                });
                              },
                            ),
                          ),
                          modo_picto == false ?
                          Text(
                            aula.menus[menu_actual].nombre,
                            style: const TextStyle(
                              fontFamily: "Open Sans",
                              fontSize: 30
                            )):
                          Image.asset(aula.menus[menu_actual].picto, width: screenWidth*0.06),
                          SizedBox(width: screenWidth*0.02),
                          modo_picto == false ?
                          Row(
                            children: [
                              Container(
                                width: screenWidth * 0.05,
                                height: screenHeight * 0.1,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(176, 211, 255, 1),
                                  borderRadius: BorderRadius.circular(screenWidth * 0.01),
                                ),
                                child: Center(
                                  child: Text(
                                    (aula.menus[menu_actual].cantidad).toString(),
                                    style: const TextStyle(
                                      fontFamily: "Open Sans",
                                      fontSize: 30),))
                              ),
                              SizedBox(width: screenWidth*0.02),
                                FilledButton(
                                  style: FilledButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(screenWidth * 0.01)),
                                      backgroundColor: Colors.red,
                                      minimumSize: Size(screenHeight * 0.1, screenHeight * 0.1),
                                      maximumSize: Size(screenHeight * 0.1, screenHeight * 0.1),
                                  ),
                                  onPressed: () {
                                    setState((){aula.menus[menu_actual].dism_cant();});
                                  },
                                  child:
                                    Text(
                                      "-",
                                      style: TextStyle(
                                        fontFamily: "Open Sans",
                                        fontSize: screenHeight*0.07
                                      ),
                                    )
                                  ),
                                SizedBox(width: screenWidth*0.02,),
                                FilledButton(
                                  style: FilledButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(screenWidth * 0.01)),
                                      backgroundColor: Colors.red,
                                      minimumSize: Size(screenHeight * 0.1, screenHeight * 0.1),
                                      maximumSize: Size(screenHeight * 0.1, screenHeight * 0.1),
                                  ),
                                  onPressed: () {
                                    setState((){aula.menus[menu_actual].aumentar_cant();});
                                  },
                                  child:
                                    Text(
                                      "+",
                                      style: TextStyle(
                                        fontFamily: "Open Sans",
                                        fontSize: screenHeight*0.07
                                      ),
                                    )
                                ),
                            ],
                          ):
                          Column(children: [
                            Row(  children: List.generate(5, (index) {
                            int numero = index + 1;
                            return Row(
                              children: [
                                FilledButton(
                                  style: FilledButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(screenWidth * 0.02),
                                      side: aula.menus[menu_actual].get_cant() == numero ? const BorderSide(color: Colors.black, width: 2):BorderSide.none,
                                    ),
                                    backgroundColor: aula.menus[menu_actual].get_cant() == numero ? const Color.fromRGBO(5, 153, 159, 1):
                                    Colors.red,
                                    minimumSize: Size(screenHeight * 0.15, screenHeight * 0.15),
                                    maximumSize: Size(screenHeight * 0.15, screenHeight * 0.15),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      aula.menus[menu_actual].set_cant(numero);
                                    });
                                  },
                                  child: Image.asset('images/$numero.png'),
                                ),
                                SizedBox(width: screenWidth*0.02)
                              ],
                            );
                          })),
                          SizedBox(height: screenHeight*0.02),
                          Row(  children: List.generate(5, (index) {
                            int numero = index + 6;
                            return Row(
                              children: [
                                FilledButton(
                                  style: FilledButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(screenWidth * 0.02),
                                      side: aula.menus[menu_actual].get_cant() == numero ? const BorderSide(color: Colors.black, width: 2):BorderSide.none,
                                    ),
                                    backgroundColor: aula.menus[menu_actual].get_cant() == numero ? const Color.fromRGBO(5, 153, 159, 1):
                                    Colors.red,
                                    minimumSize: Size(screenHeight * 0.15, screenHeight * 0.15),
                                    maximumSize: Size(screenHeight * 0.15, screenHeight * 0.15),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      aula.menus[menu_actual].set_cant(numero);
                                    });
                                  },
                                  child: Image.asset('images/$numero.png'),
                                ),
                                SizedBox(width: screenWidth*0.02)
                              ],
                            );
                          })),                          ],),
                          SizedBox(
                            width: screenWidth * 0.1,
                            child: IconButton(
                              icon: Image.asset(
                                'images/flecha-derecha.png',
                              ),
                              iconSize: screenWidth * 0.1,
                              onPressed: () {
                                setState(() {
                                  if(menu_actual < aula.menus.length - 1)
                                    menu_actual++;
                                  else
                                    menu_actual = 0;
                                });
                              },
                            ),
                          ),
                          ],
                          ),
                          SizedBox(height: screenHeight*0.01,)
                          ]),
                  ],
                  )
                  ],),
                  SizedBox(width: screenWidth*0.02,),
                  FilledButton( //Botón ver pdf
                    style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    ),
                    backgroundColor: Colors.red,
                    minimumSize: Size(screenWidth * 0.15, screenHeight * 0.35),
                    maximumSize: Size(screenWidth * 0.15, screenHeight * 0.35),
                    ),
                    onPressed: () {
                    },
                    child: Column(children: [
                      SizedBox(height: screenHeight*0.02,),
                      SizedBox(child: Image.asset('images/menu_comedor.png'), width: screenWidth*0.15),
                      const Text(
                        "Ver menú",
                        style: const TextStyle(
                        fontFamily: "Open Sans",
                        color: Colors.white,
                        fontSize: 25
                        ),
                      )
                      ],) ,
                    ),
                ]
                ),
                SizedBox(height: screenHeight*0.1),
                Center(child:
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                    Container(//Botón modo pictogramas
                      width: screenWidth * 0.17,
                      height: screenHeight * 0.22,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          IconButton(
                            icon: Image.asset(
                              modo_picto == false ?
                              'images/manos.png':'images/numeros.png',
                              color: Colors.white,
                              width: screenWidth * 0.07,
                            ),
                            onPressed: () {
                              setState(() {
                              modo_picto = !modo_picto;
                            });
                            },
                            ),
                            Text(
                              modo_picto == false ?"Pictogramas":"Números",
                              style: const TextStyle(
                              fontFamily: "Open Sans",
                              color: Colors.white,
                              fontSize: 25
                            ),
                          )
                        ],
                    ),
                ),
                SizedBox(width: screenWidth*0.5),
                FilledButton( //Botón terminar
                    style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.red,
                    minimumSize: Size(screenWidth * 0.12, screenHeight * 0.21),
                    maximumSize: Size(screenWidth * 0.12, screenHeight * 0.21),
                    ),
                    onPressed: () {
                      setState((){
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Column(children: [
                                  const Text("¿Estás seguro de que quieres elegir estos menús?", style: TextStyle(fontFamily: "Open Sans", fontSize: 40),),
                                  FilledButton(
                                    style: FilledButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(screenWidth * 0.01)),
                                        backgroundColor: Colors.red,
                                        minimumSize: Size(screenHeight * 0.23, screenHeight * 0.23),
                                        maximumSize: Size(screenHeight * 0.23, screenHeight * 0.23),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        aula.terminar();
                                      });
                                      volverAtras(context); //Debe hacerlo dos veces para cerrar el diálogo y volver hacia la pantalla anterior
                                      volverAtras(context);
                                    },
                                    child:
                                      Column(children:[
                                        Image.asset("images/si.png", width: screenWidth*0.07,),
                                        Text(
                                          "SÍ",
                                          style: TextStyle(
                                            fontFamily: "Open Sans",
                                            fontSize: screenHeight*0.05
                                          ),
                                        ),
                                      ]),
                                  ),
                                  SizedBox(height: screenHeight*0.03),
                                  FilledButton(
                                    style: FilledButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(screenWidth * 0.01)),
                                        backgroundColor: Colors.red,
                                        minimumSize: Size(screenHeight * 0.23, screenHeight * 0.23),
                                        maximumSize: Size(screenHeight * 0.23, screenHeight * 0.23),
                                    ),
                                    onPressed: () {
                                      volverAtras(context);
                                    },
                                    child:
                                      Column(children:[
                                        Image.asset("images/no.png", width: screenWidth*0.07,),
                                        Text(
                                          "NO",
                                          style: TextStyle(
                                            fontFamily: "Open Sans",
                                            fontSize: screenHeight*0.05
                                          ),
                                        ),
                                      ]),
                                  ),
                                  ])],
                              ),
                            );
                          },
                        );
                      });
                    },
                    child: Column(children: [
                      SizedBox(height: screenHeight*0.005,),
                      SizedBox(child:Image.asset('images/ok.png', width: screenWidth*0.07,)),
                      SizedBox(height: screenHeight*0.01,),
                      const Text(
                        "Completar",
                        style: const TextStyle(
                        fontFamily: "Open Sans",
                        color: Colors.white,
                        fontSize: 25
                        ), 
                      )
                      ],) ,
                    ),
                  ]))

              ]
            ),
        )
    );
  }
}