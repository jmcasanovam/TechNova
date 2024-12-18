import 'package:flutter/material.dart';
import '../widget/adminTitulo.dart';
import '../widget/barraMenu.dart';

class ChatAlumno extends StatelessWidget {
  // final Map<String, dynamic> chat;

  // ChatAlumno({required this.chat});

  final List<Map<String, dynamic>> mensajes = [
    {'texto': 'Hola, ¿cómo estás?', 'esMio': true},
    {'texto': 'Blaalsdlalsdlalsdlasdlalsdlasldlasldalsdlasldlasdmaskldaksndjas xja sxj asjd ajs dajs dja sdja sdj asd asjd ajsd ajs dajs djas djas djad jaBlaalsdlalsdlalsdlasdlalsdlasldlasldalsdlasldlasdmaskldaksndjas xja sxj asjd ajs dajs dja sdja sdj asd asjd ajsd ajs dajs djas djas djad jaaskdaksdkaksdkaksdka', 'esMio': true},
    {'texto': 'Todo bien, gracias. ¿Y tú?', 'esMio': false},
    {'texto': 'Todo bien, gracias. ¿Y tú?', 'esMio': false},
    {'texto': 'Hola, ¿cómo estás?', 'esMio': true},
    {'texto': 'Blaalsdlalsdlalsdlasdlalsdlasldlasldalsdlasldlasdmaskldaksndjas xja sxj asjd ajs dajs dja sdja sdj asd asjd ajsd ajs dajs djas djas djad jaBlaalsdlalsdlalsdlasdlalsdlasldlasldalsdlasldlasdmaskldaksndjas xja sxj asjd ajs dajs dja sdja sdj asd asjd ajsd ajs dajs djas djas djad jaaskdaksdkaksdkaksdka', 'esMio': true},
    {'texto': 'Todo bien, gracias. ¿Y tú?', 'esMio': false},
    {'texto': 'Todo bien, gracias. ¿Y tú?', 'esMio': false},
    {'texto': 'Hola, ¿cómo estás?', 'esMio': true},{'texto': 'Blaalsdlalsdlalsdlasdlalsdlasldlasldalsdlasldlasdmaskldaksndjas xja sxj asjd ajs dajs dja sdja sdj asd asjd ajsd ajs dajs djas djas djad jaBlaalsdlalsdlalsdlasdlalsdlasldlasldalsdlasldlasdmaskldaksndjas xja sxj asjd ajs dajs dja sdja sdj asd asjd ajsd ajs dajs djas djas djad jaaskdaksdkaksdkaksdka', 'esMio': true},
    {'texto': 'Todo bien, gracias. ¿Y tú?', 'esMio': false},
    {'texto': 'Todo bien, gracias. ¿Y tú?', 'esMio': false},
    {'texto': 'Hola, ¿cómo estás?', 'esMio': true},
    // Más mensajes...
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          AdminTitulo(atras: true, titulo: "Chat"),
          Expanded(
            child: Container(
              color: Colors.grey[200],
              padding: EdgeInsets.only(top:screenHeight*0.01),
              child: ListView.builder(
                itemCount: mensajes.length,
                itemBuilder: (context, index) {
                  final mensaje = mensajes[index];
                  return Container(
                    alignment: mensaje['esMio'] ? Alignment.centerRight : Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(vertical: screenHeight*0.002, horizontal: screenWidth*0.05),
                    child: Container(
                      width: screenWidth*0.3,
                      padding: EdgeInsets.only(right: screenWidth*0.005, left: screenWidth*0.005, top: screenHeight*0.01, bottom: screenHeight*0.01),
                      decoration: BoxDecoration(
                        color: mensaje['esMio'] ? Colors.teal : Colors.red,
                        borderRadius: BorderRadius.circular(screenWidth*0.01),
                      ),
                      child: Text(
                        mensaje['texto'],
                        style: TextStyle(fontFamily: 'Roboto', color: Colors.white, fontSize: screenHeight*0.02),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight*0.05, bottom: screenHeight*0.01, left: screenWidth*0.1, right: screenWidth*0.1),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      border: Border.all(width: screenWidth*0.002),
                      color: Colors.transparent,
                    ),
                    padding: EdgeInsets.only(top: screenHeight*0.02, bottom:  screenHeight*0.02, left: screenWidth*0.02, right: screenWidth*0.02),
                    alignment: Alignment.center,
                    height: screenHeight*0.2,
                    child: Semantics(label: "Campo de escritura de mensajes", child:TextField(
                      maxLines: 4,
                      style: TextStyle(fontFamily: 'Roboto', fontSize: screenHeight*0.03),
                      decoration: const InputDecoration(
                        hintText: "Escribe aquí...",
                        border: InputBorder.none,
                        //  OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(screenWidth*0.02),
                        // ),
                      ),
                    )),
                  ),
                ),
                SizedBox(width: screenWidth*0.01),
                Semantics(label:"Botón para enviar el mensaje", child:IconButton(
                  icon: Icon(Icons.send, color: Colors.teal, size: screenWidth*0.05,),
                  onPressed: () {
                    // Lógica para enviar mensaje
                  },
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
