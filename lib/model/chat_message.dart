import 'package:flutter/material.dart';

class ChatMessage {
  final String message;
  final bool sentByMe;
  final bool read;

  ChatMessage({
    @required this.message,
    @required this.sentByMe,
    this.read = true,
  });
}
