import 'package:t_jwt/t_jwt.dart';

void main() {
  JWT jwt = JWT('secret');

  Map<String, String> header = {
    'alg': 'HS256',
    'typ': 'JWT'
  };

  Map<String, String>  payload = {
    'name': 'Topography Digital',
    'username': 'topography.digital',
  };

  DateTime expiresAt = DateTime.now().add(Duration(days: 1));

  String signed = jwt.sign(header, payload, expiresAt);

  bool isVerified = jwt.verify(signed);

  print(signed);
  print(isVerified);
}
