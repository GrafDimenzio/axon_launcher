import 'package:axon_launcher/app_state.dart';
import 'package:axon_launcher/widgets/pages/account_page.dart';
import 'package:axon_launcher/widgets/display_button_widget.dart';
import 'package:axon_launcher/widgets/pages/installer_page.dart';
import 'package:axon_launcher/widgets/drawer_widget.dart';
import 'package:axon_launcher/widgets/pages/serverlist_page.dart';
import 'package:axon_launcher/widgets/pages/settings_page.dart';
import 'package:axon_launcher/widgets/pages/tools_page.dart';
import 'package:axon_launcher/widgets/version_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LauncherPage extends StatefulWidget {
  const LauncherPage({super.key});

  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {

  var selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var state = context.watch<LauncherState>();

    Widget page;

    switch(selectedPage) {
      case 0:
        page = ServerlistPage(theme: theme);

      case 1:
        page = SettingsPage(theme: theme);

      case 2:
        page = AccountPage(theme: theme);

      case 3:
        page = InstallerPage(theme: theme);

      case 4:
        page = ToolsPage(theme: theme);

      default:
        throw UnimplementedError('No Page was found for the selected Page');
    }

    return Scaffold(
      drawer: DrawerWidget(
        theme: theme,
        onSelectPage: (index) {
          print(index);
          setState(() {
            selectedPage = index;
          });
        },
      ),
      key: LauncherPage.scaffoldKey,
      //Starting Page
      body: Stack(
        fit: StackFit.expand,
        children: [
          page,
          
          if(state.menuButtonActive)
            DisplayButtonWidget(theme: theme),
          VersionWidget()
        ],
      ),
    );
  }
}