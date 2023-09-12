import 'package:flutter/material.dart';
import 'post.dart';
import 'postList.dart';
import 'textInputWidget.dart';

class forum1 extends StatefulWidget {
  const forum1({super.key});

  @override
  State<forum1> createState() => _forum1State();
}

class _forum1State extends State<forum1> {
  List<Post> posts = [];

void newPost(String text){
    this.setState(() {
      posts.add(new Post(text, "User", "https://cdn-icons-png.flaticon.com/512/149/149071.png", DateTime.now()));
    });
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title: Text('forum1')), 
    body: Column(children:<Widget>[
      Expanded(child: PostList(this.posts)),
      TextInputWidget(this.newPost)
      ]));
  }
}
