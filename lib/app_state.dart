import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class LauncherState extends ChangeNotifier {
  LauncherState() {
    _init();
  }

  bool allowSwitch = true;
  int currentPage = 0;

  Directory? axonDirectory;
  Directory? launcherDirectory;
  Directory? accountDirectory;
  File? launcherSettings;
  Settings? settings;

  void setPage(int page) {
    currentPage = page;
    notifyListeners();
  }

  void setAllowPageSwitch(bool active) {
    allowSwitch = active;
    notifyListeners();
  }

  void _init() async {
    var appData = await getApplicationSupportDirectory();
    var axonPath = path.join(appData.parent.parent.path, 'Axon');
    axonDirectory = Directory(axonPath);
    launcherDirectory = Directory(path.join(axonPath, 'launcher'));
    accountDirectory = Directory(path.join(launcherDirectory!.path,'accounts'));

    launcherSettings = File(path.join(launcherDirectory!.path,'settings.json'));

    if (await accountDirectory!.exists() == false) {
      await accountDirectory!.create(recursive: true);
    }

    if(await launcherSettings!.exists() == false) {
      var modsDir = Directory(path.join(launcherDirectory!.path,'mods'));
      if(await modsDir.exists() == false) {
        await modsDir.create();
      }
      await saveSettings(Settings(
        devMode: false,
        ue: false,
        axonClientPath: '',
        modsPath: modsDir.path,
      ));
    }
    else {
      await readSettings();
    }

    notifyListeners();
  }

  Future<void> saveSettings(Settings sett) async {
    settings = sett;
    var json = jsonEncode(sett);
    if(launcherSettings == null) return;

    if(await launcherSettings!.exists() == false) {
      await launcherSettings!.create();
    }

    await launcherSettings!.writeAsString(json);
    notifyListeners();
  }

  Future<void> readSettings() async {
    if(launcherSettings == null) return;
    var fileBytes = await launcherSettings!.readAsBytes();
    var settingsJson = utf8.decode(fileBytes);
    settings = Settings.fromJson(jsonDecode(settingsJson));
    notifyListeners();
  }

  Future<void> updateSettings() async {
    if(settings == null) return;
    await saveSettings(settings!);
  }
}

class Settings {
  Settings({
    required this.devMode,
    required this.ue,
    required this.axonClientPath,
    required this.modsPath
  });

  bool devMode = false;
  bool ue = false;
  String axonClientPath = '';
  String modsPath = '';

  Map<String, dynamic> toJson() {
    return {
      'devMode': devMode,
      'ue': ue,
      'axonClientPath': axonClientPath,
      'modsPath': modsPath
    };
  }

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      devMode: json['devMode'],
      ue: json['ue'],
      axonClientPath: json['axonClientPath'],
      modsPath: json['modsPath']
    );
  }
}
