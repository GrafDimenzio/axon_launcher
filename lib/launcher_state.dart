import 'dart:convert';
import 'dart:io';
import 'package:axon_launcher/api/account_api.dart';
import 'package:axon_launcher/api/io.dart';
import 'package:axon_launcher/models/account.dart';
import 'package:axon_launcher/models/settings.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class LauncherState extends ChangeNotifier {
  LauncherState() {
    _init();
  }

  static LauncherState? singleton;

  bool allowSwitch = true;
  int currentPage = 0;

  Settings? settings;

  Account? currentAccount;
  List<Account> accounts = [];

  void setPage(int page) {
    currentPage = page;
    notifyListeners();
  }

  void setAllowPageSwitch(bool active) {
    allowSwitch = active;
    notifyListeners();
  }

  void _init() async {
    singleton = this;

    if(await launcherSettingsFile!.exists() == false) {
      modsDirectory = Directory(path.join(launcherDirectory!.path,'mods'));
      await saveSettings(Settings(
        devMode: false,
        ue: false,
        axonClientPath: '',
        modsPath: modsDirectory!.path,
      ), notify: false);
    }
    else {
      await readSettings(notify: false);
      modsDirectory = Directory(settings!.modsPath);
    }
    if (await modsDirectory!.exists() == false) {
      await modsDirectory!.create();
    }

    await readAccounts(notify: false);

    notifyListeners();
  }

  Future<void> readAccounts({ bool notify = true }) async {
    currentAccount = await readAccountFromFile(accountFile!);
    accounts.clear();
    for(var fileEntity in accountDirectory!.listSync()) {
      final file = File(fileEntity.path);
      final account = await readAccountFromFile(file);
      if(account == null) continue;
      accounts.add(account);
    }

    if(notify) {
      notifyListeners();
    }
  }

  Future<void> saveSettings(Settings sett, { bool notify = true }) async {
    settings = sett;
    var json = jsonEncode(sett);
    if(launcherSettingsFile == null) return;

    if(await launcherSettingsFile!.exists() == false) {
      await launcherSettingsFile!.create();
    }

    await launcherSettingsFile!.writeAsString(json);

    if(notify) {
      notifyListeners();
    }
  }

  Future<void> readSettings({ bool notify = true }) async {
    if(launcherSettingsFile == null) return;
    var fileBytes = await launcherSettingsFile!.readAsBytes();
    var settingsJson = utf8.decode(fileBytes);
    settings = Settings.fromJson(jsonDecode(settingsJson));
    if(notify) {
      notifyListeners();
    }
  }

  Future<void> updateSettings() async {
    if(settings == null) return;
    await saveSettings(settings!);
  }
}
