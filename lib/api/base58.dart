import 'package:base58check/base58.dart';

String _alphabet = '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz';

String base58Encode(List<int> bytes) {
  var encoder = Base58Encoder(_alphabet);
  return encoder.convert(bytes);
}

List<int> base58Decode(String encoded) {
  var decoder = Base58Decoder(_alphabet);
  return decoder.convert(encoded);
}