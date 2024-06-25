import 'package:flutter/material.dart';

class ServerlistPage extends StatelessWidget {
  const ServerlistPage({ 
    super.key,
  required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 800,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text('Test'),
            ),
          ),
        ],
      );
  }
}