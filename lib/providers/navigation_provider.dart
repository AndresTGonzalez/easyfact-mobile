import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  PageController _pageController = PageController();
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    _pageController.animateToPage(
      index,
      duration: const Duration(microseconds: 250),
      curve: Curves.easeOut,
    );
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
