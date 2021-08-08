import 'package:get_it/get_it.dart';

import '../api/repository/user_repository.dart';

final GetIt getIt = GetIt.instance;

void registerLocator() {
  getIt.registerLazySingleton<UserRepository>(() => UserRepository());
}
