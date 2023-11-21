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
}
