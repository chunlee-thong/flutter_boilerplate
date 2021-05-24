import 'package:flutter/material.dart';

class BottomNavigationProvider extends ChangeNotifier {
  int currentIndex = 0;
  late PageController pageController;
  BottomNavigationProvider([int index = 0]) {
    pageController = PageController(initialPage: index);
    currentIndex = index;
  }

  void changeIndex(int index) {
    if (pageController.hasClients) {
      this.currentIndex = index;
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
