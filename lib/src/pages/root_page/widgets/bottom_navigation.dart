import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../constant/locale_keys.dart';
import 'package:provider/provider.dart';

import '../../../providers/bottom_navigation_provider.dart';

class RootBottomNavigation extends StatelessWidget {
  const RootBottomNavigation({Key? key}) : super(key: key);
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
          icon: const Icon(Icons.home),
          label: LocaleKeys.home.tr(),
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.group),
          label: "Dummy",
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_customize),
          label: "Templates",
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: tr(LocaleKeys.profile),
        )
      ],
    );
  }
}
