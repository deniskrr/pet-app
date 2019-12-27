import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  String currentUserUid;

  Future<void> signOut();

  Future<AuthResult> signIn(String email, String password);

  Future<AuthResult> signUp(String email, String password);
}