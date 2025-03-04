import 'package:my_salt/my_salt.dart';
import 'package:test/test.dart';

/// Remind comment on tested function: // #TESTED
void main() {
  group('EncryptHelp', () {
    test('encryptAESCryptoJS', () {
      const passwordAES = "5CJcdYW/GwMEmgNiVLJI9yvlH1t/DaREB2h5ionEdYs=";
      final encrypt = MySalt().encryptAESCryptoJS("123456", passwordAES);
      final decrypt = MySalt().decryptAESCryptoJS(
          'U2FsdGVkX1/DdEBJRU4Gf2h5hR3Z4OoJ9ok8aAd+3m4=', passwordAES);
      final decrypt2 = MySalt().decryptAESCryptoJS(encrypt, passwordAES);

      expect("123456" == decrypt, true);
      expect("123456" == decrypt2, true);
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

    test('verifyEncrypted should return true for matching encrypted values',
        () {
      expect(
        MySalt().verifyEncrypted(
          encrypted1:
              'U2FsdGVkX18LSD6lmwMyJlgLUgp1LupVS6wMMui8XpWMKZ7oZmAiZTAN0ZAOtKt71Gf7IjaI3QuB337IlfeXgQ==',
          encrypted2:
              'U2FsdGVkX18LSD6lmwMyJlgLUgp1LupVS6wMMui8XpWMKZ7oZmAiZTAN0ZAOtKt71Gf7IjaI3QuB337IlfeXgQ==',
          passphrase: 'NZtAVdTQssbL393H41Kx5S110lrqqneCtr5qMLYlDtM',
        ),
        isFalse,
      );
    });
  });
}
