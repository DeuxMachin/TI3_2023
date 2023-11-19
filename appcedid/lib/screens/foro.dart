import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'newPostForm.dart';
import 'post.dart';
import 'respuestaForo.dart';
import 'package:ti3/main.dart';
import 'package:ti3/screens/HomeSi.dart';

class ForoPage extends StatefulWidget {
  @override
  _ForoPageState createState() => _ForoPageState();
}

class _ForoPageState extends State<ForoPage> with RouteAware {
  int currentIndex = 4;

  final Stream<QuerySnapshot> _postsStream =
      FirebaseFirestore.instance.collection('posts').snapshots();
  TextEditingController _searchController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    setState(() {
      currentIndex = 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 235, 250, 151),
        automaticallyImplyLeading: false, //Remove back arrow

        title: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // Alinea los elementos en los extremos
          children: [
            Text('Foro', style: TextStyle(color: Colors.black)), // Título
            Padding(
              padding: const EdgeInsets.all(8.0),
            ),
            Container(
              width: 300, // Ajusta el ancho según sea necesario

              decoration: BoxDecoration(
                color: Colors.white, // Fondo blanco
                borderRadius: BorderRadius.circular(30), // Bordes redondeados
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {});
                },
                textAlign: TextAlign.center, // Centrar el texto
                decoration: InputDecoration(
                  hintText: 'Buscar palabras...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  filled: true,
                  prefixIcon:
                      Icon(Icons.search, color: Colors.grey), // Ícono de lupa
                ),
              ),
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
            MaterialPageRoute(builder: (context) => NewPostForm()),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Color.fromRGBO(56, 84, 232, 1),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        iconSize: 32,
        selectedItemColor: Colors.purple,
        selectedFontSize: 18,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex, // Establece el índice actual
        onTap: (index) {
          // Verifica si el índice está dentro del rango válido
          if (index >= 0 && index < pages.length) {
            // Cambia de página al tocar un ícono en el BottomNavigationBar
            setState(() {
              currentIndex = index;
            });

            // Navega a la página correspondiente utilizando Navigator
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => pages[currentIndex]),
            );
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Agendar'),
          BottomNavigationBarItem(icon: Icon(Icons.flutter_dash), label: 'Bot'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Cuenta'),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: 'Foro'),
        ],
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

  @override
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
                !post.body
                    .toLowerCase()
                    .contains(widget.searchTerm.toLowerCase())) {
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
                        child: Text(limitWords(post.body, 20)),
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
