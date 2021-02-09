import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/app_constant.dart';
import '../../pages/home/home_page.dart';
import '../../pages/user_profile/user_profile_page.dart';
import '../../providers/bottom_navigation_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/local_storage_service.dart';
import 'widgets/bottom_navigation.dart';

class RootPage extends StatefulWidget {
  final int startPageIndex;

  RootPage({Key key, this.startPageIndex = 0}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  List<Widget> get pages => [
        HomePage(),
        Container(),
        Container(),
        UserProfilePage(),
      ];

  void setupUserData() async {
    AppConstant.TOKEN = await LocalStorage.getToken();
    AppConstant.USER_ID = await LocalStorage.read(key: LocalStorage.ID_KEY);
    UserProvider.getProvider(context).getUserInfo();
  }

  @override
  void initState() {
    setupUserData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BottomNavigationProvider(widget.startPageIndex),
      child: Consumer<BottomNavigationProvider>(
        builder: (context, state, child) => WillPopScope(
          onWillPop: () async {
            if (state.currentIndex != 0) {
              state.changeIndex(0);
              return false;
            }
            return true;
          },
          child: Scaffold(
            body: PageView(
              controller: state.pageController,
              physics: NeverScrollableScrollPhysics(),
              children: pages,
            ),
            bottomNavigationBar: RootBottomNavigation(),
          ),
        ),
      ),
    );
  }
}
