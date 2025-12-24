import 'dart:convert';

import 'package:my_salt/my_salt.dart';
import 'package:test/test.dart';

/// Remind comment on tested function: // #TESTED
void main() {
  group('EncryptHelp', () {
    test('decrypt should handle CryptoJS-compatible ciphertext', () {
      const passwordAES = "5CJcdYW/GwMEmgNiVLJI9yvlH1t/DaREB2h5ionEdYs=";
      final decrypt = MySalt().decryptAESCryptoJS(
          'U2FsdGVkX1/DdEBJRU4Gf2h5hR3Z4OoJ9ok8aAd+3m4=', passwordAES);

      expect("123456" == decrypt, true);
    });

    test('encryptAESCryptoJS round trip', () {
      const passwordAES = "5CJcdYW/GwMEmgNiVLJI9yvlH1t/DaREB2h5ionEdYs=";
      final encrypt = MySalt().encryptAESCryptoJS("123456", passwordAES);
      final decrypt = MySalt().decryptAESCryptoJS(encrypt, passwordAES);

      expect("123456" == decrypt, true);
    });
  });
  group('Encryption Tests', () {
    test('verify should return true for correct decryption', () {
      // Giả sử decryptAESCryptoJS hoạt động đúng và trả về giá trị đầu vào khi giải mã
      expect(
        MySalt().verify(
          text: 'eb3BKYngSUix3Hqgu4HfbTgXKqxg+EOGpSoXVf/B96w=',
          encrypted:
              'U2FsdGVkX18LSD6lmwMyJlgLUgp1LupVS6wMMui8XpWMKZ7oZmAiZTAN0ZAOtKt71Gf7IjaI3QuB337IlfeXgQ==', // Giả sử đây là kết quả của việc mã hóa 'Hello'
          passphrase: "NZtAVdTQssbL393H41Kx5S110lrqqneCtr5qMLYlDtM=",
        ),
        isTrue,
      );
    });

    test('verify should return false for incorrect decryption', () {
      expect(
        MySalt().verify(
          text: 'eb3BKYngSUix3Hqgu4HfbTgXKqxg+EOGpSoXVf/B96w=',
          encrypted:
              'U2FsdGVkX1/mgzuc7ynk3WLLr0lOPLWxnzKa1ap20DmMiqldOhbZIebBRm9GHUo9wqDZgVmaMt7p4Q1r36ngTA==', // Giả sử đây không phải là kết quả của việc mã hóa 'Hello'
          passphrase: 'NZtAVdTQssbL393H41Kx5S110lrqqneCtr5qMLYlDtM',
        ),
        isFalse,
      );
    });

    test('verifyEncrypted should return true for same plaintext with different',
        () {
      const passphrase = 'NZtAVdTQssbL393H41Kx5S110lrqqneCtr5qMLYlDtM';
      const text = 'Hello';
      final encrypted1 = MySalt().encryptAESCryptoJS(text, passphrase);
      var encrypted2 = MySalt().encryptAESCryptoJS(text, passphrase);
      if (encrypted1 == encrypted2) {
        encrypted2 = MySalt().encryptAESCryptoJS(text, passphrase);
      }
      expect(encrypted1, isNot(equals(encrypted2)));
      expect(
        MySalt().verifyEncrypted(
          encrypted1: encrypted1,
          encrypted2: encrypted2,
          passphrase: passphrase,
        ),
        isTrue,
      );
    });

    test('verifyEncrypted should return false for identical ciphertext', () {
      const passphrase = 'NZtAVdTQssbL393H41Kx5S110lrqqneCtr5qMLYlDtM';
      const text = 'Hello';
      final encrypted = MySalt().encryptAESCryptoJS(text, passphrase);
      expect(
        MySalt().verifyEncrypted(
          encrypted1: encrypted,
          encrypted2: encrypted,
          passphrase: passphrase,
        ),
        isFalse,
      );
    });

    test('verify should return false with wrong passphrase', () {
      const text = 'Hello';
      const passphrase = 'correct-pass';
      final encrypted = MySalt().encryptAESCryptoJS(text, passphrase);
      expect(
        MySalt().verify(
          text: text,
          encrypted: encrypted,
          passphrase: 'wrong-pass',
        ),
        isFalse,
      );
    });

    test('encrypt/decrypt should handle unicode text', () {
      const passphrase = 'unicode-pass';
      const unicode = 'Xin chao 👋';

      final encryptedUnicode = MySalt().encryptAESCryptoJS(unicode, passphrase);

      expect(MySalt().decryptAESCryptoJS(encryptedUnicode, passphrase), unicode);
    });

    test('encrypt/decrypt should handle unicode passphrase', () {
      const passphrase = 'pässwörd-🔒';
      const text = 'Hello';
      final encrypted = MySalt().encryptAESCryptoJS(text, passphrase);

      expect(MySalt().decryptAESCryptoJS(encrypted, passphrase), text);
    });

    test('encrypt/decrypt should handle large plaintext', () {
      const passphrase = 'large-pass';
      final largeText = List.filled(100000, 'a').join();
      final encrypted = MySalt().encryptAESCryptoJS(largeText, passphrase);

      expect(MySalt().decryptAESCryptoJS(encrypted, passphrase), largeText);
    });

    test('encrypt should throw for empty text', () {
      const passphrase = 'unicode-pass';
      // Empty input currently fails in the underlying cipher implementation.
      expect(
        () => MySalt().encryptAESCryptoJS('', passphrase),
        throwsA(anything),
      );
    });

    test('verify should return false for invalid encrypted data', () {
      expect(
        MySalt().verify(
          text: 'Hello',
          encrypted: 'not-base64',
          passphrase: 'pass',
        ),
        isFalse,
      );
    });

    test('verify should return false for too-short encrypted data', () {
      final shortEncrypted = base64Encode([1, 2, 3, 4]);
      expect(
        MySalt().verify(
          text: 'Hello',
          encrypted: shortEncrypted,
          passphrase: 'pass',
        ),
        isFalse,
      );
    });

    test('verify should return false for invalid salt prefix', () {
      final invalidSalted = base64Encode(utf8.encode('NotSalted__12345678'));
      expect(
        MySalt().verify(
          text: 'Hello',
          encrypted: invalidSalted,
          passphrase: 'pass',
        ),
        isFalse,
      );
    });
  });
}
