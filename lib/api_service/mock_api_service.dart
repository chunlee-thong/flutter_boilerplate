import '../constant/config.dart';
import '../model/response/user_model.dart';
import 'base_api_service.dart';

class MockApiService extends BaseApiService {
  ///Provide another dio client if you need a new one, otherwise it will use the default one
  MockApiService() : super(dio: null);
  Future<UserResponse> fetchUserList({int page = 1, int count = 99999}) async {
    return onRequest(
      path: "/api/user/all_users",
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
