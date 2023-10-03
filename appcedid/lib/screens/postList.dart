import 'package:flutter/material.dart';
import 'post.dart';
import 'respuestaForo.dart';

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
                      Text(post.subtitle),
                      Text(
                        post.author,
                        style: TextStyle(color: Colors.blue[200], fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(post.body),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Text(
                        post.likes.toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.favorite),
                      onPressed: () => like(post.likePost),
                      color: post.userLiked ? Colors.green : Colors.black,
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_circle_right_outlined),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => forum2()),
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
  }
}
