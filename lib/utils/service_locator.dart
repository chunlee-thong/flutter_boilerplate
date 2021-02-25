import 'package:get_it/get_it.dart';

import '../api_service/api/user_api_service.dart';

final GetIt getIt = GetIt.instance;

void registerLocator() {
  getIt.registerLazySingleton<UserApiService>(() => UserApiService());
}
