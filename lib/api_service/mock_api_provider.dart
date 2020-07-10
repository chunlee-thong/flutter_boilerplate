import 'package:dio/dio.dart';
import 'package:flutter_boiler_plate/model/dummy_model.dart';
import 'base_api_provider.dart';

class MockApiProvider extends BaseApiProvider {
  Future<List<User>> fetchUserList() async {
    return onRequest(() async {
      Response response = await dio.get("/users");
      if (response.statusCode == 200) {
        List data = response.data;
        return data.map((user) => User.fromJson(user)).toList();
      } else
        throw response.data['message'];
    });
  }
}
