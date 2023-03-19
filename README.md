<img src="https://i.ibb.co/Qb1X5ZJ/JWT.png"
alt="JWT library icon"
style="height: 100px; width: 100px;" />

# Json Web Token (JWT) library for Dart
Meant for usage in our web server library but also perfectly suitable for usage independently. Files issues <a href="https://github.com/akula-shark/t-jwt/issues">here</a> and see pub.dev page <a href="https://pub.dev/packages/t_jwt">here</a>



## Limitations
- Currently only supports HS256 algorithm
- Not verified to be safe for production
- Not 100% compliant with the JWT standard yet

## Getting started

### Add dependency
```
$ dart pub add t_jwt
```
or add it manually to your `pubspec.yaml` file:
```yaml
dependencies:
  t_jwt: ^replace-with-latest-version
```
### Example usage:
```dart
import 'package:t_jwt/t_jwt.dart';

void main() {
  JWT jwt = JWT('your-secret-here');

  Map<String, String> header = {
    'alg': 'HS256',
    'typ': 'JWT'
  };

  Map<String, String> payload = {
    'name': 'Topography Digital',
    'username': 'topography.digital',
  };

  DateTime expiresAt = DateTime.now().add(Duration(days: 1));

  String signed = jwt.sign(header, payload, expiresAt);

  bool isVerified = jwt.verify(signed);
  
  // The token
  print(signed);
  
  // True or false depending on if the token is valid
  print(isVerified);
}
```
