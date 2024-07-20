class ModInfo {
  ModInfo({
    required this.name,
    required this.version,
  });

  String name;
  String version ;

    Map<String, dynamic> toJson() {
    return {
      'name': name,
      'version': version,
    };
  }

  factory ModInfo.fromJson(Map<String, dynamic> json) {
    return ModInfo(
      name: json['name'],
      version: json['version'],
    );
  }
}