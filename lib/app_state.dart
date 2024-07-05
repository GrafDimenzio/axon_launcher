import 'dart:convert';
import 'dart:io';
import 'package:axon_launcher/api/account_api.dart';
import 'package:axon_launcher/models/account.dart';
import 'package:axon_launcher/models/settings.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class LauncherState extends ChangeNotifier {
  LauncherState() {
    _init();
  }

  static LauncherState? singleton;

  bool allowSwitch = true;
  int currentPage = 0;

  Directory? axonDirectory;
  Directory? launcherDirectory;
  Directory? accountDirectory;
  File? launcherSettings;
  Settings? settings;

  File? accountPath;
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
      ), notify: false);
    }
    else {
      await readSettings(notify: false);
    }

    accountPath = File(path.join(axonPath,'user.json'));
    await readAccounts(notify: false);

    notifyListeners();
  }

  Future<void> readAccounts({ bool notify = true }) async {
    currentAccount = await readAccountFromFile(accountPath!);
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
    if(launcherSettings == null) return;

    if(await launcherSettings!.exists() == false) {
      await launcherSettings!.create();
    }

    await launcherSettings!.writeAsString(json);

    if(notify) {
      notifyListeners();
    }
  }

  Future<void> readSettings({ bool notify = true }) async {
    if(launcherSettings == null) return;
    var fileBytes = await launcherSettings!.readAsBytes();
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
