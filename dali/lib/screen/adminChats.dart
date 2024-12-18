import 'package:flutter/material.dart';
import '../widget/adminTitulo.dart';
import '../widget/barraMenu.dart';
import 'adminChatIndividual.dart';

class AdminChats extends StatefulWidget {
  @override
  _AdminChatsState createState() => _AdminChatsState();
}

class _AdminChatsState extends State<AdminChats> {
  final List<Map<String, dynamic>> chats = [
    {
      'nombre': 'Juan Pérez',
      'nickname': '@juanp',
      'tarea': 'Poner la lavadora',
      'fotoPerfil': 'images/serpiente.png', // Aquí añadirías una URL o recurso local
      'mensajesSinLeer': 3,
    },
    {
      'nombre': 'María López',
      'nickname': '@marial',
      'tarea': 'Limpiar la mesa',
      'fotoPerfil': 'images/gorila.png',
      'mensajesSinLeer': 0,
    },
    // Más chats...
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          AdminTitulo(atras: false, titulo: "Chats"),
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminChatIndividual(chat: chat),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: screenHeight*0.01, horizontal: screenWidth*0.05),
                    padding: EdgeInsets.only(left: screenWidth*0.05, right: screenWidth*0.05, top: screenHeight*0.02, bottom: screenHeight*0.02),
                    decoration: BoxDecoration(
                      color: chat['mensajesSinLeer']>0?Colors.grey[400]:Colors.grey[200],
                      borderRadius: BorderRadius.circular(screenWidth*0.02),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(chat['fotoPerfil']),
                          radius: screenHeight*0.05,
                        ),
                        SizedBox(width: screenWidth*0.01),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    chat['nombre'],
                                    style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: screenHeight*0.025),
                                  ),
                                  SizedBox(width: screenWidth*0.005),
                                  Text(
                                    chat['nickname'],
                                    style: TextStyle(fontFamily: 'Roboto', color: Colors.grey, fontSize: screenHeight*0.02),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight*0.006),
                              Text(
                                chat['tarea'],
                                style: TextStyle(fontFamily: 'Roboto', color: Colors.grey[700], fontSize: screenHeight*0.02),
                              ),
                            ],
                          ),
                        ),
                        if (chat['mensajesSinLeer'] > 0)
                          Container(
                            // width: screenWidth*0.05,
                            // height: screenHeight*0.04,
                            padding: EdgeInsets.only(top: screenHeight*0.01, bottom: screenHeight*0.01, right: screenWidth*0.05, left: screenWidth*0.05),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              chat['mensajesSinLeer'].toString(),
                              style: TextStyle(fontFamily: 'Roboto', color: Colors.white, fontSize: screenHeight*0.02),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BarraMenu(selectedIndex: 4),
    );
  }
}
