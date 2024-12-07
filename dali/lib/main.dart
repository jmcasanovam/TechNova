import 'package:dali/screen/adminAsignarTareas.dart';
import 'package:dali/screen/adminCreadorTareas.dart';
import 'package:dali/screen/adminTareasPlantilla.dart';
import 'package:dali/screen/adminUsuarios.dart';
import 'package:dali/screen/adminMenus.dart';
import 'package:dali/screen/splashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dalí',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF44034)),
        useMaterial3: true,
      ),
      // home: const SplashScreen(),
      // home: AdminCreadorTareas(),
      home: AdminTareasPlantilla(),
      routes: {
        '/adminUsuarios': (context) => AdminUsuarios(),
        '/adminCreadorTareas': (context) => AdminTareasPlantilla(),
        '/adminAsignarTarea': (context) => AdminAsignarTareas(),
        '/adminMenus' : (context) => AdminMenus(),

      },
      debugShowCheckedModeBanner: false,
    );
  }
}
