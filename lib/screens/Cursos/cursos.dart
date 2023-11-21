import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Cursospage extends StatefulWidget {
  @override
  _CursospageState createState() => _CursospageState();
}

class _CursospageState extends State<Cursospage> {
  final List<Map<String, dynamic?>> imageInfo = [
    {
      "imagePath": "assets/documentos.png",
      "title": "Documentos",
      "urls": [
        {
          "name": "Definiendo",
          "url":
              "https://dte.uct.cl/wp-content/uploads/2022/08/Definiendo-mi-mo%CC%81dulo-e-learning.docx"
        },
        {
          "name": "Planificacion E-actividades",
          "url":
              "https://dte.uct.cl/wp-content/uploads/2023/03/Planificacion-y-descripcion-de-e-actividades.docx"
        },
        {
          "name": "Fichas",
          "url":
              "https://dte.uct.cl/wp-content/uploads/2022/08/Fichas-virtualizacio%CC%81n-2022.pdf"
        },
      ],
    },
    {
      "imagePath": "assets/ejemplos_de_presentacion.png",
      "title": "Ejemplos de presentación",
      "urls": [
        {"name": "Ejemplo de video 1", "url": "https://youtu.be/VXP41cWmdbY"},
        {"name": "Ejemplo de video 2", "url": "https://youtu.be/15iKCUwMV1Y"},
        {"name": "Ejemplo de video 3", "url": "https://youtu.be/N38Cia82uiY"},
        {"name": "Ejemplo de video 4", "url": "https://youtu.be/1vIKUSsWmdE"},
        {"name": "Ejemplo de video 5", "url": "https://youtu.be/kfs52YF0dtM"},
      ],
    },
    {
      "imagePath": "assets/e_actividades.png",
      "title": "Ejemplos de actividades",
      "urls": [
        {
          "name": "Acceso",
          "url":
              "https://dte.uct.cl/wp-content/uploads/2022/08/Definiendo-mi-mo%CC%81dulo-e-learning.docx"
        },
        {
          "name": "Motivacion",
          "url":
              "https://dte.uct.cl/wp-content/uploads/2023/03/Planificacion-y-descripcion-de-e-actividades.docx"
        },
        {
          "name": "Socializacion de informacion",
          "url":
              "https://dte.uct.cl/wp-content/uploads/2022/08/Fichas-virtualizacio%CC%81n-2022.pdf"
        },
        {
          "name": "Intercambio de informacion",
          "url":
              "https://dte.uct.cl/wp-content/uploads/2022/08/Definiendo-mi-mo%CC%81dulo-e-learning.docx"
        },
        {
          "name": "Construccion del conocimiento",
          "url":
              "https://dte.uct.cl/wp-content/uploads/2023/03/Planificacion-y-descripcion-de-e-actividades.docx"
        },
        {
          "name": "Desarrollo",
          "url":
              "https://dte.uct.cl/wp-content/uploads/2022/08/Fichas-virtualizacio%CC%81n-2022.pdf"
        },
      ],
    },
    {
      "imagePath": "assets/ejemplo_red.png",
      "title": "Ejemplos de RED",
      "urls": [
        {"name": "Infografias 1", "url": "https://dte.uct.cl/impulsatured/"},
        {"name": "Infografias 2", "url": "https://dte.uct.cl/impulsatured/"},
        {"name": "Infografias 3", "url": "https://dte.uct.cl/impulsatured/"},
        {
          "name": "Cápsula de  contenido 1",
          "url": "https://dte.uct.cl/impulsatured/"
        },
        {
          "name": "Cápsula de  contenido 2",
          "url": "https://dte.uct.cl/impulsatured/"
        },
        {
          "name": "Cápsula de  contenido 3",
          "url": "https://dte.uct.cl/impulsatured/"
        },
        {
          "name": "Podcast de contenido",
          "url": "https://dte.uct.cl/impulsatured/"
        },
      ],
    },
    {
      "imagePath": "assets/guiones.png",
      "title": "Formatos de Guiones",
      "urls": [
        {
          "name": "Guión video de contenido",
          "url":
              "https://dte.uct.cl/wp-content/uploads/2022/08/Guio%CC%81n-grabacio%CC%81n-Video-versio%CC%81n.docx"
        },
        {
          "name": "Guión podcast de contenido",
          "url":
              "https://dte.uct.cl/wp-content/uploads/2022/08/Guio%CC%81n-capsula-de-audio.docx"
        },
        {
          "name": "Consideraciones para la grabación de forma autónoma",
          "url":
              "https://dte.uct.cl/wp-content/uploads/2022/08/Consideraciones-para-la-grabacio%CC%81n-de-forma-auto%CC%81noma.pdf"
        },
      ],
    },
    {
      "imagePath": "assets/herramientas_tic.png",
      "title": "Herramientas TIC",
      "urls": [
        {
          "name": "Cómo crear códigos QR",
          "url": "https://youtu.be/7FUF7U_hklk"
        },
        {
          "name": "Nearpod para el trabajo participativo de tus estudiantes",
          "url": "https://youtu.be/3sWGkAXFS3c"
        },
        {
          "name": "Qué son y cómo activar extensiones en Google Chrome",
          "url": "https://youtu.be/iGOE5_MhTCo"
        },
        {"name": "Audacity", "url": "https://youtu.be/G8gRbOZy7z4"},
        {
          "name": "Portadas para tus podcast con Canva",
          "url": "https://youtu.be/9FBOmVJei3g"
        },
        {
          "name": "Subiendo tu podcast a Spotify",
          "url": "https://youtu.be/_osm1RUvzYI"
        },
        {"name": "Tutorial Padlet", "url": "http://youtu.be/naZFyr0-fIk"},
        {"name": "Tutorial Quizizz", "url": "http://youtu.be/T18sshtlIC0"},
        {"name": "Tutorial Edpuzzle", "url": "http://youtu.be/YmxUZ37vSHU"},
        {"name": "Tutorial Flipgrid", "url": "https://youtu.be/uUaKCqsr1oQ"},
        {"name": "Tutorial Wordwall", "url": "https://youtu.be/D2VNr5niFI4"},
      ],
    },
    {
      "imagePath": "assets/banner.png",
      "title": "Banner",
      "urls": [
        {
          "name": "Crea el banner de curso",
          "url":
              "https://dte.uct.cl/recursos-graficos/banner-de-curso-blackboard/"
        },
      ],
    },
    {
      "imagePath": "assets/seguimiento.png",
      "title": "Seguimiento",
      "urls": [
        {
          "name": "Seguimiento",
          "url":
              "https://dte.uct.cl/wp-content/uploads/2022/08/Ficha-Tutoras-y-Tutores-E-learning.pdf"
        },
      ],
    },
    // Agrega las rutas de tus imágenes y títulos aquí
  ];

  void launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  int? selectedCardIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Virtualización", style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color.fromARGB(255, 235, 250, 151),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: <Widget>[
              Image.asset("assets/Virtualiza.png"),
              Image.asset("assets/principios_orientadores.png"),
              _crearCurso1(),
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
              'El e-learning está pensado para ejercer una acción formativa, basando el proceso de aprendizaje, en una interacción completamente sostenida en tecnología, sin necesidad del contacto físico del alumno con el profesor, ni tampoco la asistencia del alumno a una sala de clases.',
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }

  Widget _crearListaDeImagenes() {
    return SingleChildScrollView(
      child: Column(
        children: imageInfo.asMap().entries.map((entry) {
          final index = entry.key;
          final data = entry.value;
          final isSelected = selectedCardIndex == index;

          return Container(
            height: 200,
            width: 380, // altura fija para todas las tarjetas
            child: Card(
              elevation: 5,
              child: SingleChildScrollView(
                // Añade SingleChildScrollView aquí
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (selectedCardIndex == index) {
                            selectedCardIndex = null;
                          } else {
                            selectedCardIndex = index;
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Image.asset(
                          data["imagePath"] ?? "",
                          width: 120,
                          height: 80,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      data["title"] ?? "",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (isSelected) _buildLinkList(data),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLinkList(Map<String, dynamic?> data) {
    final urls = data["urls"] as List<Map<String, dynamic>>?;

    if (urls != null && urls.isNotEmpty) {
      return Column(
        children: urls.map((urlData) {
          final url = urlData["url"];
          final name = urlData["name"];

          return ListTile(
            title: GestureDetector(
              onTap: () {
                launchURL(url);
              },
              child: Text(
                name ?? "Enlace",
                style: TextStyle(
                  color: Colors.blue, // Cambia el color del texto a azul
                  decoration: TextDecoration.underline, // Subraya el texto
                ),
              ),
            ),
          );
        }).toList(),
      );
    } else {
      // Si no hay URLs, muestra un mensaje alternativo
      return Container(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "No hay enlaces disponibles",
          style: TextStyle(
            color: Colors.grey, // Puedes ajustar el color del texto
          ),
        ),
      );
    }
  }
}
