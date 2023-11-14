import 'package:flutter/material.dart';
import 'package:ti3/screens/home.dart';
import 'package:ti3/screens/agendar.dart';
import 'package:ti3/screens/login.dart';
import 'package:ti3/screens/chatbot.dart';
import 'package:ti3/screens/perfil.dart';
import 'package:ti3/screens/foro.dart';
import 'package:ti3/screens/cursos.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [routeObserver],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomeScreen(),
      routes: {
        '/Agendar': (context) => AgendarPage(),
        '/calendario': (context) => PagCalendario(
              nombre: '',
              apellidos: '',
              correo: '',
            ),
        '/login': (context) => LoginScreen(),
        '/ChatBot': (context) => ChatPage(),
        '/Perfil': (context) => PerfilPage(),
        '/Foro': (context) => ForoPage(),
        '/Cursos': (context) => Cursospage(),
      },
    );
  }
}
