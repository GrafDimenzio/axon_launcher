import 'package:axon_launcher/launcher_state.dart';
import 'package:axon_launcher/widgets/custom_title_bar.dart';
import 'package:axon_launcher/widgets/pages/account_page.dart';
import 'package:axon_launcher/widgets/pages/installer_page.dart';
import 'package:axon_launcher/widgets/sidebar.dart';
import 'package:axon_launcher/widgets/pages/serverlist_page.dart';
import 'package:axon_launcher/widgets/pages/settings_page.dart';
import 'package:axon_launcher/widgets/pages/tools_page.dart';
import 'package:axon_launcher/widgets/version_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LauncherPage extends StatelessWidget {
  const LauncherPage({super.key});
  @override
  Widget build(BuildContext context) {
    //I don't want this widget to be rebuilded since it would mess with the Sidebar Animations
    print('MAIN LAUNCHER BUILD!');
    final state = Provider.of<LauncherState>(context, listen: false);

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
                      Sidebar(
                        state: state,
                      ),
                      MainBody()
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
    var state = context.watch<LauncherState>();

    Widget page;

    switch (state.currentPage) {
      case 0:
        page = ServerlistPage();

      case 1:
        page = SettingsPage();

      case 2:
        page = AccountPage();

      case 3:
        page = InstallerPage();

      case 4:
        page = ToolsPage();

      default:
        throw UnimplementedError('No Page was found for the selected Page');
    }

    return Expanded(child: page);
  }
}
