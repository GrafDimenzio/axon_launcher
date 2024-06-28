import 'package:axon_launcher/app_state.dart';
import 'package:axon_launcher/widgets/launcher_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    super.key,
    required this.state,
  });

  final LauncherState state;

  void selectPage(int page) {
    if (state.allowSwitch) {
      state.setPage(page);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headerColor = theme.colorScheme.secondary;
    final onHeaderColor = theme.colorScheme.onSecondary;
    final headerStyle =
        theme.textTheme.titleLarge!.copyWith(color: onHeaderColor);
    final listColor = theme.colorScheme.primary;

    print('SIDEBAR BUILD');

    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        width: 300,
        height: constraints.maxHeight,
        child: Container(
          color: listColor,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: headerColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Axon Launcher',
                      style: headerStyle,
                    ),
                    Text(
                      'By Dimenzio',
                      style: headerStyle,
                    )
                  ],
                ),
              ),
              CustomListTile(
                color: listColor,
                leading: Icon(Icons.list),
                title: Text('Serverlist'),
                subtitle: Text('Select and join a Server'),
                onTap: () {
                  selectMenu(0);
                },
              ),
              CustomListTile(
                color: listColor,
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                subtitle: Text('Manage your Launcher and Client'),
                onTap: () {
                  selectMenu(1);
                },
              ),
              CustomListTile(
                color: listColor,
                leading: Icon(Icons.person),
                title: Text('Account'),
                subtitle: Text('Manage your Axon Accounts'),
                onTap: () {
                  selectMenu(2);
                },
              ),
              CustomListTile(
                color: listColor,
                leading: Icon(Icons.install_desktop),
                title: Text('Installer'),
                subtitle: Text('Install the SCP:SL Axon Client'),
                onTap: () {
                  selectMenu(3);
                },
              ),
              CustomListTile(
                color: listColor,
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
              CustomListTile(
                color: listColor,
                leading: Image.asset(
                  'assets/discord.png',
                  height: 36,
                  width: 36,
                  filterQuality: FilterQuality.high,
                ),
                title: Text('Discord'),
                subtitle: Text('Join our community'),
                onTap: () async {
                  launchUrlString('https://discord.gg/wSBHXwy');
                },
              ),
              AboutListTile(
                applicationName: 'Axon Launcher',
                applicationVersion: '1.0.0',
                applicationLegalese:
                    'We are not Northwood and are not affiliated with them',
                applicationIcon: Icon(
                  Icons.info,
                ),
                dense: true,
                icon: Icon(Icons.info),
              ),
            ],
          ),
        ),
      );
    });
  }

  void selectMenu(int index) {
    selectPage(index);
    LauncherPage.scaffoldKey.currentState?.closeDrawer();
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      required this.color,
      this.leading,
      this.title,
      this.subtitle,
      this.onTap});

  final Color color;

  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      child: InkWell(
        onTap: onTap,
        enableFeedback: true,
        child: ListTile(
          enableFeedback: false,
          leading: leading,
          title: title,
          subtitle: subtitle,
        ),
      ),
    );
  }
}
