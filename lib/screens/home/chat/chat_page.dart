import 'package:flutter/material.dart';
import 'package:pet_app/model/chat_message.dart';
import 'package:pet_app/screens/home/chat/chat_message_list.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final messageList = [
    ChatMessage(message: "Lmao", sentByMe: true),
    ChatMessage(message: "Lmao2", sentByMe: true),
    ChatMessage(message: "Lmao3", sentByMe: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ChatMessageList(
          messages: messageList,
        )
      ],
    );
  }
}
