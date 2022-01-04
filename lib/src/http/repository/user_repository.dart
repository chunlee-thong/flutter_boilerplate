import '../../constant/app_constant.dart';
import '../../models/others/user_secret.dart';
import '../../models/response/user/auth_response.dart';
import '../../models/response/user/user_model.dart';
import '../client/http_exception.dart';
import '../client/base_api.dart';

abstract class IUserRepository {
  static const String LOGIN_USER = "/api/user/login";
  static const String GET_ALL_USER = "/api/user/all";
  static const String GET_USER_INFO = "/api/user/info/";

  Future<AuthResponse> loginUser({required String email, required String password});
  Future<UserResponse> fetchUserList({int page, int count});
  Future<UserModel> fetchUserInfo();
}

class UserRepository extends API implements IUserRepository {
  @override
  Future<AuthResponse> loginUser({required String email, required String password}) async {
    return httpRequest(
      path: IUserRepository.LOGIN_USER,
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

  @override
  Future<UserResponse> fetchUserList({int page = 1, int count = 99999}) async {
    return httpRequest(
      path: IUserRepository.GET_ALL_USER,
      query: {
        "page": page,
        "count": count,
      },
      onSuccess: (response) {
        return UserResponse.fromJson(response.data);
      },
    );
  }

  @override
  Future<UserModel> fetchUserInfo() async {
    String? userId = UserSecret.instance.userId;
    if (userId == null) {
      throw SessionExpiredException();
    }
    return httpRequest(
      path: IUserRepository.GET_USER_INFO + userId,
      onSuccess: (response) {
        return UserModel.fromJson(response.data[DATA_FIELD]);
      },
    );
  }
}
