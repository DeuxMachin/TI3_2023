import 'package:flutter/material.dart';
import 'package:ti3/utils/database_service.dart'; // Importa el servicio de base de datos aquí

class NewPostForm extends StatefulWidget {
  @override
  _NewPostFormState createState() => _NewPostFormState();
}

class _NewPostFormState extends State<NewPostForm> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String subject = '';
  String body = '';
  final db =
      DatabaseService(); // Crea una instancia del servicio de base de datos aquí

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva publicacion foro'),
        backgroundColor: Color.fromARGB(255, 235, 250, 151),
      ),
      body: Padding(
        padding: EdgeInsets.all(4),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(4),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Titulo'),
                    onSaved: (value) {
                      title = value ?? '';
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Materia'),
                    onSaved: (value) {
                      subject = value ?? '';
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Cuerpo'),
                    onSaved: (value) {
                      body = value ?? '';
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        // Aquí puedes manejar la lógica para guardar el post
                        // Por ejemplo, puedes llamar a una función para guardar el post en una base de datos
                        await db.createPost(
                            title,
                            subject,
                            body,
                            'olaa',
                            'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                            DateTime.now());
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
