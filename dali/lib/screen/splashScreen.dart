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
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   Future.delayed(Duration(seconds: 2), () {
    //     Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(builder: 
    //       (context) => SignInScreen()
    //       ),
    //     );
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: const Color(0xFF2c4770).withOpacity(1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Dalí", style: TextStyle(fontSize: 64, color: Colors.white, fontFamily: 'Aclonica')),
            const SizedBox(height: 20),
            Image.asset("images/logo_sin_fondo.png"), // El logo de la app
            // Icon(Icons.camera_alt, size: 100),
            const SizedBox(height: 40),
            const Text('Create by', style: TextStyle(fontSize: 24, color: Colors.white, fontFamily: 'Aclonica')),
            const Text(' TechNova.', style: TextStyle(fontSize: 32, color: Colors.white, fontFamily: 'Aclonica')),

          ],
        ),
      ),
    );
  }
}