import 'package:flutter/material.dart';

class ServerlistButton extends StatelessWidget {
  const ServerlistButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = TextStyle(
      fontSize: 30
    );
    return Material(
      color: theme.primaryColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        onTap: () {
          onTap();
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