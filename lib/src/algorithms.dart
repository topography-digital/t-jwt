import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

class Algorithms {

  /// Takes base64 encoded header and payload and signs them using HS256.
  static Uint8List hs256(String secret, String header, String payload) {

    // Create a HMAC-SHA256 signature String
    String signature = '$header.$payload';

    // Convert the signature String to a Uint8List
    List<int> utf8signature = utf8.encode(signature);

    // UTF-8 encode the secret
    List<int> secretBytes = utf8.encode(secret);

    // Create new HMAC-SHA256 Object
    Hmac hmacSha256 = Hmac(sha256, secretBytes);

    // Create a Digest Object from the UTF-8 encoded signature
    Digest digest = hmacSha256.convert(utf8signature);

    // Convert the Digest bytes to a Uint8List
    return Uint8List.fromList(digest.bytes);
  }
}




