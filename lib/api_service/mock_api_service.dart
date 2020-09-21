import 'package:dio/dio.dart';

import '../model/response/user_model.dart';
import 'base_api_service.dart';

class MockApiService extends BaseApiService {
  Future<List<User>> fetchUserList() async {
    return onRequest(() async {
      Response response = await dio.get("/api/user/all_users");
      if (response.statusCode == 200 && response.data["status"] == 1) {
        List data = response.data["data"];
        return data.map((user) => User.fromJson(user)).toList();
      } else
        throw response.data['message'];
    });
  }
}
