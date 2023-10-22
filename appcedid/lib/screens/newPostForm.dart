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

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Crea tu publicacion', style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color.fromARGB(255, 235, 250, 151),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: _inputDecoration('Titulo'),
                    onSaved: (value) {
                      title = value ?? '';
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa un título';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: _inputDecoration('Materia'),
                    onSaved: (value) {
                      subject = value ?? '';
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa una materia';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: _inputDecoration('Cuerpo'),
                    onSaved: (value) {
                      body = value ?? '';
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa su consulta';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32),
                  ElevatedButton.icon(
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
                    icon: Icon(Icons.send),
                    label: Text('Enviar'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
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
