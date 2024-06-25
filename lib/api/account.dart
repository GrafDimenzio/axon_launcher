import 'dart:math';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:base58check/base58.dart' as base58;

Uint8List createIdentity() {
  final buf = Uint8List(97);

  // Define the elliptic curve
  final ecDomainParameters = ECDomainParameters('secp256k1');

  // Initialize the key pair generator
  final generator = ECKeyGenerator();
  final keyGenParams = ECKeyGeneratorParameters(ecDomainParameters);
  final secureRandom = FortunaRandom();

  // Seed the random number generator
  final random = Random.secure();
  final seeds = List<int>.generate(32, (_) => random.nextInt(256));
  secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));

  generator.init(ParametersWithRandom(keyGenParams, secureRandom));

  // Generate the key pair
  final pair = generator.generateKeyPair();
  final privateKey = pair.privateKey as ECPrivateKey;
  final publicKey = pair.publicKey as ECPublicKey;

  // Copy the private key and public key to the buffer
  final privateKeyBytes = privateKey.d!.toRadixString(16).padLeft(64, '0');
  final privateKeyBytesUint8List = _hexToBytes(privateKeyBytes);
  buf.setRange(0, 32, privateKeyBytesUint8List);

  final publicKeyBytes = publicKey.Q!.getEncoded(false);
  buf.setRange(32, 97, publicKeyBytes);

  return buf;
}

Uint8List _hexToBytes(String hex) {
  final result = Uint8List(hex.length ~/ 2);
  for (int i = 0; i < hex.length; i += 2) {
    final byte = hex.substring(i, i + 2);
    result[i ~/ 2] = int.parse(byte, radix: 16);
  }
  return result;
}

String getUserIdFromFullKey(Uint8List identity) {
  return getUserId(identity.sublist(32,97));
}

String getUserId(Uint8List identityPublic) {
  final hash = crypto.sha256.convert(identityPublic).bytes;
  final encoder = base58.Base58Encoder('123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz');
  final base58Hash = encoder.convert(hash);
  return '$base58Hash@axon';
}