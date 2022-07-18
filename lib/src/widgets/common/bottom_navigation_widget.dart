import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constant/locale_keys.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<BottomNavigationController>(context);
    //Add this line to update on locale change
    context.locale;
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

class BottomNavigationController extends ChangeNotifier {
  int currentIndex = 0;
  late PageController pageController;
  BottomNavigationController([this.currentIndex = 0]) {
    pageController = PageController(initialPage: currentIndex);
  }

  void changeIndex(int index) {
    if (pageController.hasClients) {
      currentIndex = index;
      pageController.jumpToPage(index);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
