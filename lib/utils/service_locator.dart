import 'package:flutter_boiler_plate/api_service/mock_api_service.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void registerLocator() {
  getIt.registerSingleton<MockApiService>(MockApiService());
}
