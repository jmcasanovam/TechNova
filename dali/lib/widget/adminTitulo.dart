import 'package:dali/widget/botonCerrarSesion.dart';
import 'package:flutter/material.dart';

class AdminTitulo extends StatelessWidget {
  final bool atras;
  final String titulo;
  
  AdminTitulo({required this.atras, required this.titulo});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;


    return Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.02, top: screenHeight * 0.02,),
            child: 
            SizedBox(
              height: screenHeight * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if(!atras)SizedBox(
                    width: screenWidth * 0.1,
                  ),
                  if(atras) IconButton(
                    icon: Image.asset('images/back-arrow.png', width: screenWidth * 0.08,),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          titulo,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontSize: screenHeight * 0.08,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  BotonCerrarSesion(),
                  SizedBox(
                    width: screenWidth * 0.08,
                  ),
                ],
              )
            ),
          );
  }

}
