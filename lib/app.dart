import 'package:axon_launcher/states/launcher_state.dart';
import 'package:axon_launcher/widgets/custom_title_bar.dart';
import 'package:axon_launcher/views/account_view.dart';
import 'package:axon_launcher/views/installer_view.dart';
import 'package:axon_launcher/widgets/sidebar.dart';
import 'package:axon_launcher/views/serverlist_view.dart';
import 'package:axon_launcher/views/settings_view.dart';
import 'package:axon_launcher/views/tools_view.dart';
import 'package:axon_launcher/widgets/version_widget.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Column(
          children: [
            CustomTitleBar(),
            SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight - titleBarSize,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Row(
                    children: [
                      Sidebar(),
                      ListenableBuilder(
                        listenable: LauncherState.singleton,
                        builder: (context, child) {
                          return MainBody();
                        },
                      ),
                    ],
                  ),
                  VersionWidget()
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}

class MainBody extends StatelessWidget {
  const MainBody({super.key});

  @override
  Widget build(BuildContext context) {
    var state = LauncherState.singleton;

    Widget page;

    switch (state.currentPage) {
      case 0:
        page = ServerlistView();

      case 1:
        page = SettingsView();

      case 2:
        page = AccountView();

      case 3:
        page = InstallerView();

      case 4:
        page = ToolsView();

      default:
        throw UnimplementedError('No Page was found for the selected Page');
    }

    return Expanded(child: page);
  }
}
