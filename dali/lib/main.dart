import 'package:dali/screen/adminAsignarTareas.dart';
import 'package:dali/screen/adminChats.dart';
import 'package:dali/screen/adminCreadorTareas.dart';
import 'package:dali/screen/adminPerfil.dart';
import 'package:dali/screen/adminTareasPlantilla.dart';
import 'package:dali/screen/adminUsuarios.dart';
import 'package:dali/screen/adminMenus.dart';
import 'package:dali/screen/chatAlumno.dart';
import 'package:dali/screen/loginAlumnos.dart';
import 'package:dali/screen/loginProfesor.dart';
import 'package:dali/screen/loginScreen.dart';
import 'package:dali/screen/profeAlumnos.dart';
import 'package:dali/screen/profeMateriales.dart';
import 'package:dali/screen/profePerfil.dart';
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
      // home: AdminMenus(),
        home: const SplashScreen(),
        // home: LoginAlumnos(),
        // home: LoginScreen(),


    // home: AdminCreadorTareas(),
      // home: AdminPerfil(),
      // home: LoginProfesor(),
      // home: AdminUsuarios(),
      // home: AdminMenus(),
      // home: ProfeUsuarios(),
      // home: ChatAlumno(),

      routes: {
        '/adminUsuarios': (context) => AdminUsuarios(),
        '/adminCreadorTareas': (context) => AdminTareasPlantilla(),
        '/adminAsignarTarea': (context) => AdminAsignarTareas(),
        '/adminMenus' : (context) => AdminMenus(),
        '/adminPerfil' : (context) => AdminPerfil(),
        '/profeUsuarios': (context) => ProfeUsuarios(),
        '/profeMateriales': (context) => ProfeMateriales(),
        '/profePerfil': (context) => ProfePerfil(),
        '/adminChats':  (context) => AdminChats(),


      },
      debugShowCheckedModeBanner: false,
    );
  }
}
