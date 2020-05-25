import 'package:dio/dio.dart';
import 'package:flutter_boiler_plate/service/api_provider/base_api_provider.dart';

class MockApiProvider extends BaseApiProvider {
  Future<dynamic> loginUser() async {
    return onRequest(() async {
      Response response = await dio.post("/api/user/login", data: {
        "email": "chunlee@gmail.com",
        "password": "123456",
      });
      if (response.data['status'] == 1)
        return response.data;
      else
        throw response.data['message'];
    });
  }
}
