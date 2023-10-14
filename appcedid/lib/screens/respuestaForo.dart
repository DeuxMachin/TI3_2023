import 'package:flutter/material.dart';
import 'post.dart';
import 'package:intl/intl.dart';
import 'perfil.dart';

class PostList extends StatefulWidget {
  final List<Post> listItems;
  PostList(this.listItems);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  void like(Function callBack) {
    this.setState(() {
      callBack();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.widget.listItems.length,
      itemBuilder: (context, index) {
        var post = this.widget.listItems[index];

        return Container(
          padding: EdgeInsets.all(4),
          margin: EdgeInsets.all(4),
          child: Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: post.userImg != null
                        ? NetworkImage(post.userImg)
                        : null,
                    radius: 30,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        post.author,
                        style: TextStyle(color: Colors.blue[200], fontSize: 20),
                      ),
                      Text(post.subject),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PerfilPage()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.yellow, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'perfil',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    post.title,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Text(post.body),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      DateFormat('hh:mm a').format(post.time) +
                          '~' +
                          '${post.time.day}/${post.time.month}/${post.time.year}',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class forum2 extends StatefulWidget {
  final Post post;
  const forum2({required this.post, Key? key}) : super(key: key);

  @override
  State<forum2> createState() => _forum2State();
}

class _forum2State extends State<forum2> {
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    posts.add(widget.post);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text('Foro de respuestas', style: TextStyle(color: Colors.black)),
          backgroundColor: Color.fromARGB(255, 235, 250, 151),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body:
            Column(children: <Widget>[Expanded(child: PostList(this.posts))]));
  }
}
