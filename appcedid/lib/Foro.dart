import 'package:flutter/material.dart';

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
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> posts = [];

  void newPost(String text){
    this.setState(() {
      posts.add(new Post(text, "User"));
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title: Text('Foro')), 
    body: Column(children:<Widget>[
      Expanded(child: PostList(this.posts)),
      TextInputWiget(this.newPost)
      ]));
  }
}



class TextInputWiget extends StatefulWidget {
 //  const TextInputWiget({super.key}); // borrar en caso de posible error
  
  final Function(String) callback;

  TextInputWiget(this.callback);

  @override
  State<TextInputWiget> createState() => _TextInputWigetState(); // caso de, usar el code de abajo
  // _TextInputWigetState createState() => _TextInputWigetState();
}

class _TextInputWigetState extends State<TextInputWiget> {
  final controller = TextEditingController();
  

  @override
  void dispose(){
    super.dispose();
    controller.dispose();
  }

  void click(){
    widget.callback(controller.text);  
    FocusScope.of(context).unfocus();
    controller.clear();

  }

  @override
  Widget build(BuildContext context) {
    return
      TextField(
      controller: this.controller,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.message),labelText: 'Escribe un mensaje', 
          suffixIcon: IconButton(icon: Icon(Icons.send),
          splashColor: Colors.blue,
          tooltip: "Publicar",
          onPressed: this.click 
          )));
  }
}
class PostList extends StatefulWidget {
  final  List <Post> listItems;
  PostList(this.listItems);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  void like(Function callBack){
    this.setState(() {
      callBack();
    });

  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount:this.widget.listItems.length ,
      itemBuilder: (context, index) {
        var post = this.widget.listItems[index];
        return Card(child: Row(children: <Widget>[Expanded(child: ListTile(title: Text(post.body), 
          subtitle: Text(post.author),
        )),
        Row(
          children: <Widget>[
            Container(child: Text(post.likes.toString(),
              style: TextStyle(fontSize: 20)),
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),),
            IconButton(icon: Icon(Icons.thumb_up),
            onPressed: () => like(post.likePost),
            color: post.userLiked ? Colors.green: Colors.black
          )
        ],
        )
        ]));
      },
    );
  }
}

