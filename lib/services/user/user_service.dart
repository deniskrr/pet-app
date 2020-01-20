import 'package:pet_app/model/user.dart';

abstract class UserService {
  Future<User> createUser(String email, String username, String uid);

  Future<User> getUser(String uid);

  Future<User> updateUser(User updatedUser);

  Future<List<User>> getPetSitters();
}
