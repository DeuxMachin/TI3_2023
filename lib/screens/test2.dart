import 'package:flutter/material.dart';
import 'post.dart';
import 'package:intl/intl.dart';
import 'perfil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
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
  List<Map<String, dynamic>> comments =
      []; // Lista para almacenar los comentarios
  final TextEditingController _commentController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    posts.add(widget.post);
    _loadComments();
  }

  Future<void> _loadComments() async {
    QuerySnapshot commentSnapshot = await _firestore
        .collection('posts')
        .doc(widget.post.id)
        .collection('comments')
        .orderBy('timestamp', descending: false)
        .get();

    // Utilizamos un mapa temporal para almacenar los comentarios junto con sus ID
    List<Map<String, dynamic>> retrievedComments =
        commentSnapshot.docs.map((doc) {
      return {
        'commentId': doc.id, // Guarda el ID del documento
        ...doc.data()
            as Map<String, dynamic>, // Incluye los otros datos del comentario
      };
    }).toList();

    setState(() {
      comments = retrievedComments;
    });
  }

  Future<void> _sendComment() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null && _commentController.text.isNotEmpty) {
      // Proporcionar una URL de imagen por defecto si currentUser.photoURL es null
      String userImageUrl = currentUser.photoURL ?? 'URL_de_imagen_por_defecto';

      // Agregar el comentario a la subcolección 'comments' de la publicación
      await _firestore
          .collection('posts')
          .doc(widget.post.id)
          .collection('comments')
          .add({
        'nombre': currentUser.displayName ?? 'Anónimo',
        'userImageUrl': userImageUrl,
        'texto': _commentController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      _commentController.clear();
      await _loadComments();
    }
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
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                PostList(this.posts),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    var comment = comments[index];
                    String nombreCorto = (comment['nombre'] as String).length >
                            15
                        ? (comment['nombre'] as String).substring(0, 15) + '...'
                        : comment['nombre'];

                    return Card(
                      color:
                          Colors.lightBlue[50], // Color de fondo de la tarjeta
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(comment['userImageUrl']),
                                  radius: 20,
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        nombreCorto,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        DateFormat('dd MMM yyyy').format(
                                            comment['timestamp'].toDate()),
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuButton<String>(
                                  onSelected: (String value) async {
                                    if (value == 'Eliminar') {
                                      User? currentUser =
                                          FirebaseAuth.instance.currentUser;
                                      Map<String, dynamic> selectedComment =
                                          comments[index];

                                      // Comprueba si el usuario actual es el autor del comentario
                                      if (currentUser != null &&
                                          selectedComment['nombre'] ==
                                              currentUser.displayName) {
                                        try {
                                          // Usa el ID del documento para eliminar el comentario de Firestore
                                          await _firestore
                                              .collection('posts')
                                              .doc(widget.post.id)
                                              .collection('comments')
                                              .doc(selectedComment['commentId'])
                                              .delete();

                                          // Actualiza el estado para reflejar la eliminación inmediatamente
                                          setState(() {
                                            comments.removeAt(index);
                                          });

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    "Comentario eliminado")),
                                          );
                                        } catch (e) {
                                          print(
                                              "Error al eliminar el comentario: $e");
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    "No se pudo eliminar el comentario")),
                                          );
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  "Solo puedes eliminar tus propios comentarios")),
                                        );
                                      }
                                    }
                                  },
                                  itemBuilder: (BuildContext context) => [
                                    PopupMenuItem<String>(
                                      value: 'Editar',
                                      child: Text('Editar'),
                                    ),
                                    PopupMenuItem<String>(
                                      value: 'Eliminar',
                                      child: Text('Eliminar'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              comment['texto'],
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      labelText: 'Escribe un comentario...',
                      border: OutlineInputBorder(),
                      fillColor: Colors.lightBlue[50],
                      filled: true,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    await _sendComment();
                    setState(() {
                      _commentController.clear();
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
