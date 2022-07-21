import 'package:get_it/get_it.dart';

import 'user_repository.dart';

final GetIt getIt = GetIt.instance;

void registerRepositories() {
  getIt.registerLazySingleton<UserRepository>(() => UserRepository());
}

UserRepository get userRepository => getIt<UserRepository>();
