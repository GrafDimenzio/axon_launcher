import 'package:flutter/material.dart';

class VersionWidget extends StatelessWidget {
  const VersionWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return Positioned(
    right: 16,
    top: 16,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Axon Launcher\nVersion 1.0.0',
          textAlign: TextAlign.end,
        )
      ],
    ),
            );
  }
}