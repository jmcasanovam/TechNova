import 'package:dali/controlers/controladores.dart';
import 'package:dali/models/pasos.dart';
import 'package:dali/models/tareaPlantilla.dart';
import 'package:dali/widget/adminTitulo.dart';
import 'package:flutter/material.dart';
import '../widget/barraMenu.dart';

class AdminCreadorTareas extends StatefulWidget {
  final String admin;

  const AdminCreadorTareas({super.key, required this.admin});

  @override
  _AdminCreadorTareasState createState() => _AdminCreadorTareasState();
}

class _AdminCreadorTareasState extends State<AdminCreadorTareas> {
  String tituloTarea = '';
  String descripcionTarea = '';
  int numeroDePasos = 1;
  late Tareaplantilla tareaplantilla;
  late Pasos pasos;

  // Controladores para los pasos
  List<String> pasosTexto = [];
  List<String> pasosImagen = [];
  List<String> pasosVideo = [];
  List<String> pasosPictograma = [];
  List<String> pasosAudio = [];
  List<bool> textoCompletado = [];
  List<bool> imagenCompletada = [];
  List<bool> videoCompletado = [];
  List<bool> pictogramaCompletado = [];
  List<bool> audioCompletado = [];

  @override
  void initState() {
    super.initState();
    _inicializarPasos();
  }

  void _inicializarPasos() {
    pasosTexto = List.generate(numeroDePasos, (_) => '');
    pasosImagen = List.generate(numeroDePasos, (_) => '');
    pasosVideo = List.generate(numeroDePasos, (_) => '');
    pasosPictograma = List.generate(numeroDePasos, (_) => '');
    pasosAudio = List.generate(numeroDePasos, (_) => '');

    textoCompletado = List.generate(numeroDePasos, (_) => false);
    imagenCompletada = List.generate(numeroDePasos, (_) => false);
    videoCompletado = List.generate(numeroDePasos, (_) => false);
    pictogramaCompletado = List.generate(numeroDePasos, (_) => false);
    audioCompletado = List.generate(numeroDePasos, (_) => false);
  }

  bool _todosLosPasosCompletados() {
    return textoCompletado.every((completo) => completo) &&
        imagenCompletada.every((completo) => completo) &&
        videoCompletado.every((completo) => completo) &&
        pictogramaCompletado.every((completo) => completo) &&
        audioCompletado.every((completo) => completo) ;
  }

  void _actualizarNumeroDePasos(int nuevoNumero) {
    setState(() {
      // Si el nuevo número es mayor, se añaden pasos vacíos
      if (nuevoNumero > numeroDePasos) {
        int diferencia = nuevoNumero - numeroDePasos;
        pasosTexto.addAll(List.generate(diferencia, (_) => ''));
        pasosImagen.addAll(List.generate(diferencia, (_) => ''));
        pasosVideo.addAll(List.generate(diferencia, (_) => ''));
        pasosPictograma.addAll(List.generate(diferencia, (_) => ''));
        pasosAudio.addAll(List.generate(diferencia, (_) => ''));
        textoCompletado.addAll(List.generate(diferencia, (_) => false));
        imagenCompletada.addAll(List.generate(diferencia, (_) => false));
        videoCompletado.addAll(List.generate(diferencia, (_) => false));
        pictogramaCompletado.addAll(List.generate(diferencia, (_) => false));
        audioCompletado.addAll(List.generate(diferencia, (_) => false));
      } 
      // Si el nuevo número es menor, se truncan las listas
      else if (nuevoNumero < numeroDePasos) {
        pasosTexto = pasosTexto.sublist(0, nuevoNumero);
        pasosImagen = pasosImagen.sublist(0, nuevoNumero);
        pasosVideo = pasosVideo.sublist(0, nuevoNumero);
        pasosPictograma = pasosPictograma.sublist(0, nuevoNumero);
        pasosAudio = pasosAudio.sublist(0, nuevoNumero);
        textoCompletado = textoCompletado.sublist(0, nuevoNumero);
        imagenCompletada = imagenCompletada.sublist(0, nuevoNumero);
        videoCompletado = videoCompletado.sublist(0, nuevoNumero);
        pictogramaCompletado = pictogramaCompletado.sublist(0, nuevoNumero);
        audioCompletado = audioCompletado.sublist(0, nuevoNumero);
      }
      // Actualiza el número de pasos
      numeroDePasos = nuevoNumero;
    });
  }


  void _mostrarDialogoURL(int index, List<String> lista, String tipo, List<bool> completado) {
    TextEditingController textoController = TextEditingController();
    textoController.text = lista[index];
    showDialog(
      context: context,
      builder: (context) {
        final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;
        return AlertDialog(
          title: Text('Paso ${index + 1} - $tipo', style: TextStyle(fontSize: screenHeight*0.02),),
          content: TextField(
            style: TextStyle(fontSize: screenHeight*0.02),
            controller: textoController,
            maxLines: 4,
            decoration: InputDecoration(hintText: 'Introduce la URL aquí', labelStyle: TextStyle(fontFamily: 'Roboto', fontSize: screenHeight*0.02)),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size(screenWidth * 0.13, screenHeight * 0.05),
                maximumSize: Size(screenWidth * 0.13, screenHeight * 0.05),
                backgroundColor: Colors.blue
              ),
              onPressed: () {
                setState(() {
                  lista[index] = textoController.text;
                  completado[index] = textoController.text.isNotEmpty;
                });
                Navigator.of(context).pop();
              },
              child: Text('Confirmar', style: TextStyle(fontFamily: 'Roboto', fontSize: screenHeight*0.02, color: Colors.white),),
            ),
          ],
        );
      },
    );
  }

void _mostrarDialogoTexto(int index) {
    TextEditingController textoController = TextEditingController();
    textoController.text = pasosTexto[index];
    showDialog(
      context: context,
      builder: (context) {
        final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;
        return AlertDialog(
          title: Text('Paso ${index + 1} - Texto', style: TextStyle(fontFamily: 'Roboto', fontSize: screenHeight*0.02),),
          content: TextField(
            style: TextStyle(fontSize: screenHeight*0.02),
            controller: textoController,
            maxLines: 4,
            decoration: InputDecoration(hintText: 'Introduce el texto aquí', labelStyle: TextStyle(fontFamily: 'Roboto', fontSize: screenHeight*0.02)),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size(screenWidth * 0.13, screenHeight * 0.05),
                maximumSize: Size(screenWidth * 0.13, screenHeight * 0.05),
                backgroundColor: Colors.blue
              ),
              onPressed: () {
                setState(() {
                  pasosTexto[index] = textoController.text;
                  textoCompletado[index] = textoController.text.isNotEmpty;
                });
                Navigator.of(context).pop();
              },
              child: Text('Confirmar', style: TextStyle(fontFamily: 'Roboto', fontSize: screenHeight*0.02, color: Colors.white),),
            ),
          ],
        );
      },
    );
  }

  Widget _cuadroFormato(String titulo, List<bool> completado, final ancho, final alto, List<String> lista, String tipo) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: ancho*0.02, left: ancho * 0.02),
        padding: EdgeInsets.only(top: alto*0.02, bottom: alto*0.02, left: ancho*0.005, right:ancho*0.005),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(alto*0.02),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              titulo,
              style: TextStyle(fontFamily: 'Roboto', color: Colors.white, fontWeight: FontWeight.bold, fontSize: alto*0.025),
            ),
            ...List.generate(numeroDePasos, (index) {
              return Padding(
                padding: EdgeInsets.only(top: alto*0.02),
                child: TextButton(
                  onPressed: () {
                    if (tipo == 'TEXTO') {
                      _mostrarDialogoTexto(index);
                    } else {
                      _mostrarDialogoURL(index, lista, tipo, completado);
                    }
                  },
                  
                  style: TextButton.styleFrom(
                    backgroundColor: completado[index] ? Colors.green[200] : Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: Size(ancho * 0.1, alto * 0.05),
                    maximumSize: Size(ancho * 0.1, alto * 0.05),
                  ),
                  child: Text('Paso ${index + 1}', style: TextStyle(fontFamily: 'Roboto', fontSize: alto*0.02),),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: Column(
        children: [
          AdminTitulo(atras: true, titulo: "Creador de tareas"),

          // Título y descripción
          Padding(
            padding:  EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05, bottom: screenHeight*0.04),
            child: Row(
              children: [
                //titulo y numero de pasos
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: screenWidth*0.1),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: screenHeight*0.03),
                          child: TextField(
                            style: TextStyle(fontFamily: 'Roboto', fontSize: screenHeight*0.02),
                            onChanged: (value) {setState(() {
                              tituloTarea = value;
                            });},
                            decoration: InputDecoration(labelText: 'Título',labelStyle: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: screenHeight*0.025)),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Numero de pasos:',
                              style: TextStyle(
                                fontFamily: 'Roboto', 
                                fontWeight: FontWeight.bold,
                                fontSize: screenHeight * 0.025,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Container(
                              alignment: Alignment.center,
                              width: screenWidth*0.1,
                              height: screenHeight * 0.06,
                              decoration: BoxDecoration(  
                                borderRadius: BorderRadius.circular(screenWidth * 0.01),
                                color: Colors.grey[200], // Color de fondo del contenedor
                              ),
                              child: DropdownButton<int>(
                                value: numeroDePasos,
                                items: List.generate(10, (index) => index + 1)
                                    .map((value) => DropdownMenuItem(
                                          value: value,
                                          child: Text('$value'),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  if (value != null) _actualizarNumeroDePasos(value);
                                },
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: screenHeight * 0.02,
                                  color: Colors.black,
                                ),
                                icon: Icon(Icons.arrow_drop_down, size: screenHeight*0.04,), 
                                borderRadius:  BorderRadius.circular(screenWidth * 0.01), 
                                underline: Container(height: 0,),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //descripcion
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: screenHeight*0.02),
                    onChanged: (value) {
                      setState(() {
                        descripcionTarea = value;
                      });
                    },
                    maxLines: 3,
                    decoration: InputDecoration(labelText: 'Descripción', labelStyle: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: screenHeight*0.025)),
                  ),
                ),
              ],
            ),
          ),
          // Cuadros de formatos
          Expanded(
            child: SingleChildScrollView(
              child: Row( 
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _cuadroFormato('TEXTO', textoCompletado, screenWidth, screenHeight, pasosTexto, 'TEXTO'),
                  _cuadroFormato('IMAGEN', imagenCompletada, screenWidth, screenHeight, pasosImagen, 'IMAGEN'),
                  _cuadroFormato('VIDEO', videoCompletado, screenWidth, screenHeight, pasosVideo, 'VIDEO'),
                  _cuadroFormato('PICTOGRAMA', pictogramaCompletado, screenWidth, screenHeight, pasosPictograma, 'PICTOGRAMA'),
                  _cuadroFormato('AUDIO', audioCompletado, screenWidth, screenHeight, pasosAudio, 'AUDIO'),
                ],
              ),
            ),
          ),
          // Botón de Crear
          Padding(
            padding: EdgeInsets.only(top: screenHeight*0.03, bottom: screenHeight*0.02),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(screenWidth * 0.2, screenHeight * 0.07),
                maximumSize: Size(screenWidth * 0.2, screenHeight * 0.07),
                backgroundColor: Colors.green[900],
              ),
              onPressed: _todosLosPasosCompletados() && tituloTarea!="" && descripcionTarea!="" ? () async{
                tareaplantilla = Tareaplantilla(titulo: tituloTarea, descripcion: descripcionTarea);

                String datos_texto = pasosTexto.join("|");
                pasos = Pasos(urlTexto: datos_texto, urlImagen: pasosImagen, urlVideo: pasosVideo, urlPictograma: pasosPictograma, urlAudio: pasosAudio);
                
                int resultado = await Controladores().crearTareaPlantilla(tareaplantilla, pasos);
                if (resultado == 201) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tarea creada correctamente')));

                    Navigator.of(context).pop(true);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al crear la tarea')));
                }
              } : null,
              child: Text('CREAR', style: TextStyle(fontFamily: 'Roboto', fontSize: screenHeight*0.025, color: Colors.white, fontWeight: FontWeight.bold),),
            ),
          ),
        ],
      ),
        bottomNavigationBar: BarraMenu(selectedIndex: 1, admin: widget.admin),

    );
  }
}

