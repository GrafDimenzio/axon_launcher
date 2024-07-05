import 'package:axon_launcher/models/server_data.dart';
import 'package:axon_launcher/widgets/server.dart';
import 'package:axon_launcher/widgets/serverlist_button.dart';
import 'package:flutter/material.dart';

class ServerlistPage extends StatelessWidget {
  const ServerlistPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 40,
              top: 20
            ),
            child: Row(
              children: [
                ServerlistButton(title: 'Serverlist'),
                SizedBox(width: 10,),
                ServerlistButton(title: 'Favorites'),
                SizedBox(width: 10,),
                ServerlistButton(title: 'History'),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Serverlist:',
              style: TextStyle(
                fontSize: 40
              ),
            ),
          ),
          for(var i = 0; i < 50;i++)
            ServerWidget(serverData: ServerData(
              accessRestriction: false,
              friendlyFire: true,
              geoblocking: false,
              identifier: 'hadsjhkjahjiodfkjasokjdik',
              info: 'MyServer',
              ip: 'localhost',
              port: 7777,
              players: 0,
              maxPlayers: 20,
              pastebin: 'hgsfiduhsdfjknhsahjd',
              version: '13.5.0',
              whitelist: false,
            ),),
        ],
      ),
    );
  }
}
