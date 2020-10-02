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
}
