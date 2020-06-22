import 'package:dio/dio.dart';
import 'package:flutter_boiler_plate/model/dummy_model.dart';
import 'base_api_provider.dart';

class MockApiProvider extends BaseApiProvider {
  Future<LoginResponse> loginUser() async {
    return onRequest(() async {
      Response response = await dio.post("/api/user/login", data: {
        "email": "chunlee@gmail.com",
        "password": "123456",
      });
      if (response.data['status'] == 1)
        return LoginResponse.fromJson(response.data);
      else
        throw response.data['message'];
    });
  }
}
