import 'dart:convert';

import 'package:axon_launcher/models/mod_info.dart';

class ServerData {
  const ServerData({
    required this.version,
    required this.info,
    required this.pastebin,
    required this.geoblocking,
    required this.whitelist,
    required this.accessRestriction,
    required this.friendlyFire,
    required this.players,
    required this.maxPlayers,
    required this.ip,
    required this.port,
    required this.identifier,
    required this.playerList,
    required this.mods,
  });

  final String version;
  final String info;
  final String pastebin;

  final bool geoblocking;
  final bool whitelist;
  final bool accessRestriction;

  final bool friendlyFire;
  final int players;
  final int maxPlayers;
  final List<String> playerList;

  final List<ModInfo> mods;

  final String ip;
  final int port;
  final String identifier;

  String getServerUnique() {
    return '$identifier-$ip-$port';
  }
  
  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'info': info,
      'pastebin': pastebin,

      'geoblocking': geoblocking,
      'whitelist': whitelist,
      'accessRestriction': accessRestriction,

      'friendlyFire': friendlyFire,
      'players': players,
      'maxPlayers': maxPlayers,
      'playerList': playerList,

      'mods': mods,

      'ip': ip,
      'port': port,
      'identifier': identifier,
    };
  }

  factory ServerData.fromJson(Map<String, dynamic> json) {
    List<dynamic> playerList = json['playerList'];
    List<dynamic> modList = json['mods'];
    return ServerData(
      version: json['version'],
      info: utf8.decode(base64Decode(json['info'].toString())),
      pastebin: json['pastebin'],

      geoblocking: json['geoblocking'],
      whitelist: json['whitelist'],
      accessRestriction: json['accessRestriction'],

      friendlyFire: json['friendlyFire'],
      players: json['players'],
      maxPlayers: json['maxPlayers'],
      playerList: playerList.map((e) => e.toString(),).toList(),

      mods: modList.map((e) => ModInfo.fromJson(e),).toList(),

      ip: json['ip'],
      port: json['port'],
      identifier: json['identifier'],
    );
  }
}