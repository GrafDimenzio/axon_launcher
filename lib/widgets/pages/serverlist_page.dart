import 'dart:math';

import 'package:axon_launcher/models/server_data.dart';
import 'package:axon_launcher/widgets/server.dart';
import 'package:axon_launcher/widgets/serverlist_button.dart';
import 'package:flutter/material.dart';

class ServerlistPage extends StatefulWidget {
  const ServerlistPage({
    super.key,
  });

  @override
  State<ServerlistPage> createState() => _ServerlistPageState();
}

class _ServerlistPageState extends State<ServerlistPage> {
  int state = 0;

  List<String> servers = <String>['Official','Third Party'];
  String? selectedServer = 'Official';

  String currentSearch = '';

  //DEBUG

  List<ServerData> serverList = List<ServerData>.empty(growable: true);
  @override
  void initState() {
    List<String> words = ['scp', 'scpsl', 'server', 'ger', 'german', 'modded', 'Foundation'];
    for (var i = 0; i < 50; i++) {
      var name = '';

      for(var i = 0; i< 5; i++) {
        name += '${words[Random().nextInt(words.length)]} ';
      }
      serverList.add(ServerData(
        accessRestriction: false,
        friendlyFire: true,
        geoblocking: false,
        identifier: 'hadsjhkjahjiodfkjasokjdik',
        info: name,
        ip: 'localhost',
        port: 7777,
        players: 0,
        maxPlayers: 20,
        pastebin: 'hgsfiduhsdfjknhsahjd',
        version: '13.5.0',
        whitelist: false,
      ));
    }
    super.initState();
  }
  //End Debug

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    var list = serverList;
    if(currentSearch.isEmpty == false) {
      list = list.where((element) => element.info.toLowerCase().contains(currentSearch.toLowerCase()),).toList();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 40,
            top: 20
          ),
          child: Row(
            children: [
              ServerlistButton(
                title: 'Serverlist',
                onTap: () {
                  setState(() {
                    state = 0;
                  });
                },
              ),
              SizedBox(width: 10,),
              ServerlistButton(
                title: 'Favorites',
                onTap: () {
                  setState(() {
                    state = 1;
                  });
                },
              ),
              SizedBox(width: 10,),
              ServerlistButton(
                title: 'History',
                onTap: () {
                  setState(() {
                    state = 2;
                  });
                },
              ),
            ],
          ),
        ),
        if(state == 0)
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 20),
            child: Row(
              children: [
                DropdownButton(
                  dropdownColor: theme.colorScheme.tertiary,
                  value: selectedServer,
                  onChanged: (value) {
                    setState(() {
                      if (servers.contains(value)) {
                        selectedServer = value;
                      }
                    });
                  },
                  items:
                      servers.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
    
        Padding(
          padding: const EdgeInsets.only(left: 40,bottom: 10),
          child: Row(
            children: [
              SizedBox(
                width: 200,
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      currentSearch = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Server Search'
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
            width: 820,
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ServerWidget(serverData: list[index]);
              },
            ),
          ),
        )
      ],
    );
  }
}
