import 'package:flutter/material.dart';

class EducaBlack extends StatelessWidget {
  final List<Map<String, String?>> imageInfo = [
    {"imagePath": "assets/CPC.jpg", "title": "Crea tu propio banner de curso"},
    {
      "imagePath": "assets/ReCoCu.jpg",
      "title": "Recursos para el contenido de tu curso"
    },
    {
      "imagePath": "assets/CePrCu.jpg",
      "title": "Crea tu propio banner de curso"
    },
    // Agrega las rutas de tus imágenes y títulos aquí
  ];

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
              Image.asset("assets/EducaBlack.png"),
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
                      height: 70, // Ajusta la altura de la imagen
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
