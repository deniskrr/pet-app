import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_app/model/user.dart';
import 'package:pet_app/services/user/user_service.dart';

class FirebaseUserService extends UserService {
  final Firestore _firestore = Firestore.instance;

  @override
  Future<User> createUser(String email, String username, String uid) async {
    User newUser = User(email, username, uid);

    await _firestore
        .collection("users")
        .document(uid)
        .setData(newUser.toJson());
    return newUser;
  }

  @override
  Future<User> getUser(String uid) async {
    final snapshot = await _firestore.collection("users").document(uid).get();
    if (snapshot != null) {
      return User.fromJson(snapshot.data);
    }
    return null;
  }

  @override
  Future<User> updateUser(User updatedUser) async {
    await _firestore
        .collection("users")
        .document(updatedUser.uid)
        .setData(updatedUser.toJson());
    return updatedUser;
  }
}
