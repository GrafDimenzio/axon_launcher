import 'package:axon_launcher/theme/theme_manager.dart';
import 'package:flutter/material.dart';

class ServerlistButton extends StatelessWidget {
  const ServerlistButton({
    super.key,
    required this.title
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 30
    );
    return Material(
      color: theme.primaryColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        onTap: () {
          print('TAP');
        },
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            title,
            style: textStyle,
          ),
        )
      )
    );
  }
}