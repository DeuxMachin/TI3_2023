import 'package:flutter/material.dart';

class ModeloEduca extends StatelessWidget {
  final List<Map<String, String?>> imageInfo = [
    {"imagePath": "assets/IconPDF.png", "title": "Modelo Educativo UC Temuco"},
    {
      "imagePath": "assets/IconPDF.png",
      "title": "Competencias genéricas"
    },
    {
      "imagePath": "assets/IconPDF.png",
      "title": "Perfil Docente UC Temuco"
    },
    // Agrega las rutas de tus imágenes y títulos aquí
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modelo Educacional", style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color.fromARGB(255, 235, 250, 151),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: <Widget>[
              Image.asset("assets/ModeloEduca.png"),
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
            Text("En el contexto de la formación integral que busca entregar la Universidad, los docentes deben ser capaces de crear nuevos espacios de información e interacción, de orientar a sus estudiantes respecto del acceso y uso de los espacios existentes, entre los cuales los espacios virtuales se constituyen en un lugar privilegiado para la construcción de conocimiento en las distintas disciplinas, para el ejercicio de la ciudadanía y para la creación de comunidades profesionales, entre otros."
             "Uno de los ejes principales del perfil docente son las competencias, estas permiten el desarrollo de una pedagogía de excelencia. El Perfil docente a que todo(a) académico(a) de la Universidad Católica de Temuco debe aspirar para un desempeño de excelencia considera la competencia “Uso pedagógico de las TIC”",
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
