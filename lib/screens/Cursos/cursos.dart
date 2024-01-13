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
              "https://cinap.uct.cl/wp-content/uploads/2022/08/Definiendo-mi-módulo-e-learning.docx"
        },
        {
          "name": "Planificacion E-actividades",
          "url":
              "https://cinap.uct.cl/wp-content/uploads/2023/03/Planificacion-y-descripcion-de-e-actividades.docx"
        },
        {
          "name": "Fichas",
          "url":
              "https://cinap.uct.cl/wp-content/uploads/2022/08/Fichas-virtualización-2022.pdf"
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
      "imagePath": "assets/ejemplo_red.png",
      "title": "Ejemplos de RED",
      "urls": [
        {
          "name": "Infografias 1",
          "url":
              "https://view.genial.ly/5ed92b2a352b1f0db1854636/presentation-infografia-01-que-son-los-hongos"
        },
        {
          "name": "Infografias 2",
          "url":
              "https://view.genial.ly/6100290ad5b1780d16bc7f34/presentation-gestion-de-costos"
        },
        {
          "name": "Infografias 3",
          "url":
              "https://view.genial.ly/6165d76cbfaba50d9c6229cb/presentation-peer-feedback"
        },
        {
          "name": "Cápsula de  contenido 1",
          "url": "https://www.youtube.com/watch?v=XdjVxUutZ0U"
        },
        {
          "name": "Cápsula de  contenido 2",
          "url": "https://www.youtube.com/watch?v=VI2x_4JyxKM"
        },
        {
          "name": "Cápsula de  contenido 3",
          "url": "https://www.youtube.com/watch?v=qR5NajY-eWU"
        },
        {
          "name": "Podcast de contenido",
          "url": "https://cinap.uct.cl/educacionpodcast/"
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
              "https://cinap.uct.cl/wp-content/uploads/2022/08/Guión-grabación-Video-versión.docx"
        },
        {
          "name": "Guión podcast de contenido",
          "url":
              "https://cinap.uct.cl/wp-content/uploads/2022/08/Guión-capsula-de-audio.docx"
        },
        {
          "name": "Consideraciones para la grabación de forma autónoma",
          "url":
              "https://cinap.uct.cl/wp-content/uploads/2022/08/Consideraciones-para-la-grabación-de-forma-autónoma.pdf"
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
              "https://cinap.uct.cl/recursos-graficos/banner-de-curso-blackboard/"
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
              "https://cinap.uct.cl/wp-content/uploads/2022/08/Ficha-Tutoras-y-Tutores-E-learning.pdf"
        },
      ],
    },
    // Agrega las rutas de tus imágenes y títulos aquí
  ];
  // Constantes para estilos
  static const TextStyle titleStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  static const TextStyle linkStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.blue,
      decoration: TextDecoration.underline);

  // Mapa para rastrear la expansión de los elementos
  Map<int, bool> expandedItems = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Virtualización",
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: <Widget>[
            Image.asset("assets/Virtualiza.png", fit: BoxFit.cover),
            SizedBox(height: 20),
            _crearCurso1(),
            ..._crearListaDeImagenes(),
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
                'El e-learning está pensado para ejercer una acción formativa, basando el proceso de aprendizaje, en una interacción completamente sostenida en tecnología, sin necesidad del contacto físico del alumno con el profesor, ni tampoco la asistencia del alumno a una sala de clases.',
                style: TextStyle(fontSize: 16, height: 1.5)),
          ],
        ),
      ),
    );
  }

  List<Widget> _crearListaDeImagenes() {
    return imageInfo.asMap().entries.map((entry) {
      int index = entry.key;
      Map<String, dynamic?> data = entry.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTitle(index, data),
          if (expandedItems[index] ?? false)
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio:
                    1.5, // Ajusta este valor según el tamaño deseado
              ),
              itemCount: (data["urls"] as List).length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int linkIndex) {
                final urlData = data["urls"][linkIndex];
                return _buildLinkCard(urlData);
              },
            ),
        ],
      );
    }).toList();
  }

  Widget _buildLinkCard(Map<String, dynamic> urlData) {
    final url = urlData["url"];
    final name = urlData["name"];
    String imagePath = url.contains("youtu.be") || url.contains("youtube.com")
        ? "assets/youtube.png"
        : "assets/IconPDF.png";

    return GestureDetector(
      onTap: () {
        launchURL(url);
      },
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                imagePath,
                width: 100,
                height: 60,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 8),
              Flexible(
                child: Text(
                  name ?? "Enlace",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis, // Añadir puntos suspensivos
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(int index, Map<String, dynamic?> data) {
    // Revisar si el ítem actual está expandido
    bool isExpanded = expandedItems[index] ?? false;

    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 8.0),
      leading: Icon(
        isExpanded
            ? Icons.arrow_downward
            : Icons.arrow_forward, // Cambia la flecha según el estado
        color: Colors.grey[600], // Puedes cambiar el color si es necesario
      ),
      title: Text(
        data["title"] ?? "",
        style: titleStyle,
        textAlign: TextAlign.left,
      ),
      onTap: () {
        setState(() {
          // Cambia el estado de expandido o contraído
          expandedItems[index] = !isExpanded;
        });
      },
    );
  }

  List<Widget> _buildLinkList(Map<String, dynamic?> data) {
    final urls = data["urls"] as List<Map<String, dynamic>>?;

    if (urls != null && urls.isNotEmpty) {
      return [
        Wrap(
          spacing: 8.0, // Espacio horizontal entre los widgets
          runSpacing: 8.0, // Espacio vertical entre las filas
          alignment: WrapAlignment.start, // Alinea los widgets al inicio
          children: urls.map((urlData) {
            final url = urlData["url"];
            final name = urlData["name"];
            String imagePath =
                url.contains("youtu.be") || url.contains("youtube.com")
                    ? "assets/youtube.png"
                    : "assets/IconPDF.png";

            return GestureDetector(
              onTap: () {
                launchURL(url);
              },
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        imagePath,
                        width: 100, // Reducido de 100
                        height: 60, // Reducido de 60
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 4),
                      Text(
                        name ?? "Enlace",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold), // Reducido de 16
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        )
      ];
    } else {
      return [
        Text("No hay enlaces disponibles", style: TextStyle(color: Colors.grey))
      ];
    }
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
