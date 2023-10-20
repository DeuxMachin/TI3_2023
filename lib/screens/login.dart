import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ti3/screens/HomeSi.dart';
import 'package:ti3/utils/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Variable global para almacenar el email del usuario
String? userEmail;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: myColor,
        image: DecorationImage(
          image: const AssetImage("assets/campus.jpg"),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(myColor.withOpacity(0.2), BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Positioned(top: 80, child: _buildTop()),
          Positioned(bottom: 0, child: _buildBottom()),
        ]),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/Logo_UCT.png",
            height: 100.0, // puedes ajustar esto según lo necesites
            width: 100.0, // puedes ajustar esto según lo necesites
          ),
          Text(
            "CINAP",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 35,
                letterSpacing: 2),
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Bienvenido",
          style: TextStyle(
              color: myColor, fontSize: 32, fontWeight: FontWeight.w500),
        ),
        _buildGreyText("Por favor utilizar informacion institucional"),
        const SizedBox(height: 60),
        _buildGreyText("Correo Electronico"),
        _buildInputField(emailController),
        const SizedBox(height: 40),
        _buildGreyText("Contraseña"),
        _buildInputField(passwordController, isPassword: true),
        const SizedBox(height: 20),
        _buildRememberForgot(),
        const SizedBox(height: 20),
        _buildLoginButton(),
        const SizedBox(height: 20),
        _buildOtherLogin(),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword ? Icon(Icons.remove_red_eye) : Icon(Icons.done),
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
                value: rememberUser,
                onChanged: (value) {
                  setState(() {
                    rememberUser = value!;
                  });
                }),
            _buildGreyText("Recuerdame"),
          ],
        ),
      ],
    );
  }

  Widget customElevatedButton(
      {required Function() onPressed,
      required String buttonText,
      Widget? leadingWidget}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        minimumSize: const Size.fromHeight(60),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leadingWidget != null) leadingWidget,
          if (leadingWidget != null) SizedBox(width: 10),
          Text(buttonText),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return customElevatedButton(
      onPressed: () async {
        String email = emailController.text;
        String password = passwordController.text;

        QuerySnapshot users = await FirebaseFirestore.instance
            .collection('Usuarios')
            .where('email', isEqualTo: email)
            .where('Clave', isEqualTo: password)
            .get();

        if (users.docs.isNotEmpty) {
          userEmail = email; // Guardar el email del usuario
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else {}
      },
      buttonText: "LOGIN",
    );
  }

  Widget _buildOtherLogin() {
    return customElevatedButton(
      onPressed: () async {
        User? user = await Authentication.signInWithGoogle(context: context);
        if (user != null) {
          userEmail = user.email; // Guardar el email del usuario de Google
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        }
      },
      buttonText: "Iniciar con Google",
      leadingWidget: Image.asset(
        "assets/google.png",
        height: 24.0,
      ),
    );
  }
}
