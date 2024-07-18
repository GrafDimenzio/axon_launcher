import 'dart:io';

import 'package:axon_launcher/states/settings_state.dart';
import 'package:path/path.dart' as path;

void launchClient({String? ip}) async {
  if (SettingsState.singleton.settings?.axonClientPath == null) return;
  final exe =
      path.join(SettingsState.singleton.settings!.axonClientPath, 'SCPSL.exe');
  print(exe);
  var arguments = ['-noauth'];

  if(ip != null) {
    arguments.add('-ip=$ip');
  }

  if (!SettingsState.singleton.settings!.devMode) {
    arguments.add('--melonloader.hideconsole');
  }

  await Process.start(
    exe,
    arguments,
    workingDirectory: SettingsState.singleton.settings!.axonClientPath,
    mode: ProcessStartMode.detached,
  );
}
