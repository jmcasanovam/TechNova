import 'package:flutter/material.dart';

class BotonExaminar extends StatefulWidget {
  final String tipo;
  final Color? color;
  final Color? letra;
  final Function(String) url; 

  const BotonExaminar({
    super.key,
    required this.tipo,
    required this.color,
    required this.letra,
    required this.url, 
  });

  @override
  _BotonExaminarState createState() => _BotonExaminarState();
}

class _BotonExaminarState extends State<BotonExaminar> {
  String _currentUrl = ""; // Estado interno para la URL

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(screenWidth * 0.2, screenHeight * 0.07),
        backgroundColor: widget.color, // Color del botón
      ),
      onPressed: () {
        TextEditingController textoController = TextEditingController(text: _currentUrl);

        showDialog(
          context: context,
          builder: (context) {
            final screenHeight = MediaQuery.of(context).size.height;
            final screenWidth = MediaQuery.of(context).size.width;

            return AlertDialog(
              title: Text(
                'URL del ${widget.tipo}',
                style: TextStyle(fontFamily: 'Roboto', fontSize: screenHeight * 0.02, fontWeight: FontWeight.bold),
              ),
              content: TextField(
                style: TextStyle(fontSize: screenHeight * 0.02),
                controller: textoController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Introduce la URL aquí',
                  labelStyle: TextStyle(fontFamily: 'Roboto', fontSize: screenHeight * 0.02),
                ),
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size(screenWidth * 0.13, screenHeight * 0.05),
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    setState(() {
                      _currentUrl = textoController.text; // Actualizamos la URL interna
                    });

                    widget.url(_currentUrl); // Devolvemos la URL al callback
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Confirmar',
                    style: TextStyle(fontFamily: 'Roboto', fontSize: screenHeight * 0.02, color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Text(
        'Examinar ${widget.tipo}',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: screenHeight * 0.02,
          color: widget.letra
        ),
      ),
    );
  }
}
