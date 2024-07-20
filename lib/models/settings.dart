class Settings {
  Settings({
    required this.devMode,
    required this.ue,
    required this.axonClientPath,
    required this.modsPath,
    required this.serverList,
  });

  bool devMode = false;
  bool ue = false;
  String axonClientPath = '';
  String modsPath = '';
  String serverList = '';

  Map<String, dynamic> toJson() {
    return {
      'devMode': devMode,
      'ue': ue,
      'axonClientPath': axonClientPath,
      'modsPath': modsPath,
      'serverList': serverList,
    };
  }

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      devMode: json['devMode'],
      ue: json['ue'],
      axonClientPath: json['axonClientPath'],
      modsPath: json['modsPath'],
      serverList: json['serverList'],
    );
  }
}