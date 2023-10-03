import 'package:flutter/material.dart';
import 'post.dart';
import 'postList.dart';
import 'newPostForm.dart';

class ForoPage extends StatefulWidget {
  @override
  State<ForoPage> createState() => _forum1State();
}

class _forum1State extends State<ForoPage> {
  List<Post> posts = [];

// el dato estatico es este
  _forum1State() {
    posts.add(Post(
        "Lorem Ipsum",
        "Lorem Ipsum",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. rhoncus mi at, ultrices justo. Cras lacus est, placerat non pretium sit amet, ullamcorper sit amet massa. Aenean vitae pharetra nunc. Aliquam et neque ligula. Ut porta purus a nisl fermentum, a rutrum dolor .....",
        "Author",
        "https://cdn-icons-png.flaticon.com/512/149/149071.png",
        DateTime.now()));
  }

  void newPost(String text) {
    this.setState(() {
      posts.add(new Post(
          "Titulo",
          "Subtitulo",
          text,
          "Author",
          "https://cdn-icons-png.flaticon.com/512/149/149071.png",
          DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Foro de consultas', style: TextStyle(color: Colors.black)),
        backgroundColor: Color.fromARGB(255, 235, 250, 151),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(children: <Widget>[Expanded(child: PostList(this.posts))]),
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