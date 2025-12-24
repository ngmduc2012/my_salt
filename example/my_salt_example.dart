import 'package:my_salt/my_salt.dart';

void main() {
  final mySalt = MySalt();
  const String passphrase = "my_secure_password";
  const String originalText = "Hello, this is a secret message!";

  // Encrypt data
  String encryptedText = mySalt.encryptAESCryptoJS(originalText, passphrase);
  print("Encrypted Text: $encryptedText");

  // Decrypt data
  String decryptedText = mySalt.decryptAESCryptoJS(encryptedText, passphrase);
  print("Decrypted Text: $decryptedText");

  // Verify text
  bool isVerified = mySalt.verify(
    text: originalText,
    encrypted: encryptedText,
    passphrase: passphrase,
  );
  print("Verification Result: $isVerified");

  // Check if two encrypted texts are identical (they differ because the salt differs)
  String encryptedText2 = mySalt.encryptAESCryptoJS(originalText, passphrase);
  bool isEncryptedEqual = mySalt.verifyEncrypted(
    encrypted1: encryptedText,
    encrypted2: encryptedText2,
    passphrase: passphrase,
  );
  print("Are the encrypted texts equal? $isEncryptedEqual");
}
