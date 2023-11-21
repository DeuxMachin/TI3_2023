import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'editPostForm.dart'; // Asegúrate de importar la página de edición correctamente

class UserPostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title:
              Text('Mis Publicaciones', style: TextStyle(color: Colors.black)),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Color.fromARGB(255, 235, 250, 151),
        ),
        body: Center(child: Text("No se ha encontrado un usuario autenticado")),
      );
    }

    final Stream<QuerySnapshot> _userPostsStream = FirebaseFirestore.instance
        .collection('posts')
        .where('author', isEqualTo: user.displayName)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Publicaciones', style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color.fromARGB(255, 235, 250, 151),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _userPostsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
                child: Text('No posee publicaciones',
                    style: TextStyle(color: Colors.black)));
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(data['userImg']),
                      ),
                      title: Text(data['title'] ?? 'Sin título'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data['subject'] ?? 'Sin asunto'),
                          Text(
                            data['author'] ?? 'Autor desconocido',
                            style: TextStyle(
                                color: Colors.blue[200], fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(data['body'] ?? 'Sin contenido'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton.icon(
                          icon: Icon(Icons.delete, color: Colors.red),
                          label: Text('Eliminar',
                              style: TextStyle(color: Colors.red)),
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('posts')
                                .doc(document.id)
                                .delete();
                          },
                        ),
                        TextButton.icon(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          label: Text('Editar'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditPostForm(documentId: document.id)),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}