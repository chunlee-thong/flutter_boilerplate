import 'package:flutter_boiler_plate/enum/type.dart';
import '../model/response/user_model.dart';
import 'base_api_provider.dart';

class MockApiProvider extends BaseApiProvider {
  Future<List<User>> fetchUserList() async {
    return onRequest(
      method: HttpMethod.GET,
      path: "/api/user/all_users",
      onSuccess: (response) {
        List data = response["data"];
        return data.map((user) => User.fromJson(user)).toList();
      },
    );
    // return onRequest(() async {
    //   Response response = await dio.get("/api/user/all_users");
    //   if (response.statusCode == 200 && response.data["status"] == 1) {

    //   } else
    //     throw response.data['message'];
    // });
  }
}
