import 'package:flutter/material.dart';
import 'foro.dart';

void main() {
  runApp(const MyApp());
}

class Post{
  String body;
  String author;
  int likes= 0;
  bool userLiked = false;

  Post (this.body, this.author);


  void likePost (){
    this.userLiked = !this.userLiked;
    if(this.userLiked){
      this.likes +=1;
    }else{
      this.likes -=1;
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foro',
      theme: ThemeData(
        primarySwatch: Colors.amber,      
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: foro(),
    );
  }
}






