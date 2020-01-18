import 'package:flutter/material.dart';
import 'package:pet_app/model/user.dart';
import 'package:pet_app/screens/home/chat/chat_message_input_field.dart';
import 'package:pet_app/screens/home/chat/chat_message_list.dart';
import 'package:pet_app/services/chat/chat_service.dart';
import 'package:pet_app/services/services.dart';

class ChatPage extends StatefulWidget {
  static final String routeName = '/chat';

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatService _chatService = services.get<ChatService>();

  @override
  Widget build(BuildContext context) {
    User correspondent = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(correspondent.username),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(18.0),
        left: false,
        right: false,
        bottom: false,
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ChatMessageList(
                correspondent: correspondent,
                messageStream: _chatService.getChatStream(correspondent.uid),
              ),
              ChatMessageInputField(
                recipientUid: correspondent.uid,
                sendMessageFunction: _chatService.sendMessage,
              )
            ],
          ),
        ),
      ),
    );
  }
}
