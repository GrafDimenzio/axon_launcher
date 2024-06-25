import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class LauncherState extends ChangeNotifier {
  LauncherState() {
    _init();
  }
  
  bool menuButtonActive = true;
  Directory? axonDirectory;
  Directory? launcherDirectory;

  void setButton(bool active) {
    menuButtonActive = active;
    notifyListeners();
  }

  void _init() async {
    var appData = await getApplicationSupportDirectory();
    var axonPath = path.join(appData.parent.parent.path, 'Axon');
    axonDirectory = Directory(axonPath);
    launcherDirectory = Directory(path.join(axonPath,'launcher'));

    if(await launcherDirectory!.exists() == false) {
      await launcherDirectory!.create(recursive: true);
    }

    print(axonPath);
  }
}