import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

class ChatMessage extends StatelessWidget {
  final String message;
  final bool isSender;

  ChatMessage(this.message, this.isSender);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: BubbleSpecialThree(
        text: message,
        color: isSender ? Color(0xFF1B97F3) : Color(0xFFE8E8EE),
        tail: true,
        textStyle: isSender
            ? TextStyle(color: Colors.white, fontSize: 16)
            : TextStyle(color: Colors.black, fontSize: 16),
        isSender: this.isSender,
      ),
    );
  }
}
