import 'package:flutter/material.dart';

class BottomNavigationProvider extends ChangeNotifier {
  int currentIndex = 0;
  late PageController pageController;
  BottomNavigationProvider([this.currentIndex = 0]) {
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
