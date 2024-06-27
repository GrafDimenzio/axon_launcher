import 'package:axon_launcher/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

const titleBarSize = 30.0;
const buttonSizes = 40.0;

class CustomTitleBar extends StatelessWidget {
  const CustomTitleBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        windowManager.startDragging();
      },
      child: Container(
        color: theme.colorScheme.tertiary,
        child: SizedBox(
          height: titleBarSize,
          child: Row(
            children: [
              Title(),
              MinimizeButton(),
              CloseButton()
            ],
          ),
        ),
      ),
    );
  }
}

class CloseButton extends StatefulWidget {
  const CloseButton({
    super.key,
  });

  @override
  State<CloseButton> createState() => _CloseButtonState();
}

class _CloseButtonState extends State<CloseButton> {
  var _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          windowManager.close();
        },
        child: Container(
          width: buttonSizes,
          color: _isHovered ? Colors.red : Colors.transparent,
          child: Center(
            child: Icon(Icons.close),
            ),
        ),
      ),
    );
  }
}

class MinimizeButton extends StatefulWidget {
  const MinimizeButton({
    super.key,
  });

  @override
  State<MinimizeButton> createState() => _MinimizeButtonState();
}

class _MinimizeButtonState extends State<MinimizeButton> {
  var _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          windowManager.minimize();
        },
        child: Container(
          color: _isHovered ? theme.colorScheme.surfaceContainer : Colors.transparent,
          width: buttonSizes,
          child: Center(
            child: Icon(Icons.minimize),
          ),
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          ),
        child: Text(''),
      ),
    );
  }
}