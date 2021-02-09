import '../constant/app_config.dart';
import '../constant/app_constant.dart';
import '../models/others/login_response.dart';
import '../models/response/user/user_model.dart';
import 'base_api_service.dart';

class UserApiService extends BaseApiService {
  static const String _loginUser = "/api/user/login";
  static const String _getUserInfo = "/api/user/info";

  Future<LoginResponse> loginUser({String email, String password}) async {
    return onRequest(
      path: _loginUser,
      method: HttpMethod.POST,
      data: {
        "email": email,
        "password": password,
      },
      onSuccess: (response) {
        return LoginResponse(response.data["data"]["_id"], response.data["token"]);
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
