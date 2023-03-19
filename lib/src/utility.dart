import 'dart:convert';

String base64UrlEncodeWithoutPadding(List<int> bytes) {
  var encoded = base64Url.encode(bytes);
  return encoded.replaceAll('=', '');
}
