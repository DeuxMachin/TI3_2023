import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importar Firestore
import 'package:ti3/main.dart';
import 'package:ti3/screens/HomeSi.dart';
import 'package:ti3/utils/authentication.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with RouteAware {
  bool rememberMe = false;

  // Controladores para los campos de texto
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Limpiar los controladores cuando la pantalla se descarte
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    // User swiped back to this page, so we log them out
    setState(() {
      Authentication.logout();
    });
  }

  // Función para iniciar sesión
  Future<void> login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final usersRef = FirebaseFirestore.instance.collection('Usuarios');
    final userSnapshot = await usersRef
        .where('email', isEqualTo: email)
        .where('Clave', isEqualTo: password)
        .get();

    if (userSnapshot.docs.isNotEmpty) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Hablar con soporte')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //Remove back arrow
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color.fromARGB(255, 235, 250, 151),
        title: Text('Ingresar a Cuenta', style: TextStyle(color: Colors.black)),
      ),
      body: Material(
        color: Color.fromARGB(255, 174, 243, 242),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/Icon_login_fondo.jpg"),
              SingleChildScrollView(
                child: Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color:
                          Color.fromARGB(255, 174, 243, 242).withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: _emailController, // Añadido controlador
                        decoration: InputDecoration(
                          hintText: "Correo Electronico",
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        cursorColor: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 174, 243, 242).withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: TextFormField(
                    controller: _passwordController, // Añadido controlador
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Contraseña",
                      prefixIcon: Icon(Icons.lock,
                          color: Colors.black.withOpacity(0.5)),
                      suffixIcon: Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: login, // Vinculado la función de inicio de sesión
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 235, 250, 151),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Iniciar Sesión",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        wordSpacing: 2,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // (Resto del código no se modifica)
              InkWell(
                onTap: () async {
                  User? user =
                      await Authentication.signInWithGoogle(context: context);
                  if (user != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 235, 250, 151),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/google.png",
                          height: 24.0,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Iniciar con Google",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            wordSpacing: 2,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
