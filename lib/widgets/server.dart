import 'package:axon_launcher/api/client_interact.dart';
import 'package:axon_launcher/models/server_data.dart';
import 'package:flutter/material.dart';

class ServerWidget extends StatelessWidget {
  const ServerWidget({
    super.key,
    required this.serverData,
  });

  final ServerData serverData;
  static const double dividerSize = 10;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              height: 80,
              width: 800,
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(serverData.info),
                      ),
                      Row(
                        children: [
                          Text('${serverData.players}/${serverData.maxPlayers}'),
                          SizedBox(width: dividerSize),
                          Text(serverData.version),
                          SizedBox(width: dividerSize),
                          if(serverData.friendlyFire)
                          Tooltip(
                            waitDuration: Duration(milliseconds: 500),
                            message: 'This Server has FriendlyFire enabled',
                            child: Text('FF')
                          ),
                        ],
                      )
                    ],
                  )),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            launchClient(ip: '${serverData.ip}:${serverData.port}');
                            _showLaunchDialog(context);
                          },
                          icon: Icon(Icons.arrow_right)
                        ),
                      //Favorite Button
                      IconButton(
                        onPressed: () {

                        },
                        icon: Icon(Icons.favorite_border)
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }

    Future<void> _showLaunchDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text('Game launched'),
          content: Text('Please wait a moment'),
        );
      },
    );
  }
}
