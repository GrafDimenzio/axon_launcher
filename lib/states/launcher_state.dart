import 'package:flutter/material.dart';

class LauncherState extends ChangeNotifier {
  static LauncherState singleton = LauncherState();

  bool allowSwitch = true;
  int currentPage = 0;

  void setPage(int page) {
    currentPage = page;
    notifyListeners();
  }

  void setAllowPageSwitch(bool active) {
    allowSwitch = active;
    notifyListeners();
  }
}
