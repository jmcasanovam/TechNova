import 'package:dali/models/tareaAsignada.dart';
import 'package:flutter/material.dart';


class PresentacionTarea extends StatefulWidget{
  const PresentacionTarea({super.key});

  @override
  _PresentacionTareaState createState() => _PresentacionTareaState();
}

class _PresentacionTareaState extends State<PresentacionTarea>{

  void volverAtras(BuildContext context) {
    Navigator.of(context).pop();
  }

  final TareaAsignada _tarea = TareaAsignada('¡Pongamos el microondas!', 'images/comedor.png', 'video', 1);

  int paso_actual = 0;
  int pasos_total = 2;
  String paso_final = 'images/feliz.png';


  List<String> pasos_img = ['images/logo_technova_con_fondo.png', 'images/hoy.png', 'images/logoapp_general.png'];
  List<String> pasos_vid = ['images/vídeo en línea.png', 'images/vídeo en línea.png', 'images/vídeo en línea.png',];
  List<String> pasos_picto = ['images/microondas.png', 'images/pulsar.png', 'images/camarero.png',];
  List<String> pasos_audio = ['images/herramienta-de-audio-con-altavoz.png', 'images/herramienta-de-audio-con-altavoz.png', 'images/herramienta-de-audio-con-altavoz.png',];
  List<String> pasos_texto = ["Abre el microondas.", "Dale al botón.", "Cierra el microondas."];

  String formato_princ = "img";
  List<String> formatos_adic = ["txt", "pic", "vid"];
  String formato_actual = ""; //inicializar al formato por defecto del alumno

  bool hay_formato(String formato){
    if(formato == formato_princ){
      return true;
    }
    else{
      for(int i = 0; i<formatos_adic.length; i++){
        if(formato == formatos_adic[i]){
          return true;
        }
      }
    }

    return false;
  }

  @override
  void initState() {
    super.initState();
    formato_actual = formato_princ;
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
            body: Padding(
            padding: EdgeInsets.all(screenWidth * 0.01),
            child: Column(
              //Primera fila: Back, Texto adaptable
              children: [
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
                    /*Text(_tarea.nombre,
                        style: TextStyle(
                          fontSize: screenWidth * 0.08,
                          fontWeight: FontWeight.bold,
                        )),*/
                      Container(
                        width: screenWidth * 0.8,
                        child:
                          FittedBox(
                            fit: BoxFit.scaleDown, // Escala hacia abajo si el texto es demasiado grande
                            child: Text(
                              _tarea.nombre,
                              style: TextStyle(
                                fontSize: screenWidth * 0.08,
                                fontWeight: FontWeight.bold,
                              ),
                            ),),
                      ),

                    SizedBox(width: screenWidth * 0.03)
                  ],
                ),
                //Segunda fila
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),  // Ajusta el valor de los márgenes aquí
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              hay_formato("img")?Container( //Botón modo fotos
                                width: screenWidth * 0.05,
                                height: screenWidth * 0.05,
                                decoration: BoxDecoration(
                                  color: formato_actual=="img"?Color.fromRGBO(5, 153, 159, 1):Colors.red,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(8),
                                  border: formato_actual=="img"?Border.all(
                                    color: Colors.black,
                                    width: 2.0,
                                  ):null,
                                ),
                                child: IconButton(
                                  icon: Image.asset(
                                    'images/camara.png',
                                    color: Colors.white,
                                    width: screenWidth * 0.05,
                                  ),
                                  onPressed: () {
                                    setState((){
                                      formato_actual = "img";
                                    });
                                  },
                                ),
                              ):Container(),
                              hay_formato("img")?SizedBox(
                                height: screenHeight * 0.02,
                              ):SizedBox.shrink(),
                              hay_formato("vid")?Container(//Botón modo vídeo
                                width: screenWidth * 0.05,
                                height: screenWidth * 0.05,
                                decoration: BoxDecoration(
                                  color: formato_actual=="vid"?Color.fromRGBO(5, 153, 159, 1):Colors.red,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(8),
                                  border: formato_actual=="vid"?Border.all(
                                    color: Colors.black,
                                    width: 2.0,
                                  ):null,
                                ),
                                child: IconButton(
                                  icon: Image.asset(
                                    'images/boton-de-play.png',
                                    color: Colors.white,
                                    width: screenWidth * 0.05,
                                  ),
                                  onPressed: () {
                                    setState((){
                                      formato_actual = "vid";
                                    });                                  
                                  },
                                ),
                              ):Container(),
                              hay_formato("vid")?SizedBox(
                                height: screenHeight * 0.02,
                              ):SizedBox.shrink(),
                              hay_formato("pic")?Container(//Botón modo picto
                                width: screenWidth * 0.05,
                                height: screenWidth * 0.05,
                                decoration: BoxDecoration(
                                  color: formato_actual=="pic"?Color.fromRGBO(5, 153, 159, 1):Colors.red,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(8),
                                  border: formato_actual=="pic"?Border.all(
                                    color: Colors.black,
                                    width: 2.0,
                                  ):null,
                                ),
                                child: IconButton(
                                  icon: Image.asset(
                                    'images/pintar-lienzo.png',
                                    color: Colors.white,
                                    width: screenWidth * 0.05,
                                  ),
                                  onPressed: () {
                                    setState((){
                                      formato_actual = "pic";
                                    });
                                  },
                                ),
                              ):Container(),
                              hay_formato("pic")?SizedBox(
                                height: screenHeight * 0.02,
                              ):SizedBox.shrink(),
                              hay_formato("aud")?Container(//Botón modo audio
                                width: screenWidth * 0.05,
                                height: screenWidth * 0.05,
                                decoration: BoxDecoration(
                                  color: formato_actual=="aud"?Color.fromRGBO(5, 153, 159, 1):Colors.red,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(8),
                                  border: formato_actual=="aud"?Border.all(
                                    color: Colors.black,
                                    width: 2.0,
                                  ):null,
                                ),
                                child: IconButton(
                                  icon: Image.asset(
                                    'images/herramienta-de-audio-con-altavoz.png',
                                    color: Colors.white,
                                    width: screenWidth * 0.05,
                                  ),
                                  onPressed: () {
                                    setState((){
                                      formato_actual = "aud";
                                    });
                                  },
                                ),
                              ):Container(),
                              hay_formato("aud")?SizedBox(
                                height: screenHeight * 0.02,
                              ):SizedBox.shrink(),
                              hay_formato("txt")?Container(//Botón modo texto
                                width: screenWidth * 0.05,
                                height: screenWidth * 0.05,
                                decoration: BoxDecoration(
                                  color: formato_actual=="txt"?Color.fromRGBO(5, 153, 159, 1):Colors.red,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(8),
                                  border: formato_actual=="txt"?Border.all(
                                    color: Colors.black,
                                    width: 2.0,
                                  ):null,
                                ),
                                child: IconButton(
                                  icon: Image.asset(
                                    'images/texto.png',
                                    color: Colors.white,
                                    width: screenWidth * 0.05,
                                  ),
                                  onPressed: () {
                                    setState((){
                                      formato_actual = "txt";
                                    });
                                  },
                                ),
                              ):Container(),                                                
                          ],
                          ),
                        ],
                      ),
                      Container( //Pasos de la tarea
                          width: screenWidth * 0.5,
                          height: screenHeight * 0.7,
                          decoration: BoxDecoration(
                            color: const Color(0xFF05999F),
                            borderRadius: BorderRadius.circular(screenWidth * 0.07),
                          ),
                          child:
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  paso_actual > pasos_total ? "Final": "Paso " + (paso_actual + 1).toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.03,
                                    fontFamily: 'Open Sans',
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.04,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    //Flecha para la izquierda (si la tarea anterior existe)
                                    SizedBox(
                                      width: screenWidth * 0.1,
                                      child: AbsorbPointer(
                                        absorbing: paso_actual == 0,
                                        child: Opacity(
                                          opacity: paso_actual == 0 ? 0.0 : 1.0,
                                          child: IconButton(
                                            icon: Image.asset(
                                              'images/flecha-izquierda.png',
                                              fit: BoxFit.cover,
                                            ),
                                            iconSize: screenWidth * 0.1,
                                            onPressed: () {
                                              setState((){
                                                if(paso_actual > 0)
                                                  paso_actual--;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    formato_actual == "txt" && paso_actual <= pasos_total?
                                    Text(pasos_texto[paso_actual],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: screenWidth * 0.02,
                                            fontFamily: 'Open Sans',
                                          ),):
                                    Container(
                                      width: screenWidth * 0.3,
                                      height: screenHeight * 0.4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16.0),
                                        image: formato_actual == "txt" && paso_actual <= pasos_total
                                        ? null
                                        : DecorationImage(
                                          image: AssetImage(
                                            () {
                                              if(paso_actual <= pasos_total){
                                                switch (formato_actual) {
                                                  case "img":
                                                    return pasos_img[paso_actual];
                                                  case "vid":
                                                    return pasos_vid[paso_actual];
                                                  case "pic":
                                                    return pasos_picto[paso_actual];
                                                  case "aud":
                                                    return pasos_audio[paso_actual];
                                                  default:
                                                    return pasos_img[paso_actual];
                                                }
                                              }
                                              else{
                                                return paso_final;
                                              }
                                            }(),
                                          ),
                                          //fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.1,
                                        child: AbsorbPointer(
                                          absorbing: paso_actual > pasos_total,
                                          child: Opacity(
                                            opacity: paso_actual > pasos_total ? 0.0 : 1.0,
                                            child: IconButton(
                                              icon: Image.asset(
                                              'images/flecha-derecha.png',
                                              fit: BoxFit.cover,
                                            ),
                                            iconSize: MediaQuery.of(context).size.width * 0.1,
                                            onPressed: () {
                                              //ir a siguiente paso
                                              setState((){
                                                if(paso_actual <= pasos_total)
                                                  paso_actual++;
                                              });
                                            },
                                            ),
                                          ),
                                        ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                      ),
                      Column(
                        children: [
                        Container(//Botón al chat
                          width: screenWidth * 0.15,
                          height: screenWidth * 0.15,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(40),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Image.asset(
                                    'images/chat-alumno.png',
                                    color: Colors.white,
                                    width: screenWidth * 0.1,
                                  ),
                                  onPressed: () {
                                    // Acción del botón
                                  },
                                ),
                                Text(
                                  "Chat",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.02,
                                    fontFamily: 'Open Sans',
                                  ),
                                ),
                              ],
                            ),
                        ),
                        SizedBox(height: screenHeight*0.04),
                        Container(//Botón terminar
                          width: screenWidth * 0.15,
                          height: screenWidth * 0.15,
                          decoration: BoxDecoration(
                            color: paso_actual > pasos_total ? Colors.red: const Color.fromARGB(255, 228, 149, 143),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(40),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AbsorbPointer(
                                  absorbing: paso_actual <= pasos_total,
                                  child: Opacity(
                                    opacity: paso_actual > pasos_total ? 0.5 : 1.0,  // Baja opacidad cuando está desactivado
                                    child: IconButton(
                                      icon: Image.asset(
                                        'images/terminar.png',
                                        color: Colors.white,
                                        width: screenWidth * 0.1,
                                      ),
                                      onPressed: paso_actual > pasos_total
                                          ? () {}//null  // Desactiva el botón si la condición se cumple
                                          : () {
                                              // Acción del botón cuando está activo
                                            },
                                    ),
                                  ),
                                ),
                                Text(
                                  "Terminar",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.02,
                                    fontFamily: 'Open Sans',
                                  ),
                                ),
                              ],
                            ),
                        ),
                      ],
                      ),
                                      
                    ],
                  ),
                ),
              ]
            ),
    ));
  }
}

