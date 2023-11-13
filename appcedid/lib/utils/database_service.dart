import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection('posts');

  Future<void> createPost(String title, String subject, String body,
      String author, String userImg, DateTime time) {
    return postCollection.add({
      'title': title,
      'subject': subject,
      'body': body,
      'author': author,
      'userImg': userImg,
      'time': time,
      'likes': 0,
      'userLikes': [],
    });
  }

  Future<void> updatePost(
      String id, String title, String subject, String body) {
    return postCollection.doc(id).update({
      'title': title,
      'subject': subject,
      'body': body,
    });
  }

  Future<void> deletePost(String id) {
    return postCollection.doc(id).delete();
  }

  Future<void> likePost(String postId, String userId) {
    return postCollection.doc(postId).update({
      'likes': FieldValue.increment(1),
      'userLikes': FieldValue.arrayUnion([userId]),
    });
  }

  Future<void> unlikePost(String postId, String userId) {
    return postCollection.doc(postId).update({
      'likes': FieldValue.increment(-1),
      'userLikes': FieldValue.arrayRemove([userId]),
    });
  }

  Future<void> addComment(
      String postId, String author, String content, DateTime time) async {
    await FirebaseFirestore.instance.collection('comments').add({
      'postId': postId,
      'author': author,
      'content': content,
      'timestamp': Timestamp.fromDate(time),
    });
    // No se devuelve nada, por lo que la función cumple con el tipo de retorno Future<void>
  }

  // Obtener comentarios de un foro en tiempo real
  Stream<QuerySnapshot> getComments(String postId) {
    return FirebaseFirestore.instance
        .collection('comments')
        .where('postId', isEqualTo: postId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
