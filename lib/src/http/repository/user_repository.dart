import '../../constant/app_constant.dart';
import '../../models/others/user_secret.dart';
import '../../models/response/user/auth_response.dart';
import '../../models/response/user/user_model.dart';
import '../client/base_api.dart';
import '../client/http_exception.dart';

class UserRepository extends API {
  static const String _LOGIN_USER = "/api/user/login";
  static const String _GET_ALL_USER = "/api/user/all";
  static const String _GET_USER_INFO = "/api/user/info/";

  Future<AuthResponse> loginUser({required String email, required String password}) async {
    return httpRequest(
      path: _LOGIN_USER,
      method: HttpMethod.POST,
      data: {
        "email": email,
        "password": password,
      },
      onSuccess: (response) {
        return AuthResponse.fromJson(response.data[DATA_FIELD]);
      },
    );
  }

  Future<UserResponse> fetchUserList({int page = 1, int count = 99999}) async {
    return httpRequest(
      path: _GET_ALL_USER,
      query: {
        "page": page,
        "count": count,
      },
      onSuccess: (response) {
        return UserResponse.fromJson(response.data);
      },
    );
  }

  Future<UserModel> fetchUserInfo() async {
    String? userId = UserSecret.instance.userId;
    if (userId == null) {
      throw SessionExpiredException();
    }
    return httpRequest(
      path: _GET_USER_INFO + userId,
      onSuccess: (response) {
        return UserModel.fromJson(response.data[DATA_FIELD]);
      },
    );
  }
}
