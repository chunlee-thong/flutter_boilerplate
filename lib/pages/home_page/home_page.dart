import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import 'package:provider/provider.dart';
import '../../bloc/base_stream_consumer.dart';

import '../../bloc/base_stream.dart';
import '../../constant/resource_path.dart';
import '../../model/response/user_model.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with AutomaticKeepAliveClientMixin {
  BaseStream<List<User>> baseStream = BaseStream();

  Future<void> fetchUsers() async {
    await baseStream.asyncOperation(() async {
      return await baseStream.mockApiProvider.fetchUserList();
    });
  }

  @override
  void initState() {
    fetchUsers();
    super.initState();
  }

  @override
  void dispose() {
    baseStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Provider<BaseStream<List<User>>>(
      create: (_) => baseStream,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Boilerplate"),
          actions: <Widget>[
            IconButton(
              icon: Image.asset(R.images.APP_ICON),
              onPressed: () {},
            )
          ],
        ),
        body: ConnectionChecker(
          reactToConnectionChange: true,
          child: HomePageBody(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(FlutterIcons.like1_ant),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseStreamConsumer<List<User>>(
      builder: (context, users) {
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index) {
            final user = users[index];
            return ListTile(
              title: Text(user.name),
              subtitle: Text(user.email),
              trailing: Text(user.company.name),
            );
          },
        );
      },
    );
  }
}
