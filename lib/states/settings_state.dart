import 'dart:convert';
import 'dart:io';

import 'package:axon_launcher/api/io.dart';
import 'package:axon_launcher/models/settings.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class SettingsState with ChangeNotifier {
  static SettingsState singleton = SettingsState();

  Settings? settings;

  Future<void> init() async {
    if (await launcherSettingsFile!.exists() == false) {
      modsDirectory = Directory(path.join(launcherDirectory!.path, 'mods'));
      await saveSettings(Settings(
        devMode: false,
        ue: false,
        axonClientPath: '',
        modsPath: modsDirectory!.path,
        serverList: 'https://list.axon-sl.org/serverlist',
      ));
    } else {
      await readSettings();
      modsDirectory = Directory(settings!.modsPath);
    }
    if (await modsDirectory!.exists() == false) {
      await modsDirectory!.create();
    }
  }

  Future<void> saveSettings(Settings sett) async {
    settings = sett;
    var json = jsonEncode(sett);
    if (launcherSettingsFile == null) return;

    if (await launcherSettingsFile!.exists() == false) {
      await launcherSettingsFile!.create();
    }

    await launcherSettingsFile!.writeAsString(json);

    notifyListeners();
  }

  Future<void> readSettings() async {
    if (launcherSettingsFile == null) return;
    var fileBytes = await launcherSettingsFile!.readAsBytes();
    var settingsJson = utf8.decode(fileBytes);
    settings = Settings.fromJson(jsonDecode(settingsJson));
    notifyListeners();
  }

  Future<void> updateSettings() async {
    if (settings == null) return;
    await saveSettings(settings!);
  }
}
