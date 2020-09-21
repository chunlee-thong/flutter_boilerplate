import '../api_service/mock_api_service.dart';
import '../main.dart';

class BaseRepository {
  MockApiService mockApiService = getIt<MockApiService>();
}
