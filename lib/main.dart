import 'package:flutter/material.dart';
import 'package:ti3/screens/Admin/Adminforo.dart';
import 'package:ti3/screens/home.dart';
import 'package:ti3/screens/agendar.dart';
import 'package:ti3/screens/chatbot.dart';
import 'package:ti3/screens/foro.dart';
import 'package:ti3/screens/showmeetings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ti3/screens/Admin/Adminmenu.dart';
import 'package:ti3/screens/Admin/Adminshowmeetings.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

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
              dates: '',
            ),
        '/ChatBot': (context) => ChatPage(),
        '/Foro': (context) => ForoPage(),
        '/Reuniones': (context) => MeetingsPage(),
        '/AdminMenu': (context) => AdminMenuPage(),
        '/ReunionesAdmin': (context) => AdminMeetingsPage(),
        '/ForoAdmin': (context) => ForoPageAdmin(),
      },
    );
  }
}
