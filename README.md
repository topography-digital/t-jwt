<img src="https://i.ibb.co/Qb1X5ZJ/JWT.png"
alt="JWT library icon"
style="height: 100px; width: 100px;" />

## Is this library safe for production?
Not yet. This will be updated when it eventually is tested and verified by a third-party. Some features are entirely unfinished or not working.

## What is a JWT?

JWT stands for JSON Web Token, which is a compact and secure way to transmit data between parties in a JSON format. JWTs are used for authentication and authorization purposes and consist of three parts: a header, a payload, and a signature. The header contains information about the algorithm used to sign the token, the payload contains the user's data or claims, and the signature is used to verify the token's authenticity. JWTs are commonly used in web applications, APIs, and mobile applications.

A JWT Looks roughly like:
xxxxx.yyyyy.zzzzz

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
  JWT jwt = JWT();

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
