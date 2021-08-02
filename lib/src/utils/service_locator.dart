import 'package:get_it/get_it.dart';

import '../api/repository/user_repository.dart';
import '../models/others/user_credential.dart';

final GetIt getIt = GetIt.instance;

void registerLocator() {
  getIt.registerLazySingleton<UserRepository>(() => UserRepository());
  getIt.registerLazySingleton<MemUserCredential>(() => MemUserCredential());
}
