import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ti3/main.dart';
import 'package:ti3/screens/Cursos/DocenciaLinea.dart';
import 'package:ti3/screens/agendar.dart';
import 'package:ti3/screens/chatbot.dart';
import 'package:ti3/screens/foro.dart';
import 'package:ti3/screens/Cursos/cursos.dart';
import 'package:ti3/screens/Cursos/ModeloEduca.dart';
import 'package:ti3/screens/Cursos/EducaBlack.dart';
import 'package:ti3/screens/Cursos/HyFlex.dart';
import 'package:ti3/screens/Cursos/ImpulsaTuRed.dart';
import 'package:ti3/utils/authentication.dart';
import 'package:ti3/screens/home.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

List catNames = [
  "Blackboard",
  'Portal',
  'Glosario',
  'UCT',
  'Calendario',
  'CINAP',
];
List<Color> catColors = [
  const Color(0xFFFFCF2F),
  const Color(0xFF6FE08D),
  const Color(0xFF61BDFD),
  const Color(0xFFFC7F7F),
  Color.fromARGB(255, 255, 255, 255),
  const Color(0XFF78E667),
];

List<Widget> catIcon = [
  Image.asset(
    'assets/blackboard.png', // Ruta de la imagen en la carpeta de assets
    width: 30, // Ancho de la imagen
    height: 30, // Alto de la imagen
  ),
  Image.asset(
    'assets/portal.png', // Ruta de la imagen en la carpeta de assets
    width: 80, // Ancho de la imagen
    height: 80, // Alto de la imagen
  ),
  Image.asset(
    'assets/directorio.png', // Ruta de la imagen en la carpeta de assets
    width: 50, // Ancho de la imagen
    height: 50, // Alto de la imagen
  ),
  Image.asset(
    'assets/Logo_UCT.png', // Ruta de la imagen en la carpeta de assets
    width: 30, // Ancho de la imagen
    height: 30, // Alto de la imagen
  ),
  Image.asset(
    'assets/calendario.png', // Ruta de la imagen en la carpeta de assets
    width: 90, // Ancho de la imagen
    height: 90, // Alto de la imagen
  ),
  Image.asset(
    'assets/Logo_UCT.png', // Ruta de la imagen en la carpeta de assets
    width: 30, // Ancho de la imagen
    height: 30, // Alto de la imagen
  ),
];

final cursos = [
  Cursospage(),
  ModeloEduca(),
  DocenciaLinea(),
  EducaBlack(),
  ImpulsaRed(),
  HyFlex()
]; // Para rutas de los cursos a trabajar.

final pages = [
  //Para las rutas del navbar.
  HomePage(),
  AgendarPage(),
  ChatPage(),
  ForoPage()
];

class _HomePageState extends State<HomePage> with RouteAware {
  int currentIndex = 0;
  User? loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    loggedInUser = FirebaseAuth.instance.currentUser;
    print("Photo URL: ${loggedInUser?.photoURL}");
    setState(() {});
  }

  List imgList = [
    'Virtualiza',
    'mei',
    'DocenciaOnline',
    'educa',
    'ImpulsaTuRed',
    'Hyflex',
  ];

  List nameList = [
    'Virtualiza',
    'Modelo institucional',
    'Docencia online',
    'Educa blackboard',
    'Impulsa Tu Red',
    'HyFlex',
  ];
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(30), // Padding aumentado
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "CINAP UCT",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          wordSpacing: 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.logout, size: 30, color: Colors.white),
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (Route<dynamic> route) => false,
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 25), // Espacio debajo del título
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                    loggedInUser?.photoURL ?? 'url_de_imagen_predeterminada',
                  ),
                ),
                const SizedBox(
                    height: 10), // Espacio debajo de la imagen del usuario
                Text(
                  loggedInUser?.displayName ?? 'Nombre no disponible',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10), // Espacio adicional si es necesario
                Text(
                  loggedInUser?.email ?? 'Correo no disponible',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 201, 199, 199),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Cursos",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                GridView.builder(
                  itemCount: imgList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio:
                        (MediaQuery.of(context).size.height - 50 - 25) /
                            (4 * 240),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => cursos[index]));
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 214, 213, 213),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Image.asset(
                                "assets/${imgList[index]}.png",
                                width: 150,
                                height: 80,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              nameList[index],
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: const Color.fromARGB(255, 37, 37, 37),
                              ),
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
        ],
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
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: 'Foro')
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    // User swiped back to this page, so we update the currentIndex
    setState(() {
      currentIndex = 0;
    });
  }
}
