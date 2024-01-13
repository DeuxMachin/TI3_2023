import 'package:flutter/material.dart';
import 'package:ti3/utils/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ti3/screens/HomeSi.dart';
import 'package:ti3/screens/AdminLog.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? loggedInUser;
    loggedInUser = FirebaseAuth.instance.currentUser;
    if (loggedInUser != null) Authentication.logout();
    final double upperContainerHeight =
        MediaQuery.of(context).size.height * 0.5; // Mitad de la altura
    final Color myColor = Theme.of(context)
        .primaryColor; // Usa el color primario del tema para el estilo del texto

    return Scaffold(
      backgroundColor:
          Colors.white, // Fondo blanco para el resto de la pantalla
      body: Column(
        children: <Widget>[
          ClipPath(
            clipper: BottomWaveClipper(),
            child: Container(
              color: Colors.deepPurple,
              height: upperContainerHeight,
              child: Center(
                child: Image.asset("assets/Logo_UCT.png",
                    scale: 1.6), // Reemplazar con tu logo personalizado
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              // Asegura que el contenido se pueda desplazar si es necesario
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20), // Espacio adicional antes del texto
                    _buildForm(myColor), // Añadido el método _buildForm aquí
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceEvenly, // Espacio uniforme entre los botones
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: 8.0), // Espacio entre botones
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    Colors.white, // Fondo blanco para el botón
                                onPrimary: Colors.purple, // Texto morado
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      18.0), // Bordes redondeados
                                ),
                              ),
                              child: Text('Correo Institucional'),
                              onPressed: () async {
                                try {
                                  User? user =
                                      await Authentication.signInWithGoogle(
                                          context: context);
                                  if (user != null &&
                                      user.email != null &&
                                      user.email!.endsWith('@alu.uct.cl')) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()));
                                  } else {
                                    await Authentication
                                        .logout(); // Asegurarse de que el usuario esté deslogueado
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Facilitando la comunicacion y el acceso a servicios institucionales en la Universisad Catolica de Temuco.'),
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Ocurrió un error durante el inicio de sesión.'),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 8.0), // Espacio entre botones
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    Colors.white, // Fondo blanco para el botón
                                onPrimary: Colors.purple, // Texto morado
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      18.0), // Bordes redondeados
                                ),
                              ),
                              child: Text('Inicio Administrador'),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AdminLoginScreen())); // Implementación del inicio de sesión de administrador
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(Color myColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Bienvenido",
          style: TextStyle(
              color: myColor, fontSize: 32, fontWeight: FontWeight.w500),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 40.0),
          child: Text(
            "Por favor utilizar un correo institucional de la universidad. Esto se realiza para poder brindar mas seguridad a sus usuarios.",
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(
        0, size.height * 0.75); // Comienza la curva en la mitad del contenedor

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height * 0.85);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 4), size.height * 0.7);
    var secondEndPoint = Offset(size.width, size.height * 0.8);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
