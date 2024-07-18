import 'dart:io';

import 'package:axon_launcher/launcher_state.dart';
import 'package:path/path.dart' as path;

void launchClient(String ip) async {
  if (LauncherState.singleton?.settings?.axonClientPath == null) return;
  final exe =
      path.join(LauncherState.singleton!.settings!.axonClientPath, 'SCPSL.exe');
  print(exe);
  var arguments = ['-noauth', '-ip=$ip'];

  if (!LauncherState.singleton!.settings!.devMode) {
    arguments.add('--melonloader.hideconsole');
  }

  await Process.start(
    exe,
    arguments,
    workingDirectory: LauncherState.singleton!.settings!.axonClientPath,
    mode: ProcessStartMode.detached,
  );
}
