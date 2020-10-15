import './../model/response/user_model.dart';
import './../repository/base_repository.dart';
import './../services/base_stream.dart';

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
