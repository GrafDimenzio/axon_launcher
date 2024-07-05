import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:axon_launcher/app_state.dart';
import 'package:axon_launcher/models/account.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:base58check/base58.dart' as base58;
import 'package:path/path.dart' as path;

String getUserIdFromFullKey(Uint8List identity) {
  return getUserId(identity.sublist(32,97));
}

String getUserId(Uint8List identityPublic) {
  final hash = crypto.sha256.convert(identityPublic).bytes;
  final encoder = base58.Base58Encoder('123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz');
  final base58Hash = encoder.convert(hash);
  return '$base58Hash@axon';
}

Future<Account?> readAccountFromPath(String path) async {
  return await readAccountFromFile(File(path));
}

Future<Account?> readAccountFromFile(File file) async {
  if(await file.exists() == false) return null;

  final jsonString = await file.readAsString();
  final data = json.decode(jsonString);

  final identityString = data['identity'];
  final userName = data['username'];

  return Account(userName: userName, identity: identityString, file: file);
}

Future<String?> getNewAccountPath(String userName) async {
  final directory = LauncherState.singleton?.accountDirectory;
  if(directory == null) return null;
  var counter = 0;
  File? file;
  do {
    file = File(path.join(directory.path,'$userName${counter > 0 ? counter : ''}.json'));
  } while (await file.exists());

  return file.path;
}