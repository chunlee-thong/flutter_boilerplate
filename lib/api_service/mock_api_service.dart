import 'package:dio/dio.dart';
import 'package:flutter_boiler_plate/constant/config.dart';

import '../model/response/user_model.dart';
import 'base_api_service.dart';

class MockApiService extends BaseApiService {
  Future<List<User>> fetchUserList() async {
    return onRequest(
      path: "/api/user/all_users",
      method: HttpMethod.GET,
      onSuccess: (response) {
        List data = response.data["data"];
        return data.map((user) => User.fromJson(user)).toList();
      },
    );
  }

  Future<String> loginUser({String email, String password}) async {
    return onRequest(() async {
      Response response = await dio.post("/api/user/login", data: {
        "email": email,
        "password": password,
      });
      if (response.statusCode == 200 && response.data["status"] == 1) {
        return response.data['data']["token"];
      } else
        throw response.data['message'];
    });
  }
}
