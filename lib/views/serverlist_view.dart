import 'dart:math';

import 'package:axon_launcher/models/server_data.dart';
import 'package:axon_launcher/states/serverlist_state.dart';
import 'package:axon_launcher/widgets/server.dart';
import 'package:axon_launcher/widgets/serverlist_button.dart';
import 'package:flutter/material.dart';

class ServerlistView extends StatefulWidget {
  const ServerlistView({
    super.key,
  });

  @override
  State<ServerlistView> createState() => _ServerlistViewState();
}

class _ServerlistViewState extends State<ServerlistView> {
  int pageState = 0;

  List<String> servers = <String>['Official', 'Third Party'];
  String? selectedServer = 'Official';

  String currentSearch = '';

  //DEBUG
  List<ServerData> serverList = List<ServerData>.empty(growable: true);
  @override
  void initState() {
    List<String> words = [
      'scp',
      'scpsl',
      'server',
      'ger',
      'german',
      'modded',
      'Foundation'
    ];
    for (var i = 0; i < 50; i++) {
      var name = '';

      for (var i = 0; i < 5; i++) {
        name += '${words[Random().nextInt(words.length)]} ';
      }

      var alphabet = '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz';
      var iden = '';
      for (var i = 0; i < 20; i++) {
        iden += '${alphabet[Random().nextInt(alphabet.length)]} ';
      }

      serverList.add(ServerData(
        accessRestriction: false,
        friendlyFire: true,
        geoblocking: false,
        identifier: iden,
        info: name,
        ip: 'main.dimenzio.me',
        port: 25576,
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
    final state = ServerlistState.singleton;
    final theme = Theme.of(context);

    var list = serverList;
    if (currentSearch.isEmpty == false) {
      list = list
          .where(
            (element) => element.info
                .toLowerCase()
                .contains(currentSearch.toLowerCase()),
          )
          .toList();
    }

    switch (pageState) {
      case 1:
        list = list
            .where(
              (element) => state.favorites.contains(element.getServerUnique()),
            )
            .toList();

      case 2:
        list = list
            .where(
              (element) => state.history.contains(element.getServerUnique()),
            )
            .toList();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 40, top: 20),
          child: Row(
            children: [
              ServerlistButton(
                title: 'Serverlist',
                onTap: () {
                  setState(() {
                    pageState = 0;
                  });
                },
              ),
              SizedBox(
                width: 10,
              ),
              ServerlistButton(
                title: 'Favorites',
                onTap: () {
                  setState(() {
                    pageState = 1;
                  });
                },
              ),
              SizedBox(
                width: 10,
              ),
              ServerlistButton(
                title: 'History',
                onTap: () {
                  setState(() {
                    pageState = 2;
                  });
                },
              ),
            ],
          ),
        ),
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
                items: servers.map<DropdownMenuItem<String>>((String value) {
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
          padding: const EdgeInsets.only(left: 40, bottom: 10),
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
                  decoration: InputDecoration(hintText: 'Server Search'),
                ),
              ),
              SizedBox(
                width: 500,
              ),
              ElevatedButton(onPressed: () {}, child: Text('Refresh'))
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
