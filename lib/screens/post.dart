import 'package:cloud_firestore/cloud_firestore.dart';

Future<DocumentSnapshot> getUserData(String userId) async {
  return await FirebaseFirestore.instance.collection('users').doc(userId).get();
}

class Post {
  String id;

  String title;
  String subject = '';
  String body;
  String author;
  String userImg;
  DateTime time;
  int likes = 0;

  bool userLiked = false;
  Post(this.id, this.title, this.body, this.author, this.userImg, this.time);
  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      doc.id, // Aquí se asigna el id del documento a la propiedad id de Post
      doc['title'],
      doc['body'],
      doc['author'],
      doc['userImg'],
      doc['time']
          .toDate(), // Asegúrate de que 'time' se convierta correctamente a DateTime
    );
  }
}
