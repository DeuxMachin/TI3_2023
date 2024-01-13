import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ModeloEduca extends StatelessWidget {
  final List<Map<String, String?>> imageInfo = [
    {
      "imagePath": "assets/IconPDF.png",
      "title": "Modelo Educativo UC Temuco",
      "url":
          "https://dte.uct.cl/wp-content/uploads/2018/08/ModeloEducativoUCT-1.pdf"
    },
    {
      "imagePath": "assets/IconPDF.png",
      "title": "Competencias genéricas",
      "url":
          "https://dte.uct.cl/wp-content/uploads/2018/08/competencias_genericas-2.pdf"
    },
    {
      "imagePath": "assets/IconPDF.png",
      "title": "Perfil Docente UC Temuco",
      "url":
          "https://dte.uct.cl/wp-content/uploads/2018/06/Perfil-Docente-UC-TEMUCO.pdf"
    },
    // Agrega las rutas de tus imágenes y títulos aquí
  ];

  void launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modelo Educacional",
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: <Widget>[
            Image.asset(
              "assets/ModeloEducativoInstitucional.png",
              fit: BoxFit.cover,
            ),
            _crearCurso1(),
            SizedBox(height: 20),
            Text('Cursos sobre Modelo Educacional',
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
                "En el contexto de la formación integral que busca entregar la Universidad, los docentes deben ser capaces de crear nuevos espacios de información e interacción, de orientar a sus estudiantes respecto del acceso y uso de los espacios existentes, entre los cuales los espacios virtuales se constituyen en un lugar privilegiado para la construcción de conocimiento en las distintas disciplinas, para el ejercicio de la ciudadanía y para la creación de comunidades profesionales, entre otros."
                "Uno de los ejes principales del perfil docente son las competencias, estas permiten el desarrollo de una pedagogía de excelencia. El Perfil docente a que todo(a) académico(a) de la Universidad Católica de Temuco debe aspirar para un desempeño de excelencia considera la competencia “Uso pedagógico de las TIC”",
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
