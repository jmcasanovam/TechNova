import 'package:flutter/material.dart';
import 'package:dali/models/aula.dart';
import 'package:dali/models/menu.dart';
import 'package:dali/screen/seleccionMenus.dart';

class ComandasAlumno extends StatefulWidget {
  const ComandasAlumno({super.key});

  @override
  _ComandasAlumnoState createState() => _ComandasAlumnoState();
}

class _ComandasAlumnoState extends State<ComandasAlumno> {
  void volverAtras(BuildContext context) {
    Navigator.of(context).pop();
  }

  List<List<Aula>> paginarAulas(List<Aula> aulas, int tamanioPagina) {
    List<List<Aula>> paginas = [];
    for (int i = 0; i < aulas.length; i += tamanioPagina) {
      paginas.add(aulas.sublist(i,
          i + tamanioPagina > aulas.length ? aulas.length : i + tamanioPagina));
    }
    return paginas;
  }

  bool estanAulasTerminadas(){
    int nterminadas = 0;
    for(int i = 0; i < aulas.length; i++){
      if(aulas[i].terminada){
        nterminadas++;
      }
    }

    return nterminadas == aulas.length;
  }

  int pagina_actual = 0;
  int aulas_por_pag = 6;
  bool modo_picto = false;
  List<Menu> menus1 = [];
  List<Menu> menus2 = [];
  List<Aula> aulas = [];

  @override
  void initState() {
    super.initState();
    menus1 = [
      Menu("Menu 1", "images/1.png"),
      Menu("Menu 2", "images/2.png"),
      Menu("Menu 3", "images/3.png"),
      Menu("Menu 4", "images/4.png"),
    ];

    menus2 = [
      Menu("Menu 1", "images/1.png"),
      Menu("Menu 2", "images/2.png"),
      Menu("Menu 3", "images/3.png"),
      Menu("Menu 4", "images/4.png"),
    ];

    aulas = [
      Aula("AULA 1", "images/1.png", menus1),
      Aula("AULA 2", "images/2.png", menus2),
      Aula("AULA 3", "images/3.png", menus1),
      Aula("AULA 4", "images/4.png", menus2),
      Aula("AULA 5", "images/5.png", menus1),
      Aula("AULA 6", "images/6.png", menus2),
      Aula("AULA 7", "images/7.png", menus1),
      Aula("AULA 8", "images/8.png", menus2),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calcula las páginas solo una vez
    final paginas = paginarAulas(aulas, aulas_por_pag);
    if (pagina_actual >= paginas.length) {
      pagina_actual = 0; // Asegura que el índice esté en el rango
    }

    final lista1 = paginas[pagina_actual].sublist(0, (paginas[pagina_actual].length / 2).ceil());
    final lista2 = paginas[pagina_actual].sublist((paginas[pagina_actual].length / 2).ceil());
    
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Primera fila: Botón de atrás y título
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Image.asset(
                    'images/back-arrow.png',
                    width: screenWidth * 0.04,
                    height: screenWidth * 0.04,
                  ),
                  onPressed: () => volverAtras(context),
                ),
                Text(
                  'Pedir Comandas',
                  style: TextStyle(
                    fontFamily: 'Roboto', 
                    fontSize: screenWidth * 0.08,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
              ],
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '¡Selecciona el aula para la que pedir!',
                    style: TextStyle(
                      fontFamily: 'Roboto', 
                      fontSize: screenWidth * 0.03,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(5, 153, 159, 1),
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.1,
                        child: IconButton(
                          icon: Image.asset('images/flecha-izquierda.png'),
                          iconSize: screenWidth * 0.1,
                          onPressed: () {
                            setState(() {
                              if (pagina_actual > 0) {
                                pagina_actual--;
                              } else {
                                pagina_actual = paginas.length - 1;
                              }
                            });
                          },
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: lista1.map((aula) => _crearBotonAula(aula, screenWidth, screenHeight)).toList(),
                          ),
                          SizedBox(height: screenHeight * 0.025),
                          Row(
                            children: lista2.map((aula) => _crearBotonAula(aula, screenWidth, screenHeight)).toList(),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: screenWidth * 0.1,
                        child: IconButton(
                          icon: Image.asset('images/flecha-derecha.png'),
                          iconSize: screenWidth * 0.1,
                          onPressed: () {
                            setState(() {
                              if (pagina_actual < paginas.length - 1) {
                                pagina_actual++;
                              } else {
                                pagina_actual = 0;
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Center(child:
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,  
                    children:[
                      _crearBotonModoPicto(screenWidth, screenHeight),
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
                        onPressed: !estanAulasTerminadas()?null:() {
                          //guardar comandas y marcar tarea como completada
                          volverAtras(context);
                        },
                        child: Column(children: [
                          SizedBox(height: screenHeight*0.005,),
                          SizedBox(child:Opacity(opacity: !estanAulasTerminadas()?0.5:1.0, child: Image.asset('images/ok.png', width: screenWidth*0.07,))),
                          SizedBox(height: screenHeight*0.01,),
                          const Text(
                            "Completar",
                            style: const TextStyle(
                              fontFamily: 'Roboto', 
                            color: Colors.white,
                            fontSize: 25
                            ), 
                          )
                          ],) ,
                        ),
                  ]))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _crearBotonAula(Aula aula, double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0125),
      child: FilledButton(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.02),
          ),
          backgroundColor: Colors.red,
          minimumSize: Size(screenWidth * 0.17, screenHeight * 0.17),
          maximumSize: Size(screenWidth * 0.17, screenHeight * 0.17),
        ),
        onPressed: aula.get_terminada()?null:() async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SeleccionMenus(aula, modo_picto)),
          );
          setState(() {});
        },
        child: modo_picto
            ? Image.asset(
                aula.picto,
                width: screenWidth * 0.06,
              )
            : Text(
                aula.nombre,
                style: TextStyle(fontFamily: 'Roboto', fontSize: screenHeight * 0.07),
              ),
        
      ),
    );
  }

  Widget _crearBotonModoPicto(double screenWidth, double screenHeight) {
    return Container(
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
              modo_picto ? 'images/numeros.png' : 'images/manos.png',
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
            modo_picto ? "Números" : "Pictogramas",
            style: const TextStyle(
              fontFamily: 'Roboto', 
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }
}
