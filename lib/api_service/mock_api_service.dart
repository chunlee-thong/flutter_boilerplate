import '../constant/config.dart';
import '../model/response/user_model.dart';
import 'base_api_service.dart';

class MockApiService extends BaseApiService {
  Future<UserResponse> fetchUserList() async {
    return onRequest(
      path: "/api/user/all_users",
      method: HttpMethod.GET,
      onSuccess: (response) {
        return UserResponse.fromJson(response.data);
      },
    );
  }
}
