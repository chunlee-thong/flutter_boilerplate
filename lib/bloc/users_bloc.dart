import 'package:flutter_boiler_plate/model/response/user_model.dart';
import 'package:flutter_boiler_plate/repository/base_repository.dart';
import 'package:flutter_boiler_plate/services/base_stream.dart';

class UserBloc extends BaseRepository {
  int currentPage = 1;
  BaseStream<UserResponse> userController = BaseStream();

  Future<void> fetchUsers([bool loading = false]) async {
    await userController.asyncOperation(() async {
      UserResponse response = await mockApiService.fetchUserList(
        count: 10,
        page: currentPage,
      );
      if (userController.hasData) {
        response.users = [...userController.value.users, ...response.users];
      }
      currentPage += 1;
      return response;
    }, onError: (error) {}, loadingOnRefresh: loading);
  }
}
