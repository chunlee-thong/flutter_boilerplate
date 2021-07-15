import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/bottom_navigation_provider.dart';

class RootBottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<BottomNavigationProvider>(context);
    return BottomNavigationBar(
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
          icon: Icon(Icons.group),
          label: "Dummy",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_customize),
          label: "Templates",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        )
      ],
    );
  }
}
