import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_app/model/chat_message.dart';
import 'package:pet_app/services/auth/auth_service.dart';
import 'package:pet_app/services/chat/chat_service.dart';
import 'package:pet_app/services/services.dart';

class FirebaseChatService extends ChatService {
  final Firestore _firestore = Firestore.instance;
  final AuthService _authService = services.get<AuthService>();

  @override
  void sendMessage(String toUid, String message) async {
    ChatMessage myChatMessage = ChatMessage(
      message: message,
      sentByMe: true,
    );

    ChatMessage recipientChatMessage = ChatMessage(
      message: message,
      sentByMe: false,
    );

    await _firestore
        .collection("chats")
        .document(_authService.currentUserUid)
        .collection(toUid)
        .add(myChatMessage.toJson());

    await _firestore
        .collection("chats")
        .document(toUid)
        .collection(_authService.currentUserUid)
        .add(recipientChatMessage.toJson());
  }

  @override
  Stream<QuerySnapshot> getChatStream(String uid) {
    return _firestore
        .collection("chats")
        .document(_authService.currentUserUid)
        .collection(uid)
        .orderBy("date_sent", descending: true)
        .snapshots();
  }
}