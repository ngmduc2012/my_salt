[![codecov](https://codecov.io/gh/ngmduc2012/my_salt/branch/main/graph/badge.svg)](https://codecov.io/gh/ngmduc2012/my_salt)
[![GitHub](https://img.shields.io/badge/Nguyen_Duc-GitHub-black?logo=github)](https://github.com/ngmduc2012)
_[![Buy Me A Coffee](https://img.shields.io/badge/Donate-Buy_Me_A_Coffee-blue?logo=buymeacoffee)](https://www.buymeacoffee.com/ducmng12g)_
_[![PayPal](https://img.shields.io/badge/Donate-PayPal-blue?logo=paypal)](https://paypal.me/ngmduc)_
_[![Sponsor](https://img.shields.io/badge/Sponsor-Become_A_Sponsor-blue?logo=githubsponsors)](https://github.com/sponsors/ngmduc2012)_
_[![Support Me on Ko-fi](https://img.shields.io/badge/Donate-Ko_fi-red?logo=ko-fi)](https://ko-fi.com/I2I81AEJG8)_  

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

### Generate a secure passphrase
Use the encrypt CLI to generate a strong passphrase:

```sh
flutter pub global activate encrypt
secure-random
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
- For bug reports and contributions, visit the GitHub repository https://github.com/ngmduc2012/my_salt.git.
- If you want to know what i do in package, checking my document here https://wong-coupon.gitbook.io/flutter/security/salt

## Contribution
If you have any suggestions or find any issues, feel free to open an issue or submit a pull request on [GitHub](https://github.com/ngmduc2012/my_salt).

## Developer Team:
[ThaoDoan](https://github.com/mia140602) and [DucNguyen](https://github.com/ngmduc2012)

[Buy Us A Coffee ❤️](https://buymeacoffee.com/ducmng12g) | [Support Us on Ko-fi ❤️](https://ko-fi.com/I2I81AEJG8)
