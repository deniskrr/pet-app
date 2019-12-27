import 'package:get_it/get_it.dart';
import 'package:pet_app/services/auth/auth_service.dart';
import 'package:pet_app/services/auth/firebase_auth_service.dart';

final services = GetIt.instance;

void initServices() {
  services.registerLazySingleton<AuthService>(() => FirebaseAuthService());
}
