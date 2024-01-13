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
      "url": "https://dte.uct.cl/impulsatured/"
    },
    // Asegúrate de que todos los elementos aquí tengan un "url" válido, si no, ponlo como null.
    // Agrega las rutas de tus imágenes y títulos aquí
  ];

  void launchURL(String? url) async {
    if (url != null && await canLaunch(url)) {
      await launch(url);
    } else {
      // Puedes mostrar un mensaje o hacer algo cuando el URL no es válido o es nulo
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo abrir el enlace')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Impulsa Tu Red",
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: <Widget>[
            Image.asset("assets/ImpulsaTuRed.png", fit: BoxFit.cover),
            SizedBox(height: 20),
            _crearCurso1(),
            SizedBox(height: 20),
            Text('Links para completar el formulario',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
            Text('El objetivo de este curso',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            SizedBox(height: 10),
            Text(
                "El presente formulario tiene por finalidad recoger la información del tipo de Recurso Educativo Digital que quieres modificar. Agradecemos tu interés y en un plazo de tres días hábiles nos contactaremos contigo para iniciar el proceso de asesoría y co-creación. El proceso de inscripción está abierto hasta fines de mayo y los RED que se “re- diseñan” se aplican el II semestre del año en curso. ¡Gracias!",
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
