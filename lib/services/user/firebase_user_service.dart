import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_app/model/user.dart';
import 'package:pet_app/services/user/user_service.dart';

class FirebaseUserService extends UserService {
  final Firestore _firestore = Firestore.instance;

  @override
  Future<User> createUser(String email, String uid) async {
    User newUser = User(email, uid);

    await _firestore
        .collection("users")
        .document(uid)
        .setData(newUser.toJson());
    return newUser;
  }
}
