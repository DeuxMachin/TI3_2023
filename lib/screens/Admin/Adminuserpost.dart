import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ti3/screens/editPostForm.dart'; // Asegúrate de importar la página de edición correctamente

class UserPostsPageAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _showDeleteDialog(BuildContext context, String documentId) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirmar"),
            content:
                Text("¿Estás seguro de que deseas eliminar esta publicación?"),
            actions: <Widget>[
              TextButton(
                child: Text("Cancelar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton.icon(
                icon: Icon(Icons.delete, color: Colors.red),
                label: Text('Eliminar', style: TextStyle(color: Colors.red)),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await FirebaseFirestore.instance
                      .collection('posts')
                      .doc(documentId)
                      .delete();
                },
              ),
            ],
          );
        },
      );
    }

    final Stream<QuerySnapshot> _userPostsStream =
        FirebaseFirestore.instance.collection('posts').snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text('Publicaciones', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.deepPurple,
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
                child: Text('No hay publicaciones',
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
                          onPressed: () {
                            _showDeleteDialog(context, document.id);
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
