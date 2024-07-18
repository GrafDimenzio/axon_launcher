import 'dart:convert';
import 'dart:io';
import 'package:axon_launcher/api/base58.dart';
import 'package:axon_launcher/api/io.dart';
import 'package:axon_launcher/models/account.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:path/path.dart' as path;

String getUserIdFromFullKey(List<int> identity) {
  return getUserId(identity.sublist(32,97));
}

String getUserId(List<int> identityPublic) {
  final hash = crypto.sha256.convert(identityPublic).bytes;
  return '${base58Encode(hash)}@axon';
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
  final directory = accountDirectory;
  if(directory == null) return null;
  var counter = 0;
  File? file;
  do {
    file = File(path.join(directory.path,'$userName${counter > 0 ? counter : ''}.json'));
  } while (await file.exists());

  return file.path;
}