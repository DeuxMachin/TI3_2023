import 'package:flutter/material.dart';
import 'forum2.dart';
import 'forum1.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foro',
      theme: ThemeData(
        primarySwatch: Colors.amber,      
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: forum1(),
    );
  }
}






