import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
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
          icon: const Icon(LineIcons.home),
          label: LocaleKeys.home.tr(),
        ),
        const BottomNavigationBarItem(
          icon: Icon(LineIcons.users),
          label: "Dummy",
        ),
        const BottomNavigationBarItem(
          icon: Icon(LineIcons.terminal),
          label: "Templates",
        ),
        BottomNavigationBarItem(
          icon: const Icon(LineIcons.user),
          label: tr(LocaleKeys.profile),
        )
      ],
    );
  }
}

class BottomNavigationController extends ChangeNotifier {
  BottomNavigationController([this.currentIndex = 0]) {
    pageController = PageController(initialPage: currentIndex);
  }

  int currentIndex = 0;
  late PageController pageController;

  void changeIndex(int index) {
    if (pageController.hasClients) {
      currentIndex = index;
      pageController.jumpToPage(index);
      notifyListeners();
    }
  }

  void resetIndex() => changeIndex(0);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
