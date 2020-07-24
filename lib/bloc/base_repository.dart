import '../api_service/mock_api_provider.dart';
import '../main.dart';

class BaseRepository {
  MockApiProvider mockApiProvider = getIt<MockApiProvider>();
}
