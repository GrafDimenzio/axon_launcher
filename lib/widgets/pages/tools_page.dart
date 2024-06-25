import 'package:flutter/material.dart';

class ToolsPage extends StatelessWidget {
  const ToolsPage({ 
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text('Tools')
        ],
      );
  }
}