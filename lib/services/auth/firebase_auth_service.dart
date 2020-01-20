import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_app/services/auth/auth_service.dart';

class FirebaseAuthService extends AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<AuthResult> signIn(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    currentUserUid = result.user.uid;
    return result;
  }

  @override
  Future<void> signOut() {
    currentUserUid = null;
    return _auth.signOut();
  }

  @override
  Future<AuthResult> signUp(String email, String password) async {
    final result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    currentUserUid = result.user.uid;
    return result;
  }

  @override
  Future<bool> isUserLoggedIn() async {
    final currentUser = await _auth.currentUser();
    currentUserUid = currentUser?.uid; // update the field used in-app
    return currentUser != null;
  }
}
