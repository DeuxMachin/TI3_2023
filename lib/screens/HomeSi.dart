import 'package:flutter/material.dart';
import 'package:ti3/main.dart';
import 'package:ti3/screens/Cursos/DocenciaLinea.dart';
import 'package:ti3/screens/agendar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ti3/screens/chatbot.dart';
import 'package:ti3/screens/perfil.dart';
import 'package:ti3/screens/foro.dart';
import 'package:ti3/screens/Cursos/cursos.dart';
import 'package:ti3/screens/Cursos/ModeloEduca.dart';
import 'package:ti3/screens/Cursos/EducaBlack.dart';
import 'package:ti3/screens/Cursos/HyFlex.dart';
import 'package:ti3/screens/Cursos/ImpulsaTuRed.dart';
import 'package:ti3/utils/authentication.dart';
import 'package:ti3/screens/login.dart';

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
  PerfilPage(),
  ForoPage()
];

List<String> catUrls = [
  // Links para los URLs
  'https://educa.blackboard.com',
  'https://estudiantes.uct.cl',
  'https://directorio.uct.cl',
  'https://www.uct.cl',
  'https://www.uct.cl/calendario-academico/',
  'https://dte.uct.cl',
];
void launchURL(int index) async {
  Uri url = Uri.parse(catUrls[index]);
  try {
    await launch(url.toString());
  } catch (e) {
    throw 'No se pudo lanzar $url';
  }
}

class _HomePageState extends State<HomePage> with RouteAware {
  int currentIndex = 0;
  List imgList = [
    'Virtualiza',
    'mei',
    'DocenciaOnline',
    'IntroduccionaEducaBlackboard',
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
            decoration: const BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.dashboard,
                      size: 30,
                      color: Colors.white,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.logout,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Authentication.logout();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login', (Route<dynamic> route) => false);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                const Padding(
                  padding: EdgeInsets.only(left: 3, bottom: 15),
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
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              children: [
                GridView.builder(
                  itemCount: catNames.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            launchURL(index); // Pasa el índice aquí
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: catColors[index],
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: catIcon[index],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          catNames[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 51, 51, 51),
                          ),
                        ),
                      ],
                    );
                  },
                ),
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
                    Text(
                      "Ver todo",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
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
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Cuenta'),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: 'Foro'),
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
