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
}
