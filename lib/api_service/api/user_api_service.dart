import '../../constant/app_constant.dart';
import '../../models/response/user/auth_response.dart';
import '../../models/response/user/user_model.dart';
import 'base_api_service.dart';

class UserApiService extends BaseApiService {
  static const String _loginUser = "/api/user/login";
  static const String _getUserInfo = "/api/user/info";

  Future<AuthResponse> loginUser({String email, String password}) async {
    return onRequest(
      path: _loginUser,
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
    return onRequest(
      path: "/api/user/all",
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

  Future<UserModel> fetchUserInfo({String email, String password}) async {
    String userId = AppConstant.USER_ID;
    return onRequest<UserModel>(
      path: "$_getUserInfo/$userId",
      method: HttpMethod.GET,
      onSuccess: (response) {
        return UserModel.fromJson(response.data[DATA_FIELD]);
      },
    );
  }
}
