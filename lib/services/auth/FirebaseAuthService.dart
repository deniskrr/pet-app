import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_app/model/User.dart';
import 'package:pet_app/services/auth/AuthService.dart';

class FirebaseAuthService extends AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<AuthResult> signIn(String email, String password) async {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() {
    return null;
  }

  @override
  Future<AuthResult> signUp(String email, String password) {
    return _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }
}
