import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boiler_plate/src/constant/locale_keys.dart';
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
          label: LocaleKeys.home.tr(),
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
          label: tr(LocaleKeys.profile),
        )
      ],
    );
  }
}
