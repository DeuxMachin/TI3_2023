import 'package:flutter/material.dart';
import 'post.dart';

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
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          post.userImg != null ? NetworkImage(post.userImg) : null,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(post.body),
                        Text(post.author),
                      ],
                    ),
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
                      icon: Icon(Icons.thumb_up),
                      onPressed: () => like(post.likePost),
                      color: post.userLiked ? Colors.green : Colors.black,
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_right),
                      onPressed: () {
                        // Add your comment button logic here
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
