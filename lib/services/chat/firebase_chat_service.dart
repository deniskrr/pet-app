import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_app/model/chat_message.dart';
import 'package:pet_app/model/user.dart';
import 'package:pet_app/services/auth/auth_service.dart';
import 'package:pet_app/services/chat/chat_service.dart';
import 'package:pet_app/services/services.dart';
import 'package:pet_app/services/user/user_service.dart';

class FirebaseChatService extends ChatService {
  final Firestore _firestore = Firestore.instance;
  final AuthService _authService = services.get<AuthService>();
  final UserService _userService = services.get<UserService>();
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

    //add current user to other's conversation
    User toUser=await _userService.getUser(toUid);
    if(!toUser.conversations.contains(_authService.currentUserUid)){
      toUser.conversations.add(_authService.currentUserUid);
    }
    _userService.updateUser(toUser);

    //add other user to current one's conversation
    User currentUser = await _userService.getUser(
        _authService.currentUserUid);
    if (!currentUser.conversations.contains(
        toUid)) {
      currentUser.conversations.add(toUid);
    }
    _userService.updateUser(currentUser);

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

  @override
  Future<List<User>> getChattedUsers() async {

    User currentUser = await _userService.getUser(_authService.currentUserUid);
    List<User> users = List();
    for (var i = 0; i < currentUser.conversations.length; i++) {
      users.add(await _userService.getUser(currentUser.conversations[i]));
    }
    return users;
  }



  @override
  Future<ChatMessage> getFirstMessage(String recipientUid) async {
    final querySnapshot = await _firestore
        .collection("chats")
        .document(_authService.currentUserUid)
        .collection(recipientUid)
        .orderBy("date_sent", descending: true)
        .getDocuments();

    List<ChatMessage> messages = querySnapshot.documents
        .map((document) => ChatMessage.fromDocumentSnapshot(document))
        .toList();

    return messages[0];
  }

}
