import 'package:axon_launcher/app_state.dart';
import 'package:axon_launcher/widgets/account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var state = context.watch<LauncherState>();
    
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (var i = 0; i < 5; i++) Account(),
        ],
      ),
    );
  }
}
