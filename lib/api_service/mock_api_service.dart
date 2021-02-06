import '../constant/app_config.dart';
import '../models/response/user_model.dart';
import 'base_api_service.dart';

class MockApiService extends BaseApiService {
  ///Provide another dio client if you need a new one, otherwise it will use the default one
  MockApiService() : super(dio: null);
  Future<UserResponse> fetchUserList({int page = 1, int count = 99999}) async {
    return onRequest(
      path: "/api/user/all_users3",
      query: {
        "page": page,
        "count": count,
      },
      method: HttpMethod.GET,
      onSuccess: (response) {
        return UserResponse.fromJson(response.data);
      },
    );
  }
}
