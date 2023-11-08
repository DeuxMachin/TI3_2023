import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HyFlex extends StatelessWidget {
// Creamos una lista para almacenar las imagenes , titulo , url para cada card
  final List<Map<String, String?>> imageInfo = [
    {
      "imagePath": "assets/IconPDF.png",
      "title": "Protocolo Docentes",
      "url":
          "https://dte.uct.cl/wp-content/uploads/2021/11/PROTOCOLO-DOCENTES.pdf"
    },
    {"imagePath": "assets/IconPDF.png", "title": "Guia de aprendizaje"},
    {
      "imagePath": "assets/IconPDF.png",
      "title": "Estrategias para el docente",
      "url":
          "https://dte.uct.cl/wp-content/uploads/2021/10/ESTRATEGIAS-INTERACCIO%CC%81N-DOCENTE-ESTUDIANTE.pdf"
    },
    {
      "imagePath": "assets/IconPDF.png",
      "title": "Uso de herramientas digitales",
      "url":
          "https://dte.uct.cl/wp-content/uploads/2021/10/ESTRATEGIAS-USO-DE-HERRAMIENTAS-DIGITALES.pdf"
    },
    {
      "imagePath": "assets/IconPDF.png",
      "title": "Herramientas HyFlex"
    }, // no se ecuntra la pag en el dte
    {
      "imagePath": "assets/IconPDF.png",
      "title": "Manual para el uso de salas Hibridas",
      "url":
          "https://dte.uct.cl/wp-content/uploads/2023/01/Manual-Salas-Hibridas.pdf"
    },
  ];

  // Creamos una lista para almacenar las imagenes , titulo , url para cada card

  final List<Map<String, String?>> imageInfo2 = [
    {
      "imagePath": "assets/IconPDF.png",
      "title": "Protocolo Estudiantes",
      "url":
          "https://dte.uct.cl/wp-content/uploads/2021/10/PROTOCOLO-ESTUDIANTES.pdf"
    },
    {
      "imagePath": "assets/IconPDF.png",
      "title": "Antes de la clase",
      "url":
          "https://dte.uct.cl/wp-content/uploads/2021/10/ANTES-DE-LA-CLASE-RECOMENDACIONES-ESTUDIANTES.pdf"
    },
    {
      "imagePath": "assets/IconPDF.png",
      "title": "Durante la clase",
      "url":
          "https://dte.uct.cl/wp-content/uploads/2021/10/DURANTE-LA-CLASE-RECOMENDACIONES-ESTUDIANTES.pdf"
    },
    {
      "imagePath": "assets/IconPDF.png",
      "title": "Despues de la clase",
      "url":
          "https://dte.uct.cl/wp-content/uploads/2021/10/DESPUE%CC%81S-DE-LA-CLASE-RECOMENDACIONES-ESTUDIANTES.pdf"
    },
  ];

  //Creamos un lanzamiento para las conexiones a las url

  void launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hyflex", style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color.fromARGB(255, 235, 250, 151),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset("assets/Hyflex.png"),
            Image.asset("assets/principios.png"),
            _crearCurso1(),
            Text(
              'Cursos disponibles para el docente',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            _crearListaDeImagenes(),
            Text(
              'Cursos disponibles para el Estudiante',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            _crearListaDeImagenes2(),
          ],
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
              "HyFlex es una modalidad de enseñanza y aprendizaje que se enmarca dentro de lo que se conoce como modelo Mixto, Híbrido o B-learning. Es Híbrido, porque integra las modalidades: presencial, online y flexible, porque los estudiantes tienen la posibilidad de participar en forma presencial o a distancia.",
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
      physics: NeverScrollableScrollPhysics(), // Deshabilita el desplazamiento
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            launchURL(imageInfo[index]["url"] ?? "");
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
                      height: 80,
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

  Widget _crearListaDeImagenes2() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: imageInfo2.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), // Deshabilita el desplazamiento
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            launchURL(imageInfo2[index]["url"] ?? "");
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
                      imageInfo2[index]["imagePath"] ?? "",
                      width: 120,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 10),
                    Text(
                      imageInfo2[index]["title"] ?? "",
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
