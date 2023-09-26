import 'package:flutter/material.dart';

class Cursospage extends StatelessWidget {
  final List<Map<String, String?>> imageInfo = [
    {"imagePath": "assets/documentos.png", "title": "Documentos"},
    {
      "imagePath": "assets/ejemplos_de_presentacion.png",
      "title": "Ejemplos de presentacion"
    },
    {
      "imagePath": "assets/e_actividades.png",
      "title": "Ejemplos de actividades"
    },
    {"imagePath": "assets/ejemplo_red.png", "title": "Ejemplos de RED"},
    {"imagePath": "assets/guiones.png", "title": "Formatos de Guiones"},
    {"imagePath": "assets/herramientas_tic.png", "title": "Herramientas TIC"},
    {"imagePath": "assets/banner.png", "title": "Banner"},
    {"imagePath": "assets/seguimiento.png", "title": "Seguimiento"},
    // Agrega las rutas de tus imágenes y títulos aquí
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Curso", style: TextStyle(color: Colors.black)),
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
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: imageInfo.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      imageInfo[index]["imagePath"] ?? "",
                      width: 120, // Ajusta el ancho de la imagen
                      height: 80, // Ajusta la altura de la imagen
                      fit: BoxFit
                          .contain, // Ajusta el modo de ajuste de la imagen
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
            ));
      },
    );
  }
}
