import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/model/chat_message.dart';
import 'package:pet_app/widgets/chat_message_widget.dart';

class ChatMessageList extends StatelessWidget {
  final Stream<QuerySnapshot> messageStream;
  final _scrollController = ScrollController(initialScrollOffset: 0);

  ChatMessageList({Key key, this.messageStream}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: messageStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Timer(
              Duration(milliseconds: 1),
                  () =>
                  _scrollController.animateTo(
                    _scrollController.position.minScrollExtent,
                    curve: Curves.easeOut,
                    duration: Duration(milliseconds: 100),
                  ),
            );

            return ListView.builder(
              reverse: true,
              shrinkWrap: true,
              controller: _scrollController,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (_, index) {
                return ChatMessageWidget(
                  chatMessage:
                  ChatMessage.fromJson(snapshot.data.documents[index].data),
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
