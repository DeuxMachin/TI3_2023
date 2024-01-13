import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DocenciaLinea extends StatelessWidget {
  final List<Map<String, String?>> imageInfo = [
    {
      "imagePath": "assets/IconPDF.png",
      "title": "Educación a Distancia",
      "url":
          "https://dte.uct.cl/wp-content/uploads/2020/09/Educacioìn-a-distancia-2do-semestre-1.pdf"
    },
    {
      "imagePath": "assets/IconPDF.png",
      "title": "Educación a Distancia Inclusiva",
      "url":
          "https://dte.uct.cl/wp-content/uploads/2020/04/Consejos_para_una_docencia_inclusiva_con_estudiantes_con_brecha_digital.pdf"
    },

    // Agrega las rutas de tus imágenes y títulos aquí
  ];

  void launchURL(String? url) async {
    if (url == null || url.isEmpty) {
      print('URL is null or empty');
      return;
    }

    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Docencia En Línea",
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: <Widget>[
            Image.asset("assets/DocenciaOnline.png", fit: BoxFit.cover),
            SizedBox(height: 20),
            _crearCurso1(),
            SizedBox(height: 20),
            Text('Cursos de Docencia Online',
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
                "Instancia de aprendizaje donde las y los docentes podrán desarrollar habilidades digitales, para optimizar los recursos educativos digitales que utilizan habitualmente en sus cursos. Orientado a potenciar la práctica docente en los ambientes virtuales de aprendizaje institucionales. El programa responde al tercer eje del Modelo Educativo institucional vinculado a las TIC en el proceso de la enseñanza y del aprendizaje y los principios orientadores para la Educación Digital en la UCT, orientados a la experiencia del estudiante y al desarrollo de las competencias digitales del docente UCT.",
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
