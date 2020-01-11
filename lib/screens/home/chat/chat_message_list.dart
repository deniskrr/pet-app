import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/model/chat_message.dart';
import 'package:pet_app/widgets/chat_message_widget.dart';

class ChatMessageList extends StatelessWidget {
  final Stream<QuerySnapshot> messageStream;
  final ScrollController _scrollController =
  ScrollController(initialScrollOffset: 0);

  ChatMessageList({Key key, this.messageStream}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: messageStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              reverse: true,
              controller: _scrollController,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (_, index) {
                return ChatMessageWidget(
                  chatMessage: ChatMessage.fromJson(
                      snapshot.data.documents[index].data),
                );
              },
            );
          }
          return Center(
            child: Text("Start a conversation"),
          );
        },
      ),
    );
  }
}
