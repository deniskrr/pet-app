import 'package:flutter/material.dart';
import 'package:pet_app/model/chat_message.dart';

class ChatMessageWidget extends StatelessWidget {
  final ChatMessage chatMessage;
  final Image senderImage;

  const ChatMessageWidget({
    Key key,
    this.chatMessage,
    this.senderImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment:
      chatMessage.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (chatMessage.sentByMe == false) senderImage,
          Container(
            margin: EdgeInsets.only(top: 10, right: 10),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(15)),
            child: Text(
              chatMessage.message, style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}
