import 'package:dio/dio.dart';

import '../model/response/user_model.dart';
import 'base_api_provider.dart';

class MockApiProvider extends BaseApiProvider {
  Future<List<User>> fetchUserList() async {
    return onRequest(() async {
      Response response = await dio.get("/api/user/all_users2");
      if (response.statusCode == 200 && response.data["status"] == 1) {
        List data = response.data["data"];
        return data.map((user) => User.fromJson(user)).toList();
      } else
        throw response.data['message'];
    });
  }
}
