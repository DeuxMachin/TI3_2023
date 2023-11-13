// ignore_for_file: override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'newPostForm.dart';
import 'post.dart';
import 'respuestaForo.dart';

class ForoPage extends StatefulWidget {
  @override
  _ForoPageState createState() => _ForoPageState();
}

class _ForoPageState extends State<ForoPage> {
  final Stream<QuerySnapshot> _postsStream =
      FirebaseFirestore.instance.collection('posts').snapshots();
  TextEditingController _searchController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Foro de consultas', style: TextStyle(color: Colors.black)),
        backgroundColor: Color.fromARGB(255, 235, 250, 151),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 250, // Adjust the width as needed
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: 'Buscar palabras...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implementar la lógica de búsqueda si es necesario
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[Expanded(child: PostList(_postsStream, _searchController.text))],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewPostForm()),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Color.fromRGBO(56, 84, 232, 1),
      ),
    );
  }
}


// creo que es la lista de los post que se encuentran almacenados
class PostList extends StatefulWidget {
  final Stream<QuerySnapshot> postStream;
  final String searchTerm;

  PostList(this.postStream, this.searchTerm);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  void like(Function callBack) {
    this.setState(() {
      callBack();
    });
  }
// es para el limite de palabras que se muestran
  @override
  String limitWords(String text, int wordLimit) {
    List<String> words = text.split(' ');

    if (words.length <= wordLimit) {
      return text;
    }

    return words.take(wordLimit).join(' ') + '.....';
  }



  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.postStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        final docs = snapshot.data?.docs;
        if (docs == null) {
          return Text("No data");
        }

        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            var postData = docs[index].data() as Map<String, dynamic>;
            var post = Post(
              postData['title'], 
              postData['subject'],
              postData['body'],
              postData['author'],
              postData['userImg'],
              postData['time'].toDate(),
            );

            // Filtra los resultados según el término de búsqueda
            if (widget.searchTerm.isNotEmpty &&
                !post.body.toLowerCase().contains(widget.searchTerm.toLowerCase())) {
              return Container(); // Si no coincide con la búsqueda, retorna un contenedor vacío
            }

            return Container(
              padding: EdgeInsets.all(4),
              margin: EdgeInsets.all(4),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(post.userImg),
                      ),
                      title: Text(post.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post.subject),
                          Text(
                            post.author,
                            style: TextStyle(
                                color: Colors.blue[200], fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(limitWords(post.body, 20)),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.favorite),
                          onPressed: () => post.likePost(),
                          color: post.userLiked ? Colors.green : Colors.black,
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_circle_right_outlined),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => forum2(post: post)),
                            );
                          },
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
