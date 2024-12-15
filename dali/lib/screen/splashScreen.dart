import 'package:dali/screen/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Simulamos una carga de 2 segundos antes de ir a la pantalla principal
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: 
          (context) => LoginScreen()
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold( 
      backgroundColor: const Color(0xFFFFFFF).withOpacity(1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: screenHeight*0.1 ),
            Image.asset("images/logo_dali_rojo_con_nombre.png", width: screenWidth*0.3, height: screenHeight*0.5,), // El logo de la app
            SizedBox(height: screenHeight*0.04),
            Text('Create by', style: TextStyle(fontSize: screenHeight*0.04, color: Colors.black, fontFamily: 'Roboto')),
            Text(' TechNova.', style: TextStyle(fontSize: screenHeight*0.05, color: Colors.black, fontFamily: 'Roboto')),

          ],
        ),
      ),
    );
  }
}