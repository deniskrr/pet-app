import 'package:pet_app/model/user.dart';

abstract class UserService {
  Future<User> createUser(String email, String uid);
}
