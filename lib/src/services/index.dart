import 'package:flutter_boilerplate/src/services/auth_service.dart';
import 'package:flutter_boilerplate/src/services/social_auth_service.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void registerServices() {
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<SocialAuthService>(() => SocialAuthService());
}

AuthService get authService => getIt<AuthService>();
SocialAuthService get socialAuthService => getIt<SocialAuthService>();
