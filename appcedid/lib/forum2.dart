import 'package:flutter/material.dart';
import 'post.dart';
import 'postListAnswers.dart';
//import 'textInputWidget.dart';

class forum2 extends StatefulWidget {
  const forum2({super.key});

  @override
  State<forum2> createState() => _forum2State();
}

class _forum2State extends State<forum2> {
  List<Post> posts = [];

  _forum2State() {
    posts.add(Post("Lorem Ipsum", "Lorem Ipsum", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sollicitudin imperdiet erat, et scelerisque diam pulvinar dignissim. Pellentesque vitae orci semper, rhoncus mi at, ultrices justo. Cras lacus est, placerat non pretium sit amet, ullamcorper sit amet massa. Aenean vitae pharetra nunc. Nam pulvinar nulla in augue dignissim, pharetra sagittis ex vulputate. Fusce est mi, maximus ut orci bibendum, euismod euismod enim. Aliquam et neque ligula. Ut porta purus a nisl fermentum, a rutrum dolor tempus. Pellentesque eu ligula ligula. Nullam purus orci, placerat ut enim in, convallis dapibus lorem.",
     "Author", "https://cdn-icons-png.flaticon.com/512/149/149071.png", DateTime.now()));
  }


/*void newPost(String body){
    this.setState(() {
      posts.add(new Post("Titulo", "Subtitulo", body, "User", "https://cdn-icons-png.flaticon.com/512/149/149071.png", DateTime.now()));
    });
}
*/

  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title: Text('Foro de respuestas'),backgroundColor: Color.fromARGB(255, 235, 250, 151),), 
    body: Column(children:<Widget>[
      Expanded(child: PostList(this.posts))
      ]));
  }
}