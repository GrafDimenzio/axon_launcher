class Settings {
  Settings({
    required this.devMode,
    required this.ue,
    required this.axonClientPath,
    required this.modsPath
  });

  bool devMode = false;
  bool ue = false;
  String axonClientPath = '';
  String modsPath = '';

  Map<String, dynamic> toJson() {
    return {
      'devMode': devMode,
      'ue': ue,
      'axonClientPath': axonClientPath,
      'modsPath': modsPath
    };
  }

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      devMode: json['devMode'],
      ue: json['ue'],
      axonClientPath: json['axonClientPath'],
      modsPath: json['modsPath']
    );
  }
}