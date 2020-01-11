import 'package:flutter/material.dart';
import 'package:pet_app/model/chat_message.dart';
import 'package:pet_app/screens/home/chat/chat_message_list.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  @override
  Widget build(BuildContext context) {
    final messageList = [
      ChatMessage(message: "Lmao", sentByMe: true),
      ChatMessage(
          message: "Lmadsadsadsadsadsadsadsadasdsadsadsadasdsadsadasdsadsadasdasdo2",
          sentByMe: true),
      ChatMessage(
          message: "Lmadsadsadsadsadsadsadsadasdsadsadsadasdsadsadasdsadsadasdasdo2",
          sentByMe: false),
    ];
    return Column(
      children: <Widget>[
        ChatMessageList(
          messages: messageList,
        )
      ],
    );
  }
}
