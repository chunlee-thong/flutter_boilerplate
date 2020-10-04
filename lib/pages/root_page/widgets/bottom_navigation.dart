import 'package:flutter/material.dart';
import 'package:flutter_boiler_plate/provider/bottom_navigation_provider.dart';
import 'package:provider/provider.dart';

class RootBottonNavigation extends StatelessWidget {
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
    );
  }
}
