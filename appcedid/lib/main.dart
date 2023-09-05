import 'package:flutter/material.dart';
import 'package:appcedid/agendar_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agedar',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: AgendarPage(),
      routes: {
        '/calendario': (context) => PagCalendario(),
      },
    );
  }
}
