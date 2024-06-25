import 'package:axon_launcher/widgets/launcher_page.dart';
import 'package:flutter/material.dart';

class DisplayButtonWidget extends StatelessWidget {
  const DisplayButtonWidget({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      top: 16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(90),
            child: Container(
              color: theme.colorScheme.secondary,
              width: 48,
              height: 48,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_sharp),
                onPressed: () {
                  LauncherPage.scaffoldKey.currentState?.openDrawer();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}