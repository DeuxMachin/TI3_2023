import 'package:flutter/material.dart';
import 'post.dart';
import 'postListAnswers.dart';
import 'textInputWidget.dart';

class forum2 extends StatefulWidget {
  const forum2({super.key});

  @override
  State<forum2> createState() => _forum2State();
}

class _forum2State extends State<forum2> {
  List<Post> posts = [];

void newPost(String text){
    this.setState(() {
      posts.add(new Post(text, "User", "https://cdn-icons-png.flaticon.com/512/149/149071.png", DateTime.now()));
    });
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title: Text('forum2')), 
    body: Column(children:<Widget>[
      Expanded(child: PostList(this.posts)),
      TextInputWidget(this.newPost)
      ]));
  }
}