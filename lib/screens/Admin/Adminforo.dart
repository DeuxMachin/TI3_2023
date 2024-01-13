import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ti3/screens/Admin/Adminuserpost.dart';
import 'package:ti3/screens/post.dart';
import 'package:ti3/screens/admin/Adminfororespuesta.dart';
import 'package:ti3/main.dart';

class ForoPageAdmin extends StatefulWidget {
  @override
  _ForoPageAdminState createState() => _ForoPageAdminState();
}

class _ForoPageAdminState extends State<ForoPageAdmin> with RouteAware {
  final Stream<QuerySnapshot> _postsStream =
      FirebaseFirestore.instance.collection('posts').snapshots();
  TextEditingController _searchController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Change color here
        ),
        backgroundColor: Colors.deepPurple,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Foro', style: TextStyle(color: Colors.white)),
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Buscar palabras...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      filled: true,
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: PostList(_postsStream, searchTerm: _searchController.text))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserPostsPageAdmin()),
          );
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}

class PostList extends StatefulWidget {
  final Stream<QuerySnapshot> postStream;
  final String searchTerm;

  // Constructor único con parámetros opcionales
  PostList(this.postStream, {this.searchTerm = ""});

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  void like(Function callBack) {
    this.setState(() {
      callBack();
    });
  }

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
                (!postData['title']
                        .toLowerCase()
                        .contains(widget.searchTerm.toLowerCase()) &&
                    !postData['body']
                        .toLowerCase()
                        .contains(widget.searchTerm.toLowerCase()) &&
                    !postData['subject']
                        .toLowerCase()
                        .contains(widget.searchTerm.toLowerCase()))) {
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
                        backgroundImage: NetworkImage(postData['userImg']),
                      ),
                      title: Text(postData['title']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(postData['subject']),
                          Text(
                            postData['author'],
                            style: TextStyle(
                                color: Colors.blue[200], fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(limitWords(postData['body'], 20)),
                      ),
                    ),
                    Row(
                      children: <Widget>[
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
