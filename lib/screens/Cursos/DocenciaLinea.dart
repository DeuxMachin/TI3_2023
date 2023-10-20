import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DocenciaLinea extends StatelessWidget {
  final List<Map<String, String?>> imageInfo = [
    {
      "imagePath": "assets/IconPDF.png",
      "title": "Educación a Distancia",
      "url":
          "https://dte.uct.cl/wp-content/uploads/2020/09/Educacio%C3%ACn-a-distancia-2do-semestre-1.pdf"
    },
    {
      "imagePath": "assets/IconPDF.png",
      "title": "Educación a Distancia Inclusiva",
      "url":
          "https://dte.uct.cl/wp-content/uploads/2020/04/Consejos_para_una_docencia_inclusiva_con_estudiantes_con_brecha_digital.pdf"
    },

    // Agrega las rutas de tus imágenes y títulos aquí
  ];

  void launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Docencia En Linea", style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color.fromARGB(255, 235, 250, 151),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: <Widget>[
              Image.asset("assets/DocenciaOnline.png"),
              _crearCurso1(),
              Text('Cursos relacionados con la docencia en linea',
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
            Text(
              "Instancia de aprendizaje donde las y los docentes podrán desarrollar habilidades digitales, para optimizar los recursos educativos digitales que utilizan habitualmente en sus cursos. Orientado a potenciar la práctica docente en los ambientes virtuales de aprendizaje institucionales. El programa responde al tercer eje del Modelo Educativo institucional vinculado a las TIC en el proceso de la enseñanza y del aprendizaje y los principios orientadores para la Educación Digital en la UCT, orientados a la experiencia del estudiante y al desarrollo de las competencias digitales del docente UCT.",
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
            launchURL(imageInfo[index]["url"] ??
                ""); // Reemplaza "AQUÍ_INSERTA_LA_URL" con la URL correspondiente
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
