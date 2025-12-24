# MySalt Usage (Short)

## 1) Add dependency

```yaml
dependencies:
  my_salt: ^1.0.1+3
```

## 2) Import and create instance

```dart
import 'package:my_salt/my_salt.dart';

final mySalt = MySalt();
const passphrase = 'my_secure_password';
```

## 3) Encrypt

```dart
final encrypted = mySalt.encryptAESCryptoJS('Hello', passphrase);
```

## 4) Decrypt

```dart
final decrypted = mySalt.decryptAESCryptoJS(encrypted, passphrase);
```

## 5) Verify

```dart
final ok = mySalt.verify(
  text: 'Hello',
  encrypted: encrypted,
  passphrase: passphrase,
);
```
