import '../core/http/base_api.dart';
import '../core/http/http_client.dart';
import '../core/http/http_exception.dart';
import '../models/response/user/auth_response.dart';
import '../models/response/user/user_model.dart';
import '../services/local_storage_service/local_storage_service.dart';

class UserRepository extends API {
  UserRepository() : super(httpClient: DefaultDioClient());

  static const String _loginUser = "/api/user/login";
  static const String _getAllUser = "/api/user/all";
  static const String _getUserInfo = "/api/user/info/";

  Future<AuthResponse> loginUser({required String email, required String password}) async {
    return httpRequest(
      path: _loginUser,
      requiredToken: false,
      method: HttpMethod.post,
      data: {
        "email": email,
        "password": password,
      },
      onSuccess: (response) {
        return AuthResponse.fromJson(response.data[kDataField]);
      },
    );
  }

  Future<UserListResponse> fetchUserList({int page = 1, int count = 99999}) async {
    return httpRequest(
      path: _getAllUser,
      query: {
        "page": page,
        "count": count,
      },
      onSuccess: (response) {
        return UserListResponse.fromJson(response.data);
      },
    );
  }

  Future<UserModel> fetchUserInfo() async {
    String? userId = await LocalStorage.read(key: kIdKey);
    if (userId == null) {
      throw SessionExpiredException();
    }
    return httpRequest(
      path: _getUserInfo + userId,
      onSuccess: (response) {
        return UserModel.fromJson(response.data[kDataField]);
      },
    );
  }
}
