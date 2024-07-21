import 'package:axon_launcher/api/io.dart';
import 'package:axon_launcher/api/steam.dart';
import 'package:axon_launcher/states/account_state.dart';
import 'package:axon_launcher/states/settings_state.dart';
import 'package:axon_launcher/theme/theme_manager.dart';
import 'package:axon_launcher/app.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

const String version = '0.1.0-Alpha';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  var options = WindowOptions(
    center: true,
    size: Size(1200, 700),
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    title: 'Axon Launcher',
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(options, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  windowManager.setResizable(false);

  await checkIo();
  await AccountState.singleton.readAccounts();
  await SettingsState.singleton.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Axon Launcher',
      theme: getTheme(),
      home: const App(),
    );
  }
}
