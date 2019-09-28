import 'package:flutter/material.dart';

class BottomNavBarScreenProvider with ChangeNotifier {
  int _currentPageIndex = 0;

  set currentPageIndex(int index) {
    _currentPageIndex = index;
    notifyListeners();
  }

  int get getCurrentPageIndex {
    return _currentPageIndex;
  }
}
