import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {
 //  const TextInputWidget({super.key}); // borrar en caso de posible error
  
  final Function(String) callback;

  TextInputWidget(this.callback);

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState(); // caso de, usar el code de abajo
  // _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
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