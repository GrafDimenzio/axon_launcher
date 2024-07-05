import 'package:flutter/material.dart';

class VersionWidget extends StatelessWidget {
  const VersionWidget({
    super.key,
  });

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
            'Axon Launcher\nVersion 0.1.0 Alpha',
            textAlign: TextAlign.end,
          )
        ],
      ),
    );
  }
}
