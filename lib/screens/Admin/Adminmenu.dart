import 'package:flutter/material.dart';
import 'package:ti3/screens/Admin/Adminforo.dart';
import 'package:ti3/screens/Admin/Adminshowmeetings.dart';
import 'package:ti3/screens/Admin/Adminshowasesores.dart';
import 'package:ti3/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminMenuPage extends StatefulWidget {
  @override
  _AdminMenuPageState createState() => _AdminMenuPageState();
}

class _AdminMenuPageState extends State<AdminMenuPage> {
  final List<String> _options = [
    'Editar y eliminar reuniones',
    'Borrar posts y comentarios del foro',
    'Editar datos de asesores'
  ];

  void _handleOptionTap(String optionTitle) {
    switch (optionTitle) {
      case 'Editar y eliminar reuniones':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminMeetingsPage()),
        );
        break;
      case 'Borrar posts y comentarios del foro':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ForoPageAdmin()),
        );
        break;
      case 'Editar datos de asesores':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminAsesoresPage()),
        );
        break;
      default:
        print('Unknown option: $optionTitle');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Opciones de administrador',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              onPressed: () => _logout(context),
              icon: Icon(Icons.logout, size: 30, color: Colors.white))
        ],
      ),
      body: ListView.builder(
        itemCount: _options.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_options[index]),
            onTap: () => _handleOptionTap(_options[index]),
          );
        },
      ),
    );
  }

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeScreen())); // Replace with your login screen
  }
}
