
# MySalt - AES Encryption & Decryption

## Features
- AES encryption and decryption with a secure passphrase.
- Uses a salt mechanism to ensure different encrypted outputs.
- Provides functions to verify encrypted data.

## Getting started
### Prerequisites
Ensure you have Flutter installed and add the required dependencies in your `pubspec.yaml` file:

```yaml
dependencies:
  my_salt: ^1.0.0
```

Run the following command to install dependencies:

```sh
flutter pub get
```

## Usage
### 1. Import Required Packages

```dart
import 'package:my_salt/my_salt.dart';
```

### 2. Initialize MySalt

```dart
final mySalt = MySalt();
const String passphrase = "my_secure_password";
const String originalText = "Hello, this is a secret message!";
```

### 3. Encrypt Data

```dart
String encryptedText = mySalt.encryptAESCryptoJS(originalText, passphrase);
print("Encrypted Text: $encryptedText");
```

### 4. Decrypt Data

```dart
String decryptedText = mySalt.decryptAESCryptoJS(encryptedText, passphrase);
print("Decrypted Text: $decryptedText");
```

### 5. Verify Data

```dart
bool isVerified = mySalt.verify(
  text: originalText,
  encrypted: encryptedText,
  passphrase: passphrase,
);
print("Verification Result: $isVerified");
```

### 6. Check If Two Encrypted Texts Are Identical

```dart
String encryptedText2 = mySalt.encryptAESCryptoJS(originalText, passphrase);
bool isEncryptedEqual = mySalt.verifyEncrypted(
  encrypted1: encryptedText,
  encrypted2: encryptedText2,
  passphrase: passphrase,
);
print("Are the encrypted texts equal? $isEncryptedEqual");
```

## Additional information
- **Salt ensures that the encrypted output is different each time.**
- **To decrypt correctly, you must use the same passphrase that was used for encryption.**
- For bug reports and contributions, visit the GitHub repository (TODO: Add repository link).

[![Buy Me A Coffee](https://cdn.buymeacoffee.com/buttons/v2/default-orange.png)](https://buymeacoffee.com/ducmng12g)

[![Support Me on Ko-fi](https://storage.ko-fi.com/cdn/kofi6.png?v=6)](https://ko-fi.com/I2I81AEJG8)