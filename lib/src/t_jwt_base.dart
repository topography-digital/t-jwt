// DART
import 'dart:convert';
import 'dart:typed_data';

// FILES
import 'utility.dart';
import 'algorithms.dart';

class JWT {
  static final JWT _jwt = JWT._internal();

  String secret = 'secret';

  factory JWT() {
    return _jwt;
  }

  JWT._internal();

  String sign(Map<String, String> header, Map<String, String> payload,
      DateTime expiresAt) {
    try {
      // Add the expiration date to the payload
      payload['exp'] = expiresAt.millisecondsSinceEpoch.toString();

      // JSON encode the header and payload
      String jsonEncodedHeader = json.encode(header);
      String jsonEncodedPayload = json.encode(payload);

      // Encode the JSON strings to UTF-8
      List<int> headerEncode = utf8.encode(jsonEncodedHeader);
      List<int> payloadEncode = utf8.encode(jsonEncodedPayload);

      // Base64 encode the UTF-8 encoded header & payload
      String headerBase64 = base64UrlEncodeWithoutPadding(headerEncode);
      String payloadBase64 = base64UrlEncodeWithoutPadding(payloadEncode);

      // HS256 sign the Base64 encoded header & payload
      Uint8List hmacDigestBytes =
          Algorithms.hs256(secret, headerBase64, payloadBase64);

      // Base64 encode the Digest bytes Uint8List
      String signatureBase64 = base64UrlEncodeWithoutPadding(hmacDigestBytes);

      // Return the JWT
      return '$headerBase64.$payloadBase64.$signatureBase64';
    } catch (e) {
      throw Exception('Error signing JWT: $e');
    }
  }

  bool verify(String jwt) {
    try {
      // Split the JWT into 3 parts
      List<String> inputJwtParts = jwt.split('.');
      if (inputJwtParts.length != 3) {
        throw Exception('JWT must have 3 parts');
      }

      // Get the header, payload, and signature from the input JWT
      String inputJwtHeaderBase64 = inputJwtParts[0];
      String inputJwtPayloadBase64 = inputJwtParts[1];
      String inputJwtSignatureBase64 = inputJwtParts[2];

      // HS256 sign the Base64 encoded header & payload
      Uint8List hmacDigestBytes =
          Algorithms.hs256(secret, inputJwtHeaderBase64, inputJwtPayloadBase64);

      // Base64 encode the Digest bytes Uint8List
      String verificationSignature =
          base64UrlEncodeWithoutPadding(hmacDigestBytes);

      if (inputJwtSignatureBase64 == verificationSignature) {
        return true;
      } else {
        throw Exception('JWT is not valid due to invalid signature');
      }
    } catch (e) {
      throw Exception('Error verifying JWT: $e');
    }
  }
}
