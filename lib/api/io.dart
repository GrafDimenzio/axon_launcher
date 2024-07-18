import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:path_provider/path_provider.dart';

Directory? axonDirectory;
Directory? launcherDirectory;
Directory? accountDirectory;

Directory? modsDirectory;

File? accountFile;
File? launcherSettingsFile;
File? favoritesFile;
File? historyFile;

Future<void> checkIo() async {
  var appData = await getApplicationSupportDirectory();
  axonDirectory = Directory(path.join(appData.parent.parent.path, 'Axon'));
  launcherDirectory = Directory(path.join(axonDirectory!.path, 'launcher'));
  accountDirectory = Directory(path.join(launcherDirectory!.path, 'accounts'));

  accountFile = File(path.join(axonDirectory!.path,'user.json'));
  launcherSettingsFile = File(path.join(launcherDirectory!.path, 'settings.json'));
  favoritesFile = File(path.join(launcherDirectory!.path, 'favorites.txt'));
  historyFile = File(path.join(launcherDirectory!.path, 'history.txt'));

  if (await accountDirectory!.exists() == false) {
    await accountDirectory!.create(recursive: true);
  }
  if (!await favoritesFile!.exists()) {
    await favoritesFile!.create();
  }
  if (!await historyFile!.exists()) {
    await historyFile!.create();
  }
}
