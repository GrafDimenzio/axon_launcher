import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool? devMode = false;
  bool? ue = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
              hintText: 'Please select a SCPSL.exe that starts the Axon Client',
              constraints: BoxConstraints(maxWidth: 800)),
          initialValue: 'PLACEHOLDER',
          onFieldSubmitted: (value) {
            print(value);
          },
        ),
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
          initialValue: 'PLACEHOLDER',
          onFieldSubmitted: (value) {
            print(value);
          },
        ),
        SizedBox(
          width: 835,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text('Developer Mode'),
              value: devMode,
              onChanged: (value) {
                setState(() {
                  devMode = value;
                  if (devMode == false) {
                    ue = false;
                  }
                });
              },
            ),
          ),
        ),
        if (devMode == true)
          SizedBox(
            width: 835,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text('Unity Explorer'),
                value: ue,
                onChanged: (value) {
                  setState(() {
                    ue = value;
                  });
                },
              ),
            ),
          )
      ],
    );
  }
}
