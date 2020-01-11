import 'package:flutter/material.dart';
import 'package:pet_app/model/chat_message.dart';
import 'package:pet_app/widgets/chat_message_widget.dart';

class ChatMessageList extends StatelessWidget {
  final List<ChatMessage> messages;

  const ChatMessageList({Key key, this.messages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: messages
            .map((message) => ChatMessageWidget(
                  chatMessage: message,
                ))
            .toList());
  }
}
