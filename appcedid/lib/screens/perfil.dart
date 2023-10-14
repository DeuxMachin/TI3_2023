import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('Usuarios');
  List usuarioData = [];

  @override
  void initState() {
    super.initState();
    getData().then((_) {
      setState(() {});
    });
  }

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    usuarioData = querySnapshot.docs.map((doc) => doc.data()).toList();

    print(usuarioData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Perfil del Docente', style: TextStyle(color: Colors.black)),
        backgroundColor: Color.fromARGB(255, 235, 250, 151),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (usuarioData.isEmpty) {
              return Center(child: Text("No hay datos disponibles"));
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 110.0,
                    backgroundImage: AssetImage('assets/user1.png'),
                  ),
                  Text(
                    'Nombre del Docente',
                    style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Card(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.teal,
                      ),
                      title: Text(
                        usuarioData[0]['Nombre'],
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.teal.shade900,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.cake,
                        color: Colors.teal,
                      ),
                      title: Text(
                        'ALOG',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.teal.shade900,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.phone,
                        color: Colors.teal,
                      ),
                      title: Text(
                        'celular',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.teal.shade900,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.email,
                        color: Colors.teal,
                      ),
                      title: Text(
                        usuarioData[0]['email'],
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.teal.shade900,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.lock,
                        color: Colors.teal,
                      ),
                      title: Text(
                        usuarioData[0]['Clave'],
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.teal.shade900,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
