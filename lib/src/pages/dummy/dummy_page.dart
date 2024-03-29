import 'package:flutter/material.dart';
import 'package:future_manager/future_manager.dart';
import 'package:line_icons/line_icons.dart';
import 'package:skadi/skadi.dart';
import 'package:skadi_plus/skadi_plus.dart';

import '../../models/response/user/user_model.dart';
import '../../repositories/index.dart';
import '../../widgets/state_widgets/error_widget.dart';

class DummyPage extends StatefulWidget {
  const DummyPage({Key? key}) : super(key: key);
  @override
  State<DummyPage> createState() => _DummyPageState();
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
          return SkadiPaginatedListViewPlus(
            onRefresh: () => fetchData(true),
            itemCount: response.data.length,
            paginationHandler: userPagination,
            errorWidget: (onRefresh, error) => CustomErrorWidget(
              error: error,
              onRefresh: onRefresh,
              hasIcon: false,
            ),
            itemBuilder: (context, index) {
              final user = response.data[index];
              return ListTile(
                leading: const CircleAvatar(
                  child: Icon(LineIcons.userCheck),
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
