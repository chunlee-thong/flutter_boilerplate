import 'package:flutter/material.dart';
import 'package:sura_manager/sura_manager.dart';

import '../../http/repository/index.dart';
import '../../models/response/user/user_model.dart';
import '../../widgets/common/ellipsis_text.dart';
import '../../widgets/common/pull_refresh_listview.dart';

class DummyPage extends StatefulWidget {
  const DummyPage({Key? key}) : super(key: key);
  @override
  _DummyPageState createState() => _DummyPageState();
}

class _DummyPageState extends State<DummyPage> {
  FutureManager<UserResponse> userController = FutureManager();
  int currentPage = 1;

  Future fetchData([bool reload = false]) async {
    if (reload) {
      currentPage = 1;
    }
    userController.asyncOperation(
      () => userRepository.fetchUserList(
        count: 20,
        page: currentPage,
      ),
      onSuccess: (response) {
        if (userController.hasData) {
          response.users = [...userController.data!.users, ...response.users];
        }
        currentPage += 1;
        return response;
      },
      reloading: reload,
    );
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagination"),
        centerTitle: false,
      ),
      body: FutureManagerBuilder<UserResponse>(
        futureManager: userController,
        ready: (context, UserResponse response) {
          return PullRefreshListViewBuilder.paginated(
            onRefresh: () => fetchData(true),
            itemCount: response.users.length,
            hasMoreData: response.hasMoreData,
            hasError: userController.hasError,
            itemBuilder: (context, index) {
              final user = response.users[index];
              return ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                onTap: () {},
                title: Text("${user.firstName} ${user.lastName}"),
                subtitle: EllipsisText("${user.email}"),
              );
            },
            onGetMoreData: fetchData,
          );
        },
      ),
    );
  }
}
