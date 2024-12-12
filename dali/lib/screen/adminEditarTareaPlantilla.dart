import 'package:dali/widget/adminTitulo.dart';
import 'package:flutter/material.dart';
import '../widget/barraMenu.dart';

class AdminEditarTareaPlantilla extends StatefulWidget {
  final String titulo;

  AdminEditarTareaPlantilla({required this.titulo});

  @override
  _AdminEditarTareaPlantillaState createState() => _AdminEditarTareaPlantillaState();
}

class _AdminEditarTareaPlantillaState extends State<AdminEditarTareaPlantilla> {
  String tituloTarea = '';
  String descripcionTarea = '';
  int numeroDePasos = 1;
  late TextEditingController tituloController=TextEditingController(text: tituloTarea);
  late TextEditingController descripcionController=TextEditingController(text: tituloTarea);

  // Controladores para los pasos
  List<String> pasosTexto = [];
  List<bool> textoCompletado = [];
  List<bool> imagenCompletada = [];
  List<bool> videoCompletado = [];
  List<bool> pictogramaCompletado = [];
  List<bool> audioCompletado = [];

  @override
  void initState() {
    super.initState();

    tituloTarea = widget.titulo;

    //se carga de la base de datos
    numeroDePasos = 2;
    descripcionTarea = 'Descripcion';
    tituloController = TextEditingController(text: tituloTarea);
    descripcionController = TextEditingController(text: descripcionTarea);
    pasosTexto = List.generate(numeroDePasos, (_) => 'blabla');
    textoCompletado = List.generate(numeroDePasos, (_) => true);
    imagenCompletada = List.generate(numeroDePasos, (_) => true);
    videoCompletado = List.generate(numeroDePasos, (_) => true);
    pictogramaCompletado = List.generate(numeroDePasos, (_) => true);
    audioCompletado = List.generate(numeroDePasos, (_) => true);
  }

  @override
  void dispose() {
    // Libera los controladores al salir de la pantalla
    tituloController.dispose();
    descripcionController.dispose();
    super.dispose();
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
        textoCompletado.addAll(List.generate(diferencia, (_) => false));
        imagenCompletada.addAll(List.generate(diferencia, (_) => false));
        videoCompletado.addAll(List.generate(diferencia, (_) => false));
        pictogramaCompletado.addAll(List.generate(diferencia, (_) => false));
        audioCompletado.addAll(List.generate(diferencia, (_) => false));
      } 
      // Si el nuevo número es menor, se truncan las listas
      else if (nuevoNumero < numeroDePasos) {
        pasosTexto = pasosTexto.sublist(0, nuevoNumero);
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


  void _mostrarDialogoTexto(int index) {
    TextEditingController textoController = TextEditingController();
    textoController.text = pasosTexto[index];
    showDialog(
      context: context,
      builder: (context) {
        final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;
        return AlertDialog(
          title: Text('Paso ${index + 1} - Texto', style: TextStyle(fontSize: screenHeight*0.02),),
          content: TextField(
            style: TextStyle(fontSize: screenHeight*0.02),
            controller: textoController,
            maxLines: 4,
            decoration: InputDecoration(hintText: 'Introduce el texto aquí', labelStyle: TextStyle(fontSize: screenHeight*0.02)),
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
              child: Text('Confirmar', style: TextStyle(fontSize: screenHeight*0.02, color: Colors.white),),
            ),
          ],
        );
      },
    );
  }

  Widget _cuadroFormato(String titulo, List<bool> completado, Function(int) onPressed, final ancho, final alto) {
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
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: alto*0.025),
            ),
            ...List.generate(numeroDePasos, (index) {
              return Padding(
                padding: EdgeInsets.only(top: alto*0.02),
                child: TextButton(
                  onPressed: () => onPressed(index),
                  style: TextButton.styleFrom(
                    backgroundColor: completado[index] ? Colors.green[200] : Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: Size(ancho * 0.1, alto * 0.05),
                    maximumSize: Size(ancho * 0.1, alto * 0.05),
                  ),
                  child: Text('Paso ${index + 1}', style: TextStyle(fontSize: alto*0.02),),
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
          AdminTitulo(atras: true, titulo: "Editar tarea: '${widget.titulo}'"),

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
                            controller: tituloController,
                            style: TextStyle(fontSize: screenHeight*0.02),
                            onChanged: (value) {setState(() {
                              tituloTarea = value;
                            });},
                            decoration: InputDecoration(labelText: 'Título',labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: screenHeight*0.025)),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Numero de pasos:',
                              style: TextStyle(
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
                    controller: descripcionController,
                    style: TextStyle(fontSize: screenHeight*0.02),
                    onChanged: (value) {
                      setState(() {
                        descripcionTarea = value;
                      });
                    },
                    maxLines: 3,
                    decoration: InputDecoration(labelText: 'Descripción', labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: screenHeight*0.025)),
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
                  _cuadroFormato('TEXTO', textoCompletado, _mostrarDialogoTexto, screenWidth, screenHeight),
                  _cuadroFormato('IMAGEN', imagenCompletada, (index) {
                    setState(() => imagenCompletada[index] = true);
                  }, screenWidth, screenHeight),
                  _cuadroFormato('VIDEO', videoCompletado, (index) {
                    setState(() => videoCompletado[index] = true);
                  }, screenWidth, screenHeight),
                  _cuadroFormato('PICTOGRAMA', pictogramaCompletado, (index) {
                    setState(() => pictogramaCompletado[index] = true);
                  }, screenWidth, screenHeight),
                  _cuadroFormato('AUDIO', audioCompletado, (index) {
                    setState(() => audioCompletado[index] = true);
                  }, screenWidth, screenHeight),
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
              onPressed: _todosLosPasosCompletados() && tituloTarea!="" && descripcionTarea!="" ? () {} : null,
              child: Text('EDITAR TAREA', style: TextStyle(fontSize: screenHeight*0.025, color: Colors.white, fontWeight: FontWeight.bold),),
            ),
          ),
        ],
      ),
        bottomNavigationBar: BarraMenu(selectedIndex: 1),

    );
  }
}
