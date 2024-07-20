import 'package:axon_launcher/states/settings_state.dart';
import 'package:axon_launcher/theme/theme_manager.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var state = SettingsState.singleton;
    return ListenableBuilder(
      listenable: state,
      builder: (context, child) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Axon Client Path
          SizedBox(
            width: 800,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text('Axon Client Path'),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText:
                    'Please select a SCPSL.exe that starts the Axon Client',
                constraints: BoxConstraints(maxWidth: 800)),
            initialValue: state.settings?.axonClientPath,
            onFieldSubmitted: (value) {
              if (state.settings == null) return;
              state.settings!.axonClientPath = value;
              state.updateSettings();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Updated client path to: $value')));
            },
          ),
          //Mods Path
          SizedBox(
            width: 800,
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text('Mods Path'),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText:
                    'Select the Directory in which mods for various servers will be stored',
                constraints: BoxConstraints(maxWidth: 800)),
            initialValue: state.settings?.modsPath,
            onFieldSubmitted: (value) {
              if (state.settings == null) return;
              state.settings!.modsPath = value;
              state.updateSettings();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Updated mods path to: $value')));
            },
          ),
          //Serverlist
          SizedBox(
            width: 800,
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text('Serverlist'),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText:
                    'The serverlist that should be used',
                constraints: BoxConstraints(maxWidth: 800)),
            initialValue: state.settings?.serverList,
            onFieldSubmitted: (value) {
              if (state.settings == null) return;
              state.settings!.serverList = value;
              state.updateSettings();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Updated serverlist to: $value')));
            },
          ),
          //DevMode Checkbox
          SizedBox(
            width: 835,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text('Developer Mode'),
                value: state.settings?.devMode,
                onChanged: (value) async {
                  if (value == true) {
                    var confirmed = await _showDevDialog(context);
                    if (confirmed) {
                      if (state.settings == null) return;
                      state.settings!.devMode = true;
                      state.updateSettings();
                    }
                  } else {
                    if (state.settings == null) return;
                    state.settings!.devMode = false;
                    state.settings!.ue = false;
                    state.updateSettings();
                  }
                },
              ),
            ),
          ),
          //Unity Explorer Checkbox
          if (state.settings?.devMode == true)
            SizedBox(
              width: 835,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text('Unity Explorer'),
                  value: state.settings?.ue,
                  onChanged: (value) {
                    if (state.settings == null) return;
                    state.settings!.ue = value!;
                    state.updateSettings();
                  },
                ),
              ),
            )
        ],
      ),
    );
  }

  Future<bool> _showDevDialog(BuildContext context) async {
    var style = primaryTextStyle;
    var success = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Developer Mode'),
          content: Text(
              'We don\'t recommend you to enable Dev mode since Servers are able to install unverified mods.\nOnly enable it when you know what you are doing!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                'Confirm',
                style: style,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'Abort',
                style: style,
              ),
            ),
          ],
        );
      },
    );
    return success!;
  }
}
