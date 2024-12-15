import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:dali/controlers/controladores.dart';
import 'package:dali/models/tareaAsignada2.dart';
import 'package:dali/screen/chatAlumno.dart';
import 'package:dali/widget/reproductorPasos.dart';
import 'package:flutter/material.dart';

class PresentacionTarea extends StatefulWidget {
  int idTareaAsignada = 37;
  PresentacionTarea({super.key});

  @override
  _PresentacionTareaState createState() => _PresentacionTareaState();
}

class _PresentacionTareaState extends State<PresentacionTarea> {
  late ConfettiController confettiController;

  void volverAtras(BuildContext context) {
    Navigator.of(context).pop();
  }

  TareaAsignada2? _tareaAsingada; // Permitir que sea null inicialmente

  int paso_actual = 0;
  int pasos_total = 2;
  String paso_final = 'images/feliz.png';

  List<String> pasos_img = [];
  List<String> pasos_vid = [];
  List<String> pasos_picto = [];
  List<String> pasos_audio = [];
  List<String> pasos_texto = [];

  String formato_princ = "Imagen";
  List<String> formatos_adic = ["Texto", "Video", "Audio", "Pictograma"];
  String formato_actual = ""; // Inicializar al formato por defecto del alumno

  @override
  void initState() {
    super.initState();
    confettiController =
        ConfettiController(duration: const Duration(milliseconds: 800));
    _cargarTareaAsignada();
  }

  void _cargarTareaAsignada() async {
    // Cargar la tarea asignada
    TareaAsignada2? aux =
        await Controladores().getTareaAsignada(widget.idTareaAsignada);
    setState(() {
      _tareaAsingada = aux;
      if (_tareaAsingada != null) {
        paso_actual = 0;
        pasos_total = _tareaAsingada!.tareaPlantilla.pasos!.urlAudio.length - 1;
        pasos_img = _tareaAsingada!.tareaPlantilla.pasos!.urlImagen;
        pasos_vid = _tareaAsingada!.tareaPlantilla.pasos!.urlVideo;
        pasos_picto = _tareaAsingada!.tareaPlantilla.pasos!.urlPictograma;
        pasos_audio = _tareaAsingada!.tareaPlantilla.pasos!.urlAudio;
        pasos_texto = _tareaAsingada!.tareaPlantilla.pasos!.urlTexto.split(" | ");

        List<String> formatos =
            _tareaAsingada!.formato.split(",").map((e) => e.trim()).toList();
        formato_princ = formatos[0];
        formatos_adic = formatos.sublist(1);
        formato_actual = formato_princ;

        print("El formato es: ${_tareaAsingada?.formato}");
        print("El formato principal es: $formato_princ");
        print("Los formatos adicionales son: $formatos_adic");

        print("Los pasos totales son: $pasos_total");

      }
    });
  }

  TipoPaso _getTipoPaso(String formato) {
    switch (formato) {
      case "Texto":
        return TipoPaso.texto;
      case "Imagen":
        return TipoPaso.imagen;
      case "Video":
        return TipoPaso.video;
      case "Audio":
        return TipoPaso.audio;
      default:
        return TipoPaso.texto; // Por defecto, se considera texto.
    }
  }

  String _getContenido(String formato) {
    switch (formato) {
      case "Texto":
        return pasos_texto[paso_actual];
      case "Imagen":
        return pasos_img[paso_actual];
      case "Video":
        return pasos_vid[paso_actual];
      case "Audio":
        return pasos_audio[paso_actual];
      default:
        return pasos_img[paso_actual]; // Por defecto, se considera imagen.
    }
  }

  // bool hay_formato(String formato) {
  //   if (formato == formato_princ) {
  //     return true;
  //   } else {
  //     for (int i = 0; i < formatos_adic.length; i++) {
  //       print("Voy a comparar $formato con ${formatos_adic[i]}");
  //       if (formato == formatos_adic[i]) {
  //         return true;
  //       }
  //       print("No es igual");
  //     }
  //   }
  //   print("No hay formato $formato");
  //   return false;
  // }
  bool hay_formato(String formato) {
    return formato == formato_princ || formatos_adic.contains(formato);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Comprobar si _tareaAsingada es null
    if (_tareaAsingada == null) {
      // Mostrar un indicador de carga mientras se espera a los datos
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Mostrar el contenido cuando _tareaAsingada esté inicializado
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
                Container(
                  width: screenWidth * 0.8,
                  child: FittedBox(
                    fit: BoxFit
                        .scaleDown, // Escala hacia abajo si el texto es demasiado grande
                    child: Text(
                      _tareaAsingada!.tareaPlantilla.titulo,
                      style: TextStyle(
                        fontSize: screenWidth * 0.08,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: screenWidth * 0.03)
              ],
            ),
            //Segunda fila
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0), // Ajusta el valor de los márgenes aquí
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          hay_formato("Imagen")
                              ? Container(
                                  //Botón modo fotos
                                  width: screenWidth * 0.05,
                                  height: screenWidth * 0.05,
                                  decoration: BoxDecoration(
                                    color: formato_actual == "Imagen"
                                        ? Color.fromRGBO(5, 153, 159, 1)
                                        : Colors.red,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(8),
                                    border: formato_actual == "Imagen"
                                        ? Border.all(
                                            color: Colors.black,
                                            width: 2.0,
                                          )
                                        : null,
                                  ),
                                  child: IconButton(
                                    icon: Image.asset(
                                      'images/camara.png',
                                      color: Colors.white,
                                      width: screenWidth * 0.05,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        formato_actual = "Imagen";
                                      });
                                    },
                                  ),
                                )
                              : Container(),
                          hay_formato("Imagen")
                              ? SizedBox(
                                  height: screenHeight * 0.02,
                                )
                              : SizedBox.shrink(),
                          hay_formato("Video")
                              ? Container(
                                  //Botón modo vídeo
                                  width: screenWidth * 0.05,
                                  height: screenWidth * 0.05,
                                  decoration: BoxDecoration(
                                    color: formato_actual == "Video"
                                        ? Color.fromRGBO(5, 153, 159, 1)
                                        : Colors.red,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(8),
                                    border: formato_actual == "Video"
                                        ? Border.all(
                                            color: Colors.black,
                                            width: 2.0,
                                          )
                                        : null,
                                  ),
                                  child: IconButton(
                                    icon: Image.asset(
                                      'images/boton-de-play.png',
                                      color: Colors.white,
                                      width: screenWidth * 0.05,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        formato_actual = "Video";
                                      });
                                    },
                                  ),
                                )
                              : Container(),
                          hay_formato("Video")
                              ? SizedBox(
                                  height: screenHeight * 0.02,
                                )
                              : SizedBox.shrink(),
                          hay_formato("Pictograma")
                              ? Container(
                                  //Botón modo picto
                                  width: screenWidth * 0.05,
                                  height: screenWidth * 0.05,
                                  decoration: BoxDecoration(
                                    color: formato_actual == "Pictograma"
                                        ? Color.fromRGBO(5, 153, 159, 1)
                                        : Colors.red,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(8),
                                    border: formato_actual == "Pictograma"
                                        ? Border.all(
                                            color: Colors.black,
                                            width: 2.0,
                                          )
                                        : null,
                                  ),
                                  child: IconButton(
                                    icon: Image.asset(
                                      'images/pintar-lienzo.png',
                                      color: Colors.white,
                                      width: screenWidth * 0.05,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        formato_actual = "Pictograma";
                                      });
                                    },
                                  ),
                                )
                              : Container(),
                          hay_formato("Pictograma")
                              ? SizedBox(
                                  height: screenHeight * 0.02,
                                )
                              : SizedBox.shrink(),
                          hay_formato("Audio")
                              ? Container(
                                  //Botón modo audio
                                  width: screenWidth * 0.05,
                                  height: screenWidth * 0.05,
                                  decoration: BoxDecoration(
                                    color: formato_actual == "Audio"
                                        ? Color.fromRGBO(5, 153, 159, 1)
                                        : Colors.red,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(8),
                                    border: formato_actual == "Audio"
                                        ? Border.all(
                                            color: Colors.black,
                                            width: 2.0,
                                          )
                                        : null,
                                  ),
                                  child: IconButton(
                                    icon: Image.asset(
                                      'images/herramienta-de-audio-con-altavoz.png',
                                      color: Colors.white,
                                      width: screenWidth * 0.05,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        formato_actual = "Audio";
                                      });
                                    },
                                  ),
                                )
                              : Container(),
                          hay_formato("Audio")
                              ? SizedBox(
                                  height: screenHeight * 0.02,
                                )
                              : SizedBox.shrink(),
                          hay_formato("Texto")
                              ? Container(
                                  //Botón modo texto
                                  width: screenWidth * 0.05,
                                  height: screenWidth * 0.05,
                                  decoration: BoxDecoration(
                                    color: formato_actual == "Texto"
                                        ? Color.fromRGBO(5, 153, 159, 1)
                                        : Colors.red,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(8),
                                    border: formato_actual == "Texto"
                                        ? Border.all(
                                            color: Colors.black,
                                            width: 2.0,
                                          )
                                        : null,
                                  ),
                                  child: IconButton(
                                    icon: Image.asset(
                                      'images/texto.png',
                                      color: Colors.white,
                                      width: screenWidth * 0.05,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        formato_actual = "Texto";
                                      });
                                    },
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ],
                  ),
                  // Container(
                  //   //Pasos de la tarea
                  //   width: screenWidth * 0.5,
                  //   height: screenHeight * 0.7,
                  //   decoration: BoxDecoration(
                  //     color: const Color(0xFF05999F),
                  //     borderRadius: BorderRadius.circular(screenWidth * 0.07),
                  //   ),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         paso_actual > pasos_total
                  //             ? "Final"
                  //             : "Paso " + (paso_actual + 1).toString(),
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: screenWidth * 0.03,
                  //           fontFamily: 'Open Sans',
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: screenHeight * 0.04,
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //         children: [
                  //           //Flecha para la izquierda (si la tarea anterior existe)
                  //           SizedBox(
                  //             width: screenWidth * 0.1,
                  //             child: AbsorbPointer(
                  //               absorbing: paso_actual == 0,
                  //               child: Opacity(
                  //                 opacity: paso_actual == 0 ? 0.0 : 1.0,
                  //                 child: IconButton(
                  //                   icon: Image.asset(
                  //                     'images/flecha-izquierda.png',
                  //                     fit: BoxFit.cover,
                  //                   ),
                  //                   iconSize: screenWidth * 0.1,
                  //                   onPressed: () {
                  //                     setState(() {
                  //                       if (paso_actual > 0) paso_actual--;
                  //                     });
                  //                   },
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //           formato_actual == "Texto" &&
                  //                   paso_actual <= pasos_total
                  //               ? Text(
                  //                   pasos_texto[paso_actual],
                  //                   style: TextStyle(
                  //                     color: Colors.white,
                  //                     fontSize: screenWidth * 0.02,
                  //                     fontFamily: 'Open Sans',
                  //                   ),
                  //                 )
                  //               :
                  //               Container(
                  //                   width: screenWidth * 0.3,
                  //                   height: screenHeight * 0.4,
                  //                   decoration: BoxDecoration(
                  //                     borderRadius: BorderRadius.circular(16.0),
                  //                     image: formato_actual == "Texto" &&
                  //                             paso_actual <= pasos_total
                  //                         ? null
                  //                         : DecorationImage(
                  //                               image: paso_actual <= pasos_total
                  //                                 ? NetworkImage(
                  //                                   () {
                  //                                   switch (formato_actual) {
                  //                                     case "Imagen":
                  //                                     return pasos_img[
                  //                                       paso_actual];
                  //                                     case "Video":
                  //                                     return pasos_vid[
                  //                                       paso_actual];
                  //                                     case "Pictograma":
                  //                                     return pasos_picto[
                  //                                       paso_actual];
                  //                                     case "Audio":
                  //                                     return pasos_audio[
                  //                                       paso_actual];
                  //                                     default:
                  //                                     return pasos_img[
                  //                                       paso_actual];
                  //                                   }
                  //                                   }(),
                  //                                 )
                  //                                 : AssetImage(paso_final)
                  //                                   as ImageProvider,
                  //                           ),
                  //                   ),
                  //                   // child: formato_actual == "Texto" &&
                  //                   //         paso_actual <= pasos_total
                  //                   //     ? Text(
                  //                   //         pasos_texto[paso_actual],
                  //                   //         style: TextStyle(
                  //                   //             fontSize: 18,
                  //                   //             color: Colors.black),
                  //                   //       )
                  //                   //     : ReproductorPasos(
                  //                   //         tipoPaso:
                  //                   //             _getTipoPaso(formato_actual),
                  //                   //         contenido:
                  //                   //             _getContenido(formato_actual),
                  //                   //       ),
                  //                   child: formato_actual == "Texto" &&
                  //                           paso_actual <= pasos_total
                  //                       ? Text(
                  //                           pasos_texto[paso_actual],
                  //                           style: TextStyle(
                  //                               fontSize: 18,
                  //                               color: Colors.black),
                  //                         )
                  //                       : ReproductorPasos(
                  //                           tipoPaso:
                  //                               _getTipoPaso(formato_actual),
                  //                           contenido:
                  //                               _getContenido(formato_actual),
                  //                         ),
                  //                 ),

                  //           SizedBox(
                  //             width: MediaQuery.of(context).size.width * 0.1,
                  //             child: AbsorbPointer(
                  //               absorbing: paso_actual > pasos_total,
                  //               child: Opacity(
                  //                 opacity:
                  //                     paso_actual > pasos_total ? 0.0 : 1.0,
                  //                 child: IconButton(
                  //                   icon: Image.asset(
                  //                     'images/flecha-derecha.png',
                  //                     fit: BoxFit.cover,
                  //                   ),
                  //                   iconSize:
                  //                       MediaQuery.of(context).size.width * 0.1,
                  //                   onPressed: () {
                  //                     //ir a siguiente paso
                  //                     setState(() {
                  //                       if (paso_actual <= pasos_total)
                  //                         paso_actual++;
                  //                     });
                  //                   },
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),

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
                                    formato_actual == "Texto" && paso_actual <= pasos_total
    ? ReproductorPasos(
        key: ValueKey("texto_${paso_actual}"), 
        tipoPaso: TipoPaso.texto,
        contenido: pasos_texto[paso_actual],
      )
    : formato_actual == "Imagen" && paso_actual <= pasos_total
        ? Container(
            width: screenWidth * 0.3,
            height: screenHeight * 0.4,
            child: ReproductorPasos(
              tipoPaso: TipoPaso.imagen,
              contenido: pasos_img[paso_actual],
            ),
          )
        : formato_actual == "Video" && paso_actual <= pasos_total
            ? Container(
                width: screenWidth * 0.3,
                height: screenHeight * 0.4,
                child: ReproductorPasos(
                  key: ValueKey("imagen_${paso_actual}"),
                  tipoPaso: TipoPaso.video,
                  contenido: pasos_vid[paso_actual],
                ),
              )
            : formato_actual == "Pictograma" && paso_actual <= pasos_total
                ? Container(
                    width: screenWidth * 0.3,
                    height: screenHeight * 0.4,
                    child: ReproductorPasos(
                      // key: ValueKey("picto_${paso_actual}"),
                        key: ValueKey("picto_${paso_actual}_${DateTime.now().millisecondsSinceEpoch}"),
                      tipoPaso: TipoPaso.imagen,
                      contenido: pasos_picto[paso_actual],
                    ),
                  )
                : formato_actual == "Audio" && paso_actual <= pasos_total
                    ? ReproductorPasos(
                        tipoPaso: TipoPaso.audio,
                        contenido: pasos_audio[paso_actual],
                      )
                    : Container(
                        width: screenWidth * 0.3,
                        height: screenHeight * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          image: DecorationImage(
                            image: AssetImage(paso_final),
                            fit: BoxFit.contain,
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
                      Container(
                        //Botón al chat
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatAlumno(),
                                  ),
                                );
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
                      SizedBox(height: screenHeight * 0.04),
                      Container(
                        //Botón terminar
                        width: screenWidth * 0.15,
                        height: screenWidth * 0.15,
                        decoration: BoxDecoration(
                          color: paso_actual > pasos_total
                              ? Colors.red
                              : const Color.fromARGB(255, 228, 149, 143),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AbsorbPointer(
                              absorbing: paso_actual <= pasos_total,
                              child: Opacity(
                                opacity: paso_actual > pasos_total
                                    ? 1.0
                                    : 0.5, // Baja opacidad cuando está desactivado
                                child: IconButton(
                                  icon: Image.asset(
                                    'images/terminar.png',
                                    color: Colors.white,
                                    width: screenWidth * 0.1,
                                  ),
                                  onPressed: /*paso_actual >= pasos_total
                                          ? () {}//null  // Desactiva el botón si la condición se cumple
                                          :*/
                                      () {
                                    setState(() {
                                      confettiController.play();
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                //Animación confeti
                                                const Text(
                                                    "¡Felicidades! ¡Tarea terminada!",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            5, 153, 159, 1),
                                                        fontFamily: 'Roboto',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 50)),

                                                FilledButton(
                                                  style: FilledButton.styleFrom(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    screenWidth *
                                                                        0.01)),
                                                    backgroundColor: Colors.red,
                                                    minimumSize: Size(
                                                        screenHeight * 0.2,
                                                        screenHeight * 0.2),
                                                    maximumSize: Size(
                                                        screenHeight * 0.2,
                                                        screenHeight * 0.2),
                                                  ),
                                                  onPressed: () {
                                                    volverAtras(
                                                        context); //Debe hacerlo dos veces para cerrar el diálogo y volver hacia la pantalla anterior
                                                    volverAtras(context);
                                                  },
                                                  child: Column(children: [
                                                    Image.asset(
                                                      "images/si.png",
                                                      width: screenWidth * 0.07,
                                                    ),
                                                    Text(
                                                      "Continuar",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Open Sans",
                                                          fontSize:
                                                              screenHeight *
                                                                  0.025),
                                                    ),
                                                  ]),
                                                ),
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: ConfettiWidget(
                                                    confettiController:
                                                        confettiController,
                                                    blastDirection: -pi / 2,
                                                    emissionFrequency: 0.06,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    });
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
          ]),
    ));
  }
}
