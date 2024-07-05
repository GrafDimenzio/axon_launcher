import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:axon_launcher/api/account_api.dart';

class Account {
  Account({
    required this.userName,
    required this.identity,
    required this.file,
  }) {
    userId = identity == 'pending' ? identity : getUserId(base64Decode(identity));
  }

  File file;
  String userName;
  String identity;

  String userId = '';

  void setIdentity(Uint8List bytes) {
    identity = base64Encode(bytes);
  }

  Uint8List getIdentity() {
    return base64Decode(identity);
  }

  Future<void> saveToFile() async {
    var json = jsonEncode(this);
    await file.writeAsString(json);
  }

  Map<String, dynamic> toJson() {
    return {
      'identity': identity,
      'username': userName,
    };
  }
}
