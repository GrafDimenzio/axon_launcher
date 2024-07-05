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
  });

  final String version; //y
  final String info;    //y
  final String pastebin;//d -

  final bool geoblocking;//y -
  final bool whitelist;//y -
  final bool accessRestriction;//y -

  final bool friendlyFire;//y
  final int players;//y
  final int maxPlayers;//y

  final String ip;//d -
  final int port;//d -
  final String identifier;//d -

  String getServerUnique() {
    return '$identifier-$ip-$port';
  }
  
  Map<String, dynamic> toJson() {
    return {
      'Version': version,
      'Info': info,
      'Pastebin': pastebin,
      'Geoblocking': geoblocking,
      'Whitelist': whitelist,
      'AccessRestriction': accessRestriction,
      'FriendlyFire': friendlyFire,
      'Players': players,
      'MaxPlayers': maxPlayers,
      'Ip': ip,
      'Port': port,
      'Identifier': identifier,
    };
  }

  factory ServerData.fromJson(Map<String, dynamic> json) {
    return ServerData(
      version: json['Version'],
      info: json['Info'],
      pastebin: json['Pastebin'],
      geoblocking: json['Geoblocking'],
      whitelist: json['Whitelist'],
      accessRestriction: json['AccessRestriction'],
      friendlyFire: json['FriendlyFire'],
      players: json['Players'],
      maxPlayers: json['MaxPlayers'],
      ip: json['Ip'],
      port: json['Port'],
      identifier: json['Identifier'],
    );
  }
}