import 'package:cloud_firestore/cloud_firestore.dart';

Future<DocumentSnapshot> getUserData(String userId) async {
  return await FirebaseFirestore.instance.collection('users').doc(userId).get();
}

class Post {
  String title;
  String subject;
  String body;
  String author;
  String userImg;
  DateTime time;
  int likes = 0;
  bool userLiked = false;

  Post(this.title, this.subject, this.body, this.author, this.userImg,
      this.time);

  void likePost() {
    this.userLiked = !this.userLiked;
    if (this.userLiked) {
      this.likes += 1;
    } else {
      this.likes -= 1;
    }
  }
}
