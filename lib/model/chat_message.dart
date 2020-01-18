import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessage {
  final String message;
  final bool sentByMe;

  ChatMessage({
    @required this.message,
    @required this.sentByMe,
  });

  Map<String, dynamic> toJson() =>
      {
        'message': message,
        'sent_by_me': sentByMe,
        'date_sent': DateTime.now(),
      };

  ChatMessage.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        sentByMe = json['sent_by_me'];

  ChatMessage.fromDocumentSnapshot(DocumentSnapshot snapshot)
      : message = snapshot.data['message'],
        sentByMe = snapshot.data['sent_by_me'];
}
