import 'package:get_it/get_it.dart';
import 'package:pet_app/services/auth/auth_service.dart';
import 'package:pet_app/services/auth/firebase_auth_service.dart';
import 'package:pet_app/services/storage/firebase_storage_service.dart';
import 'package:pet_app/services/storage/storage_service.dart';
import 'package:pet_app/services/user/firebase_user_service.dart';
import 'package:pet_app/services/user/user_service.dart';

final services = GetIt.instance;

void initServices() {
  services.registerLazySingleton<UserService>(() => FirebaseUserService());
  services.registerLazySingleton<AuthService>(() => FirebaseAuthService());
  services
      .registerLazySingleton<StorageService>(() => FirebaseStorageService());
}
