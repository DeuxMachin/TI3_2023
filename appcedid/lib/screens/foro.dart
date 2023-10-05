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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Foro de consultas', style: TextStyle(color: Colors.black)),
        backgroundColor: Color.fromARGB(255, 235, 250, 151),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(children: <Widget>[Expanded(child: PostList(_postsStream))]),
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

class PostList extends StatefulWidget {
  final Stream<QuerySnapshot> postStream;
  PostList(this.postStream);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  void like(Function callBack) {
    this.setState(() {
      callBack();
    });
  }

  @override
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

        // Use the null-aware operator to access 'docs'
        final docs = snapshot.data?.docs;
        if (docs == null) {
          return Text("No data");
        }

        return ListView.builder(
          // Use the null-aware operator to get the length of 'docs'
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
                        child: Text(post.body),
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
      },
    );
  }
}
