import 'dart:async';

import 'package:flutter/material.dart';
import 'chatmessage.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatMessage> messages = [];
  ScrollController _scrollController = ScrollController();

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
        title: Text("ChatBOT CEDID", style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color.fromARGB(255, 235, 250, 151),
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(width: 10),
                SizedBox(
                  width: 120,
                  height: 120,
                  child: FloatingActionButton(
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
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
