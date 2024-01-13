import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EducaBlack extends StatelessWidget {
  final List<Map<String, String?>> imageInfo = [
    {
      "imagePath": "assets/CPC.jpg",
      "title": "Crea tu propio banner de curso",
      "url": "https://dte.uct.cl/recursos-graficos/banner-de-curso-blackboard/"
    },
    {
      "imagePath": "assets/ReCoCu.jpg",
      "title": "Recursos para el contenido de tu curso",
      "url": "https://dte.uct.cl/recursos-graficos/plantillas-ppt/"
    },
    // Agrega las rutas de tus imágenes y títulos aquí
  ];

  void launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Introducción a EducaBlackboard",
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: <Widget>[
            Image.asset("assets/educa.png", fit: BoxFit.cover),
            SizedBox(height: 20),
            _crearCurso1(),
            SizedBox(height: 20),
            Text('Cursos relacionados a EducaBlackboard',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _crearListaDeImagenes(),
          ],
        ),
      ),
    );
  }

  Widget _crearCurso1() {
    return Card(
      elevation: 5,
      color: Colors.blue[100],
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Objetivo del Curso',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            SizedBox(height: 10),
            Text(
                "Este curso apoya al desarrollo de las competencias para el uso de plataformas académicas LMS y trabajo colaborativo en red para docentes.",
                style: TextStyle(fontSize: 16, height: 1.5)),
          ],
        ),
      ),
    );
  }

  Widget _crearListaDeImagenes() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: imageInfo.length,
      shrinkWrap: true,
      physics:
          NeverScrollableScrollPhysics(), // Para evitar el scrolling dentro del GridView
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => launchURL(imageInfo[index]["url"] ?? ""),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    imageInfo[index]["imagePath"] ?? "",
                    width: 100,
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 8),
                  Text(
                    imageInfo[index]["title"] ?? "",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
