import 'package:axon_launcher/widgets/launcher_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
    required this.theme,
    required this.onSelectPage,
  });

  final ThemeData theme;
  final Function(int) onSelectPage;

  @override
  Widget build(BuildContext context) {
    final headerColor = theme.colorScheme.secondary;
    final onHeaderColor = theme.colorScheme.onSecondary;
    final headerStyle = theme.textTheme.titleLarge!.copyWith(color: onHeaderColor);

    return Drawer(
      child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: headerColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Axon Launcher',style: headerStyle,),
                  Text('By Dimenzio',style: headerStyle,)
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Serverlist'),
              subtitle: Text('Select and join a Server'),
              onTap: () {
                selectMenu(0);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              subtitle: Text('Manage your Launcher and Client'),
              onTap: () {
                selectMenu(1);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Account'),
              subtitle: Text('Manage your Axon Accounts'),
              onTap: () {
                selectMenu(2);
              },
            ),
            ListTile(
              leading: Icon(Icons.install_desktop),
              title: Text('Installer'),
              subtitle: Text('Install the SCP:SL Axon Client'),
              onTap: () {
                selectMenu(3);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings_applications),
              title: Text('Tools'),
              subtitle: Text('Various tools for developers'),
              onTap: () {
                selectMenu(4);
              },
            ),
            Divider(
              color: theme.colorScheme.onPrimary,
            ),
            ListTile(
              title: Text('Contact'),
              dense: true,
            ),
            ListTile(
              leading: Image.asset('assets/discord.png',height: 36,width: 36,filterQuality: FilterQuality.high,),
              title: Text('Discord'),
              subtitle: Text('Join our community'),
              onTap: () async {
                launchUrlString('https://discord.gg/wSBHXwy');
              },
            ),
            AboutListTile(
              applicationName: 'Axon Launcher',
              applicationVersion: '1.0.0',
              applicationLegalese: 'We are not Northwood and are not affiliated with them',
              applicationIcon: Icon(Icons.info,),
              dense: true,
              icon: Icon(Icons.info),
            ),
          ],
        ),
    );
  }

  void selectMenu(int index){
    onSelectPage(index);
    LauncherPage.scaffoldKey.currentState?.closeDrawer();
  }
}