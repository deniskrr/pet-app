import 'package:flutter/material.dart';
import 'package:pet_app/screens/home/chat/chat_message_input_field.dart';
import 'package:pet_app/screens/home/chat/chat_message_list.dart';
import 'package:pet_app/services/chat/chat_service.dart';
import 'package:pet_app/services/services.dart';

class ChatPage extends StatefulWidget {
  final String recipientUid;

  const ChatPage({Key key, @required this.recipientUid}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatService _chatService = services.get<ChatService>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ChatMessageList(
          messageStream: _chatService.getChatStream(widget.recipientUid),
        ),
        ChatMessageInputField(
          recipientUid: widget.recipientUid,
          sendMessageFunction: _chatService.sendMessage,
        )
      ],
    );
  }
}
