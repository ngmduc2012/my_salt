import 'package:my_salt/my_salt.dart';

void main() {
  final mySalt = MySalt();
  const String passphrase = "my_secure_password";
  const String originalText = "Hello, this is a secret message!";

  // Mã hóa dữ liệu
  String encryptedText = mySalt.encryptAESCryptoJS(originalText, passphrase);
  print("Encrypted Text: $encryptedText");

  // Giải mã dữ liệu
  String decryptedText = mySalt.decryptAESCryptoJS(encryptedText, passphrase);
  print("Decrypted Text: $decryptedText");

  // Xác minh văn bản
  bool isVerified = mySalt.verify(
    text: originalText,
    encrypted: encryptedText,
    passphrase: passphrase,
  );
  print("Verification Result: $isVerified");

  // Kiểm tra hai bản mã hóa có giống nhau không (chúng sẽ khác nhau do salt khác nhau)
  String encryptedText2 = mySalt.encryptAESCryptoJS(originalText, passphrase);
  bool isEncryptedEqual = mySalt.verifyEncrypted(
    encrypted1: encryptedText,
    encrypted2: encryptedText2,
    passphrase: passphrase,
  );
  print("Are the encrypted texts equal? $isEncryptedEqual");
}
