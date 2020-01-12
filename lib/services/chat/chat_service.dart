import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ChatService {
  void sendMessage(String toUid, String message);

  Stream<QuerySnapshot> getChatStream(String uid);
}
