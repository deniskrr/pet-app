import 'package:flutter/material.dart';
import 'package:pet_app/model/chat_message.dart';
import 'package:pet_app/widgets/chat_message_widget.dart';

class ChatMessageList extends StatelessWidget {
  final List<ChatMessage> messages;
  final ScrollController _scrollController = ScrollController(
      initialScrollOffset: 0);

  ChatMessageList({Key key, this.messages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        reverse: true,
        controller: _scrollController,
        itemCount: messages.length,
        itemBuilder: (_, index) {
          return ChatMessageWidget(
            chatMessage: messages[index],
          );
        },
      ),
    );
  }
}
