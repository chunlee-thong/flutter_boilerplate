import 'package:flutter/material.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:provider/provider.dart';

import '../../pages/home/home_page.dart';
import '../../pages/user_profile/user_profile_page.dart';
import '../../services/local_storage_service/local_storage_service.dart';
import '../../widgets/common/bottom_navigation_widget.dart';
import '../dummy/dummy_page.dart';
import '../templates/template_pages.dart';

class RootPage extends StatefulWidget {
  final int startPageIndex;

  const RootPage({Key? key, this.startPageIndex = 0}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  List<Widget> get pages => [
        const HomePage(),
        const DummyPage(),
        const TemplatePages(),
        const UserProfilePage(),
      ];

  void initializeMatomo() async {
    String userId = await LocalStorage.read(key: kIdKey);
    String matomoId = userId.substring(userId.length - 16);
    await MatomoTracker.instance.initialize(
      siteId: 123,
      url: "url",
      visitorId: matomoId,
    );
  }

  @override
  void initState() {
    initializeMatomo();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationController>(
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
            physics: const NeverScrollableScrollPhysics(),
            children: pages,
          ),
          bottomNavigationBar: const BottomNavigationWidget(),
        ),
      ),
    );
  }
}
