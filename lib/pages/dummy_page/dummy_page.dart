import 'package:flutter/material.dart';
import 'package:flutter_boiler_plate/bloc/users_bloc.dart';
import 'package:flutter_boiler_plate/model/response/user_model.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class DummyPage extends StatefulWidget {
  DummyPage({Key key}) : super(key: key);
  @override
  _DummyPageState createState() => _DummyPageState();
}

class _DummyPageState extends State<DummyPage> {
  UserBloc userBloc;

  @override
  void initState() {
    userBloc = UserBloc()..fetchUsers();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fetch all users with pagination")),
      body: StreamHandler<UserResponse>(
        stream: userBloc.userController.stream,
        ready: (UserResponse data) {
          return PaginatedListView(
            itemCount: data.users.length,
            padding: EdgeInsets.zero,
            onGetMoreData: () => userBloc.fetchUsers(),
            hasMoreData: userBloc.currentPage <= data.pagination.totalPage,
            itemBuilder: (context, index) {
              final user = data.users[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.person),
                ),
                onTap: () {},
                title: Text("${user.firstName} ${user.lastName}"),
                subtitle: Text(user.email),
              );
            },
          );
        },
      ),
    );
  }
}
