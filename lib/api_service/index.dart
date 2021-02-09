import '../utils/service_locator.dart';
import 'mock_api_service.dart';
import 'user_api_service.dart';

final MockApiService mockApiService = getIt<MockApiService>();
final UserApiService userApiService = getIt<UserApiService>();
