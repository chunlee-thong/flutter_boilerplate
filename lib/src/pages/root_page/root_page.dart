import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../pages/home/home_page.dart';
import '../../pages/user_profile/user_profile_page.dart';
import '../../providers/bottom_navigation_provider.dart';
import '../dummy/dummy_page.dart';
import '../templates/template_pages.dart';
import 'root_bottom_navigation_bar.dart';

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

  @override
  void initState() {
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
              physics: const NeverScrollableScrollPhysics(),
              children: pages,
            ),
            bottomNavigationBar: const RootBottomNavigationBar(),
          ),
        ),
      ),
    );
  }
}
