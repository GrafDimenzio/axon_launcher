import 'package:axon_launcher/app_state.dart';
import 'package:axon_launcher/theme/theme_manager.dart';
import 'package:axon_launcher/widgets/launcher_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  var options = WindowOptions(
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    title: 'Axon Launcher',
    minimumSize: Size(500,600)
  );

  windowManager.waitUntilReadyToShow(options, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  
  //windowManager.setResizable(false);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LauncherState(),
      child: MaterialApp(
        title: 'Axon Launcher',
        theme: theme,
        home: const LauncherPage(),
      ),
    );
  }
}