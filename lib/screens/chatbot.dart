import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ti3/main.dart';
import 'chatmessage.dart';
import 'HomeSi.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with RouteAware {
  List<ChatMessage> messages = [];
  ScrollController _scrollController = ScrollController();
  ScrollController _buttonScrollController = ScrollController();
  int currentIndex = 2;

  void addMessage(String message, bool isSender) {
    setState(() {
      messages.add(ChatMessage(message, isSender));
    });

    Timer(Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 750),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //Remove back arrow
        title: Text("ChatBOT CEDID", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatMessage(
                    messages[index].message, messages[index].isSender);
              },
            ),
          ),
          SizedBox(height: 10),
          ScrollArrows(
            scrollController: _buttonScrollController,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _buttonScrollController,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(width: 10),
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: FloatingActionButton(
                      backgroundColor: Colors.indigo,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      onPressed: () {
                        String question =
                            "¿Cómo me puedo contactar con un asistente?";
                        addMessage(question, true);
                        String response =
                            "Acceda al perfil del asistente que desea contactar en el menú correspondiente de asistentes para mostrar su información de contacto.";
                        addMessage(response, false);
                      },
                      child: Text(
                        "¿Cómo me puedo contactar con un asistente?",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: FloatingActionButton(
                      backgroundColor: Colors.indigo,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      onPressed: () {
                        String question =
                            "¿Cuales son los horarios de atención en la oficina?";
                        addMessage(question, true);
                        String response =
                            "Los horarios de atención son desde las 15:00 hasta las 18:00.";
                        addMessage(response, false);
                      },
                      child: Text(
                        "¿Cuales son los horarios de atención en la oficina?",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: FloatingActionButton(
                      backgroundColor: Colors.indigo,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      onPressed: () {
                        String question = "¿Dónde está la oficina del CEDID?";
                        addMessage(question, true);
                        String response =
                            "La oficina del CEDID está ubicada en el edificio CJP07 en el segundo piso.";
                        addMessage(response, false);
                      },
                      child: Text(
                        "¿Dónde está la oficina del CEDID?",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: FloatingActionButton(
                      backgroundColor: Colors.indigo,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      onPressed: () {
                        String question = "¿Qué cursos están disponibles?";
                        addMessage(question, true);
                        String response =
                            "Acceda a la sección de Cursos para ver una lista completa de los cursos disponibles en el momento.";
                        addMessage(response, false);
                      },
                      child: Text(
                        "¿Qué cursos están disponibles?",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: FloatingActionButton(
                      backgroundColor: Colors.indigo,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      onPressed: () {
                        String question =
                            "¿Se requiere de otros datos para acceder al foro?";
                        addMessage(question, true);
                        String response =
                            "No es necesario otros datos más de los que tiene usted en la cuenta registrada en el sistema.";
                        addMessage(response, false);
                      },
                      child: Text(
                        "¿Se requiere de otros datos para acceder al foro?",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
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
      currentIndex = 2;
    });
  }
}

//Base Widget for the arrows that show on the left or right of the question boxes
class ScrollArrows extends StatefulWidget {
  final ScrollController scrollController;
  final Widget child;

  const ScrollArrows({
    Key? key,
    required this.scrollController,
    required this.child,
  }) : super(key: key);

  @override
  _ScrollArrowsState createState() => _ScrollArrowsState();
}

//State to show the left, right or both arrows
class _ScrollArrowsState extends State<ScrollArrows> {
  bool _showLeftArrow = false;
  bool _showRightArrow = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_updateArrows);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateArrows());
  }

  //Remove
  @override
  void dispose() {
    widget.scrollController.removeListener(_updateArrows);
    super.dispose();
  }

  //Update when scroll event happens
  void _updateArrows() {
    bool showLeft = widget.scrollController.offset > 0;
    bool showRight = widget.scrollController.offset <
        widget.scrollController.position.maxScrollExtent;

    if (showLeft != _showLeftArrow || showRight != _showRightArrow) {
      setState(() {
        _showLeftArrow = showLeft;
        _showRightArrow = showRight;
      });
    }
  }

  //Show or hide arrows
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        widget.child,
        if (_showLeftArrow)
          Positioned(
            left: 0,
            child: Icon(Icons.arrow_back_ios, size: 24),
          ),
        if (_showRightArrow)
          Positioned(
            right: 0,
            child: Icon(Icons.arrow_forward_ios, size: 24),
          ),
      ],
    );
  }
}
