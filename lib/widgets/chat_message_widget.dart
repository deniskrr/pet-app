import 'package:flutter/material.dart';
import 'package:pet_app/model/chat_message.dart';

class ChatMessageWidget extends StatelessWidget {
  final ChatMessage chatMessage;
  final Image senderImage;

  const ChatMessageWidget({
    Key key,
    this.chatMessage,
    this.senderImage = null,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(chatMessage.message),
        ],
      ),
    );
  }
}
