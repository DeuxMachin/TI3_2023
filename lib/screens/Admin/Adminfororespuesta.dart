import 'package:flutter/material.dart';
import 'package:ti3/screens/post.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostListAdmin extends StatefulWidget {
  final List<Post> listItems;
  PostListAdmin(this.listItems);

  @override
  State<PostListAdmin> createState() => _PostListStateAdmin();
}

class _PostListStateAdmin extends State<PostListAdmin> {
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
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(post.body),
                ),
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
    _commentsStream();
  }

  Stream<List<Map<String, dynamic>>> _commentsStream() {
    return _firestore
        .collection('posts')
        .doc(widget.post.id)
        .collection('comments')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'commentId': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
    });
  }

// Función para editar comentarios

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
      await _commentsStream();
    }
  }

  void _showDeleteCommentDialog(BuildContext context, int commentIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmar"),
          content:
              Text("¿Estás seguro de que deseas eliminar este comentario?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Eliminar', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                Navigator.of(context).pop();
                _deleteComment(commentIndex);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteComment(int commentIndex) async {
    try {
      var commentsSnapshot = await _firestore
          .collection('posts')
          .doc(widget.post.id)
          .collection('comments')
          .orderBy('timestamp', descending: false)
          .get();

      Map<String, dynamic> selectedComment =
          commentsSnapshot.docs[commentIndex].data();

      await _firestore
          .collection('posts')
          .doc(widget.post.id)
          .collection('comments')
          .doc(commentsSnapshot.docs[commentIndex].id)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Comentario eliminado")),
      );
    } catch (e) {
      print("Error al eliminar el comentario: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No se pudo eliminar el comentario")),
      );
    }
  }

  void _showEditCommentDialog(
      BuildContext context, Map<String, dynamic> comment) {
    TextEditingController _editCommentController =
        TextEditingController(text: comment['texto']);
    GlobalKey<FormState> _formKey =
        GlobalKey<FormState>(); // Clave para el formulario

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Editar Comentario"),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _editCommentController,
              decoration: InputDecoration(
                hintText: "Escribe tu comentario aquí",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'El comentario no puede estar vacío';
                }
                return null;
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Guardar"),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).pop();
                  _updateComment(
                      comment['commentId'], _editCommentController.text);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateComment(String commentId, String newText) async {
    try {
      await _firestore
          .collection('posts')
          .doc(widget.post.id)
          .collection('comments')
          .doc(commentId)
          .update({'texto': newText});

      await _commentsStream(); // Recargar los comentarios para reflejar los cambios
    } catch (e) {
      print("Error al editar el comentario: $e");
      // Mostrar algún mensaje de error si es necesario
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Foro de respuestas', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                PostListAdmin(this.posts),
                StreamBuilder<List<Map<String, dynamic>>>(
                  stream: _commentsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                          child: Text("Error al cargar comentarios."));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text("Aún no hay comentarios."));
                    }
                    var comments = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        var comment = comments[index];
                        String nombreCorto =
                            (comment['nombre'] as String).length > 15
                                ? (comment['nombre'] as String)
                                        .substring(0, 15) +
                                    '...'
                                : comment['nombre'];

                        User? currentUser = FirebaseAuth.instance.currentUser;
                        bool isCommentOwner = currentUser != null &&
                            currentUser.displayName == comment['nombre'];

                        return Card(
                          color: Colors
                              .lightBlue[50], // Color de fondo de la tarjeta
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                                          _showDeleteCommentDialog(
                                              context, index);
                                        } else if (value == 'Editar') {
                                          _showEditCommentDialog(
                                              context, comments[index]);
                                        }
                                      },
                                      itemBuilder: (BuildContext context) => [
                                        PopupMenuItem<String>(
                                          value: 'Editar',
                                          child: Text('Editar'),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'Eliminar',
                                          child: Text('Eliminar',
                                              style:
                                                  TextStyle(color: Colors.red)),
                                        ),
                                      ],
                                    ),
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
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
