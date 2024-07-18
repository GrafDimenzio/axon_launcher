import 'dart:io';

import 'package:axon_launcher/api/account_api.dart';
import 'package:axon_launcher/api/io.dart';
import 'package:axon_launcher/models/account.dart';
import 'package:flutter/material.dart';

class AccountState with ChangeNotifier {
  static AccountState singleton = AccountState();

  Account? currentAccount;
  List<Account> accounts = [];

  Future<void> readAccounts() async {
    currentAccount = await readAccountFromFile(accountFile!);
    accounts.clear();
    for (var fileEntity in accountDirectory!.listSync()) {
      final file = File(fileEntity.path);
      final account = await readAccountFromFile(file);
      if (account == null) continue;
      accounts.add(account);
    }

    notifyListeners();
  }
}
