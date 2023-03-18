import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

String base64UrlEncodeWithoutPadding(List<int> bytes) {
  var encoded = base64Url.encode(bytes);
  return encoded.replaceAll('=', '');
}
