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

  Future<String> loginUser({String email, String password}) async {
    return onRequest(
      path: "/api/user/login",
      method: HttpMethod.POST,
      data: {
        "email": email,
        "password": password,
      },
      onSuccess: (response) {
        return response.data['data']["token"];
      },
    );
  }
}
