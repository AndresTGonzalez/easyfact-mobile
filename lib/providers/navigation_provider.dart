import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  final PageController _pageController = PageController();
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

  // Establecer la pagina 1 como la pagina inicial
  void initialPage() {
    _currentIndex = 1;
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
