import 'package:flutter_boiler_plate/utils/service_locator.dart';
import '../api_service/mock_api_service.dart';

class BaseRepository {
  MockApiService mockApiService = getIt<MockApiService>();
}
