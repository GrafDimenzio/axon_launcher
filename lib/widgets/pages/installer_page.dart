import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:axon_launcher/api/client_patcher.dart';
import 'package:axon_launcher/app_state.dart';
import 'package:axon_launcher/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class InstallerPage extends StatefulWidget {
  const InstallerPage({
    super.key,
  });

  @override
  State<InstallerPage> createState() => _InstallerPageState();
}

class _InstallerPageState extends State<InstallerPage> {
  String? scpExe;
  String? axon;

  List<String> versions = <String>['No Game Version found'];
  String? selectedVersion = 'No Game Version found';

  bool installtionInProgress = false;
  String? lastLog;

  void getVersions() {
    final url = Uri.parse(
        'https://raw.githubusercontent.com/AxonSL/SLClientPatches/main/versions.txt');
    http.get(url).then(
      (response) {
        setState(() {
          if (response.statusCode == 200) {
            versions = response.body.split('\n');
          }

          if (versions.isNotEmpty) {
            selectedVersion = versions[versions.length - 1];
          }
        });
      },
    );
  }

  void startClientInstallation(LauncherState state) {
    if (scpExe == null ||
        scpExe?.endsWith('SCPSL.exe') == false &&
            File(scpExe!).existsSync() == false) {
      setState(() {
        lastLog = 'You need to select a real SCPSL.exe';
      });
      return;
    }

    if (axon == null || axon!.isEmpty) {
      print('Is empty or null');
      setState(() {
        print('SetState');
        axon = path.join(Directory(path.dirname(scpExe!)).parent.path,
            'SCP Secret Laboratory Axon Client');
      });
    }

    setState(() {
      lastLog = 'Started Installation';
      installtionInProgress = true;
      state.setAllowPageSwitch(false);
    });

    patchClient(
      scpExe,
      axon,
      selectedVersion,
      (p0) {
        setState(() {
          lastLog = p0;
        });
      },
    ).then(
      (value) {
        setState(() {
          installtionInProgress = false;
          state.setAllowPageSwitch(true);

          if(value == false) return;
          if (state.settings == null || axon == null) return;
          state.settings!.axonClientPath = axon!;
          state.updateSettings();
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getVersions();
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<LauncherState>();
    final theme = Theme.of(context);
    //final sytle = widget.theme.textTheme.titleMedium!.copyWith(color: widget.theme.colorScheme.onSurface);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //Vanilla SCPSL.exe select
        Card(
          child: SizedBox(
            width: 820,
            height: 90,
            child: Column(
              children: [
                SizedBox(
                  width: 800,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8.0,
                      top: 3.0,
                    ),
                    child: Text('Vanilla SCPSL.exe Path'),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Please select a vanilla version of SCPSL.exe',
                      constraints: BoxConstraints(maxWidth: 800)),
                  initialValue: scpExe,
                  onChanged: (value) {
                    scpExe = value;
                  },
                ),
              ],
            ),
          ),
        ),

        //Axon Directory select
        Card(
          child: SizedBox(
            width: 820,
            height: 90,
            child: Column(
              children: [
                SizedBox(
                  width: 800,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8.0,
                      top: 3.0,
                    ),
                    child: Text('Axon Directory'),
                  ),
                ),
                TextFormField(
                  style: surfaceTextStyle,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText:
                          'Select in which Directory Axon should be installed or leave empty for default',
                      constraints: BoxConstraints(maxWidth: 800)),
                  initialValue: axon,
                  onChanged: (value) {
                    axon = value;
                  },
                ),
              ],
            ),
          ),
        ),

        //Version Select
        SizedBox(
          width: 800,
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Center(
                child: Text(
                    'Please select which Version of SCPSL you are patching')),
          ),
        ),
        SizedBox(
          width: 150,
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: DropdownButton(
              value: selectedVersion,
              isExpanded: true,
              dropdownColor: theme.colorScheme.tertiary,
              onChanged: (value) {
                setState(() {
                  if (versions.contains(value)) {
                    selectedVersion = value;
                  }
                });
              },
              items: versions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),

        //Patch Button
        if (selectedVersion != 'No Game Version found' &&
            installtionInProgress == false)
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: ElevatedButton(
                onPressed: () {
                  startClientInstallation(state);
                },
                child: Text(
                  'Start',
                  style: TextStyle(fontSize: 25),
                )),
          ),

        if (installtionInProgress)
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text('Installing SCP:SL Axon-Client'),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          ),

        if (lastLog != null) Text(lastLog!),
      ],
    );
  }
}
