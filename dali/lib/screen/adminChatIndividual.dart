import 'package:flutter/material.dart';
import '../widget/adminTitulo.dart';
import '../widget/barraMenu.dart';

class AdminChatIndividual extends StatelessWidget {
  final Map<String, dynamic> chat;

  AdminChatIndividual({required this.chat});

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
          AdminTitulo(atras: true, titulo: "Chat: ${chat['tarea']}"),
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
                        style: TextStyle(color: Colors.white, fontSize: screenHeight*0.02),
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
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    height: screenHeight*0.08,
                    child: TextField(
                      style: TextStyle(fontSize: screenHeight*0.02),
                      decoration: InputDecoration(
                        hintText: "Escribe aquí...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(screenWidth*0.02),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth*0.01),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.teal, size: screenWidth*0.02,),
                  onPressed: () {
                    // Lógica para enviar mensaje
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BarraMenu(selectedIndex: 4),
    );
  }
}
