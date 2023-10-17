import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ImpulsaRed extends StatefulWidget {
  @override
  _ImpulsaRedState createState() => _ImpulsaRedState();
}

class _ImpulsaRedState extends State<ImpulsaRed> {
  final List<Map<String, String?>> imageInfo = [
    {
      "imagePath": "assets/IconPDF.png",
      "title": "Impulsa tu red ",
      "url": "https://dte.uct.cl/impulsatured/ "
    },
    // Agrega las rutas de tus imágenes y títulos aquí
  ];

  void launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Impulsa Tu Red", style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color.fromARGB(255, 235, 250, 151),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: <Widget>[
              Image.asset("assets/impulsa_tu_red.png"),
              _crearCurso1(),
              Text('Links para completar el formulario',
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
              "El presente formulario tiene por finalidad recoger la información del tipo de Recurso Educativo Digital que quieres modificar. Agradecemos tu interés y en un plazo de tres días hábiles nos contactaremos contigo para iniciar el proceso de asesoría y co-creación. El proceso de inscripción está abierto hasta fines de mayo y los RED que se “re- diseñan” se aplican el II semestre del año en curso.¡Gracias!",
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
            launchURL(imageInfo[index]["url"] ?? "");
            ; // Reemplaza "AQUÍ_INSERTA_LA_URL" con la URL correspondiente
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
}
