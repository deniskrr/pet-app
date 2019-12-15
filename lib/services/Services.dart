import 'package:get_it/get_it.dart';
import 'package:pet_app/services/auth/AuthService.dart';
import 'package:pet_app/services/auth/FirebaseAuthService.dart';

final services = GetIt.instance;

void initServices() {
  services.registerLazySingleton<AuthService>(() => FirebaseAuthService());
}
