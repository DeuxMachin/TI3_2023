import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ti3/screens/Admin/Adminmenu.dart';
import 'package:ti3/screens/home.dart';

class AdminLoginScreen extends StatefulWidget {
  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _login() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // Mostrar algún mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    try {
      // Busca en Firestore por un administrador que coincida con las credenciales
      final QuerySnapshot result = await _firestore
          .collection('Administrador')
          .where('Usuario', isEqualTo: email)
          .where('Clave', isEqualTo: password)
          .get();

      if (result.docs.isNotEmpty) {
        // Navegar a HomeScreen si las credenciales son correctas
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminMenuPage()),
        );
      } else {
        // Mostrar mensaje de que las credenciales son incorrectas
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('CREDENCIAL INVALIDA, HABLAR CON SOPORTE')),
        );
      }
    } catch (e) {
      // Manejar los errores generales
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('There was an error logging in')),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Empuja la pantalla HomeScreen a la pila de navegación
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              ClipPath(
                clipper: TopCurvedClipper(),
                child: Container(
                  color: Colors.deepPurple,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 60),
                      child: Text(
                        'Inicio de Administrador',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email ID*',
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password*',
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _login,
                        child: Text('Iniciar Session'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white, // Fondo blanco para el botón
                          onPrimary: Colors.purple, // Texto morado
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                18.0), // Bordes redondeados
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipPath(
              clipper: BottomCurvedClipper(),
              child: Container(
                color: Colors.deepPurple,
                height: MediaQuery.of(context).size.height * 0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TopCurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
        size.width / 4, size.height - 30, size.width / 2, size.height - 60);
    path.quadraticBezierTo(
        size.width * 3 / 4, size.height - 90, size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BottomCurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 40);
    path.quadraticBezierTo(size.width / 4, 0, size.width / 2, 40);
    path.quadraticBezierTo(size.width * 3 / 4, 80, size.width, 40);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
