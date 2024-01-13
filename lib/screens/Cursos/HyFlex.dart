import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HyFlex extends StatelessWidget {
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
          "https://dte.uct.cl/wp-content/uploads/2021/10/ESTRATEGIAS-INTERACCIÓN-DOCENTE-ESTUDIANTE.pdf"
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
          "https://dte.uct.cl/wp-content/uploads/2021/10/DESPUÉS-DE-LA-CLASE-RECOMENDACIONES-ESTUDIANTES.pdf"
    },
  ];

  void launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("HyFlex", style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: <Widget>[
            Image.asset("assets/Hyflex.png", fit: BoxFit.cover),
            Image.asset("assets/principios_orientadores.png",
                fit: BoxFit.cover),
            SizedBox(height: 20),
            _crearCurso1(),
            SizedBox(height: 20),
            Text('Cursos disponibles para el docente',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _crearListaDeImagenes(),
            SizedBox(height: 20),
            Text('Cursos disponibles para el estudiante',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _crearListaDeImagenes2(),
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
            Text('El objetivo de este curso',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            SizedBox(height: 10),
            Text(
                "HyFlex es una modalidad de enseñanza y aprendizaje que se enmarca dentro de lo que se conoce como modelo Mixto, Híbrido o B-learning. Es Híbrido, porque integra las modalidades: presencial, online y flexible, porque los estudiantes tienen la posibilidad de participar en forma presencial o a distancia.",
                style: TextStyle(fontSize: 16, height: 1.5)),
          ],
        ),
      ),
    );
  }

  Widget _crearListaDeImagenes() {
    return _crearGrid(imageInfo);
  }

  Widget _crearListaDeImagenes2() {
    return _crearGrid(imageInfo2);
  }

  Widget _crearGrid(List<Map<String, String?>> imageList) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: imageList.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => launchURL(imageList[index]["url"] ?? ""),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    imageList[index]["imagePath"] ?? "",
                    width: 100,
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 8),
                  Text(
                    imageList[index]["title"] ?? "",
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
