import 'package:flutter/material.dart';
import 'package:ti3/screens/home.dart';
import 'package:ti3/screens/juaker.dart';
import 'package:ti3/screens/nacho.dart';
import 'package:ti3/screens/diego.dart';
import 'package:ti3/screens/perfil.dart';
import 'package:ti3/screens/Cursos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomeScreen(),
      routes: {
        '/Agendar': (context) => AgendarPage(),
        '/calendario': (context) => PagCalendario(),
        '/login': (context) => LoginScreen(),
        '/ChatBot': (context) => ChatPage(),
        'Perfil': (context) => PerfilPage(),
        'Cursos': (context) => Cursospage(),
      },
    );
  }
}
