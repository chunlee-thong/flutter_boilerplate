import './../model/response/user_model.dart';
import './../services/async_subject.dart';
import '../api_service/index.dart';

class UserBloc {
  int currentPage = 1;
  AsyncSubject<UserResponse> userController = AsyncSubject();

  Future<void> fetchUsers([bool loading = false]) async {
    if (loading) {
      currentPage = 1;
    }
    await userController.asyncOperation(() async {
      UserResponse response = await mockApiService.fetchUserList(
        count: 10,
        page: currentPage,
      );
      if (userController.hasData) {
        response.users = [...userController.value.users, ...response.users];
      }
      if (response.users.isNotEmpty) {
        currentPage += 1;
      }
      return response;
    }, onError: (error) {}, resetStream: loading);
  }

  void dispose() {
    userController.dispose();
  }
}
