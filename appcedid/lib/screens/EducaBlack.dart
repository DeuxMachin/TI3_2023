import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EducaBlack extends StatelessWidget {
  final List<Map<String, String?>> imageInfo = [
    {"imagePath": "assets/CPC.jpg", "title": "Crea tu propio banner de curso", "url": "https://dte.uct.cl/recursos-graficos/banner-de-curso-blackboard/"},
    {
      "imagePath": "assets/ReCoCu.jpg",
      "title": "Recursos para el contenido de tu curso", "url": "https://dte.uct.cl/recursos-graficos/plantillas-ppt/"
    },
    // Agrega las rutas de tus imágenes y títulos aquí
  ];

  void launchURL(String url) async =>
  await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Introduccion a EducaBlackboard", style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color.fromARGB(255, 235, 250, 151),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: <Widget>[
              Image.asset("assets/Introduccion a Educa Blackboard.png"),
              _crearCurso1(),
              Text('Cursos relacionados a EducaBlackboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              _crearListaDeImagenes(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearCurso1() {
    return Card(
      elevation: 5,
      color: Colors.blue,
      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            Text(
              'El objetivo de este curso.',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Este curso apoya al desarrollo de las competencias para el uso de plataformas académicas LMS y trabajo colaborativo en red para docentes.",
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }

  Widget _crearListaDeImagenes() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: imageInfo.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
      return GestureDetector(
        onTap: () {
          launchURL(imageInfo[index]["url"]?? ""); // Reemplaza "AQUÍ_INSERTA_LA_URL" con la URL correspondiente
        },
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            elevation: 10,
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    imageInfo[index]["imagePath"] ?? "",
                    width: 120,
                    height: 70,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 10),
                  Text(
                    imageInfo[index]["title"] ?? "",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

}