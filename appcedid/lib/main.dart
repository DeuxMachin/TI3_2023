import 'package:flutter/material.dart';
import 'package:ti3/screens/home.dart';
import 'package:ti3/screens/juaker.dart';
import 'package:ti3/screens/nacho.dart';
import 'package:ti3/screens/diego.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
      home: ChatPage(),
      routes: {
        '/Agendar': (context) => AgendarPage(),
        '/calendario': (context) => PagCalendario(),
        '/login': (context) => LoginScreen(),
        '/foro': (context) => ChatPage(),
      },
    );
  }
}
