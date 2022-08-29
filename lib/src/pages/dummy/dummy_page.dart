import 'package:flutter/material.dart';
import 'package:future_manager/future_manager.dart';
import 'package:skadi/skadi.dart';

import '../../models/pagination.dart';
import '../../models/response/user/user_model.dart';
import '../../repositories/index.dart';
import '../../widgets/common/pull_refresh_listview.dart';

class DummyPage extends StatefulWidget {
  const DummyPage({Key? key}) : super(key: key);
  @override
  _DummyPageState createState() => _DummyPageState();
}

class _DummyPageState extends State<DummyPage> {
  FutureManager<UserListResponse> userManager = FutureManager(reloading: false);
  late PaginationHandler<UserListResponse, UserModel> userPagination = PaginationHandler(userManager);

  Future fetchData([bool reload = false]) async {
    if (reload) {
      userPagination.reset();
    }

    userManager.execute(
      () async {
        return userRepository.fetchUserList(
          count: 20,
          page: userPagination.page,
        );
      },
      onSuccess: userPagination.handle,
    );
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    userManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagination"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () => fetchData(true),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureManagerBuilder<UserListResponse>(
        futureManager: userManager,
        onError: (err) {},
        onRefreshing: () => const RefreshProgressIndicator(),
        ready: (context, UserListResponse response) {
          return PullRefreshListViewBuilder.paginated(
            onRefresh: () => fetchData(true),
            itemCount: response.data.length,
            hasMoreData: userPagination.hasMoreData,
            hasError: userManager.hasError,
            itemBuilder: (context, index) {
              final user = response.data[index];
              return ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                onTap: () {},
                title: Text("${user.firstName} ${user.lastName}"),
                subtitle: EllipsisText(user.email),
              );
            },
            onGetMoreData: fetchData,
          );
        },
      ),
    );
  }
}
