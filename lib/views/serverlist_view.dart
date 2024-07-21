import 'dart:convert';

import 'package:axon_launcher/models/server_data.dart';
import 'package:axon_launcher/states/serverlist_state.dart';
import 'package:axon_launcher/states/settings_state.dart';
import 'package:axon_launcher/widgets/server.dart';
import 'package:axon_launcher/widgets/serverlist_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ServerlistView extends StatefulWidget {
  const ServerlistView({
    super.key,
  });

  @override
  State<ServerlistView> createState() => _ServerlistViewState();
}

class _ServerlistViewState extends State<ServerlistView> {
  int pageState = 0;
  bool isLoading = false;
  String errorMessage = "";

  String currentSearch = '';
  List<ServerData> serverList = List<ServerData>.empty(growable: true);

  @override
  void initState() {
    _getServers();
    super.initState();
  }

  Future<void> _getServers() async {
    setState(() {
      isLoading = true;
      serverList.clear();
      errorMessage = "";
    });
    final settings = SettingsState.singleton.settings;
    if(settings == null) return;

    final response = await http.get(Uri.parse(settings.serverList));
    if(response.statusCode != 200) {
      setState(() {
        errorMessage = response.reasonPhrase ?? '';
      });
      return;
    }

    final List json = jsonDecode(response.body);
    setState(() {
      isLoading = false;
      serverList = json.map((e) => ServerData.fromJson(e)).toList();
    });
  }

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
              ElevatedButton(
                onPressed: () {
                  _getServers();
                },
                child: Text('Refresh')
              )
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
            width: 820,
            child: errorMessage.isNotEmpty ? Center(child: Text(errorMessage)) :
            (isLoading ? 
            Center(child: CircularProgressIndicator(color: theme.colorScheme.onSurface,)) :
            ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ServerWidget(serverData: list[index]);
              },
            )),
          ),
        )
      ],
    );
  }
}
