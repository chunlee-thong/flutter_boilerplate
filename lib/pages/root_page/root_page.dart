import 'package:flutter/material.dart';
import '../../pages/home_page/home_page.dart';
import '../../provider/bottom_navigation_provider.dart';
import 'package:provider/provider.dart';

class RootPage extends StatefulWidget {
  final int startPageIndex;
  RootPage({Key key, this.startPageIndex = 0}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  List<Widget> get pages => [
        MyHomePage(),
        Container(),
        Container(),
        Container(),
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
              physics: NeverScrollableScrollPhysics(),
              children: pages,
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.currentIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                state.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.assessment),
                  label: "Report",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.map),
                  label: "Map",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: "Setting",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
