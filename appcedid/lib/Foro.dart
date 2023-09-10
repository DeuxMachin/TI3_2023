import 'package:flutter/material.dart';
import 'post.dart';
import 'postList.dart';
import 'textInputWidget.dart';

class foro extends StatefulWidget {
  const foro({super.key});

  @override
  State<foro> createState() => _foroState();
}

class _foroState extends State<foro> {
  List<Post> posts = [];

  void newPost(String text){
    this.setState(() {
      posts.add(new Post(text, "User"));
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title: Text('Foro')), 
    body: Column(children:<Widget>[
      Expanded(child: PostList(this.posts)),
      TextInputWidget(this.newPost)
      ]));
  }
}