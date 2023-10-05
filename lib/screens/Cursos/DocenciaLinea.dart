import 'package:flutter/material.dart';

class DocenciaLinea extends StatelessWidget {
  final List<Map<String, String?>> imageInfo = [
    {"imagePath": "assets/IconPDF.png", "title": "Educación a Distancia"},

    // Agrega las rutas de tus imágenes y títulos aquí
  ];

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
