import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as e;
import 'package:crypto/crypto.dart' as h;

// import 'package:flutter/services.dart';

/// AES encryption and decryption methods compatible with CryptoJS.
class MySalt {
  /// AES encryption and decryption methods compatible with CryptoJS.
  const MySalt();

  /*
  Learn more | https://pub.dev/packages/encrypt

  Generate password
  Run |
  flutter pub global activate encrypt
  secure-random

   */

  /// Encrypts a plain text using AES with a passphrase.
  ///
  /// Uses a random salt and CBC mode.
  /// Returns a Base64 encoded encrypted string.
  String encryptAESCryptoJS(String plainText, String passphrase) {
    try {
      final salt = _genRandomWithNonZero(8);
      final keyndIV = _deriveKeyAndIV(passphrase, salt);
      final key = e.Key(keyndIV[0]);
      final iv = e.IV(keyndIV[1]);

      final encrypter = e.Encrypter(e.AES(key, mode: e.AESMode.cbc));
      final encrypted = encrypter.encrypt(plainText, iv: iv);
      final Uint8List encryptedBytesWithSalt = Uint8List.fromList(
          _createUint8ListFromString("Salted__") + salt + encrypted.bytes);
      return base64.encode(encryptedBytesWithSalt);
    } catch (error) {
      rethrow;
    }
  }

  /// Decrypts an AES-encrypted Base64 string using a passphrase.
  ///
  /// Returns the decrypted plain text.
  String decryptAESCryptoJS(String encrypted, String passphrase) {
    try {
      final Uint8List encryptedBytesWithSalt = base64.decode(encrypted);

      final Uint8List encryptedBytes =
          encryptedBytesWithSalt.sublist(16, encryptedBytesWithSalt.length);
      final salt = encryptedBytesWithSalt.sublist(8, 16);
      final keyndIV = _deriveKeyAndIV(passphrase, salt);
      final key = e.Key(keyndIV[0]);
      final iv = e.IV(keyndIV[1]);

      final encrypter = e.Encrypter(e.AES(key, mode: e.AESMode.cbc));
      final decrypted =
          encrypter.decrypt64(base64.encode(encryptedBytes), iv: iv);
      return decrypted;
    } catch (error) {
      rethrow;
    }
  }

  /// Verifies if a plain text matches an encrypted string using the passphrase.
  ///
  /// Returns `true` if the decrypted text matches the original text.
  bool verify({
    required String text,
    required String encrypted,
    required String passphrase,
  }) {
    try {
      return text == decryptAESCryptoJS(encrypted, passphrase);
    } catch (e) {
      return false;
    }
  }

  /// Compares two encrypted strings to check if they decrypt to the same plain text.
  ///
  /// Returns `true` if both encrypted texts correspond to the same original value.
  bool verifyEncrypted({
    required String encrypted1,
    required String encrypted2,
    required String passphrase,
  }) {
    if (encrypted1 == encrypted2) return false;
    try {
      return decryptAESCryptoJS(encrypted1, passphrase) ==
          decryptAESCryptoJS(encrypted2, passphrase);
    } catch (e) {
      return false;
    }
  }

  List<Uint8List> _deriveKeyAndIV(String passphrase, Uint8List salt) {
    final password = _createUint8ListFromString(passphrase);
    Uint8List concatenatedHashes = Uint8List(0);
    Uint8List currentHash = Uint8List(0);
    bool enoughBytesForKey = false;
    Uint8List preHash = Uint8List(0);

    while (!enoughBytesForKey) {
      // final int preHashLength = currentHash.length + password.length + salt.length;
      if (currentHash.isNotEmpty) {
        preHash = Uint8List.fromList(currentHash + password + salt);
      } else {
        preHash = Uint8List.fromList(password + salt);
      }

      currentHash = preHash.myMd5;
      concatenatedHashes = Uint8List.fromList(concatenatedHashes + currentHash);
      if (concatenatedHashes.length >= 48) enoughBytesForKey = true;
    }

    final keyBytes = concatenatedHashes.sublist(0, 32);
    final ivBytes = concatenatedHashes.sublist(32, 48);
    return [keyBytes, ivBytes];
  }

  Uint8List _createUint8ListFromString(String s) {
    final ret = Uint8List(s.length);
    for (var i = 0; i < s.length; i++) {
      ret[i] = s.codeUnitAt(i);
    }
    return ret;
  }

  Uint8List _genRandomWithNonZero(int seedLength) {
    final random = Random.secure();
    const int randomMax = 245;
    final Uint8List uint8list = Uint8List(seedLength);
    for (int i = 0; i < seedLength; i++) {
      uint8list[i] = random.nextInt(randomMax) + 1;
    }
    return uint8list;
  }
}

/// Extension providing cryptographic hash functions for [Uint8List].
///
/// This extension allows computing various hash values, including MD5, SHA-1, SHA-2, and SHA-512 variants.
///
/// Example:
/// ```dart
/// Uint8List data = Uint8List.fromList([1, 2, 3, 4]);
/// Uint8List md5Hash = data.myMd5;
/// ```
extension _MyHashHelper on Uint8List {
  /// Computes the MD5 hash of the current [Uint8List].
  Uint8List get myMd5 => h.md5.convert(this).bytes as Uint8List;
/*
  /// Computes the SHA-1 hash of the current [Uint8List].
  Uint8List get mySha1 => h.sha1.convert(this).bytes as Uint8List;

  /// Computes the SHA-224 hash of the current [Uint8List].
  Uint8List get mySha224 => h.sha224.convert(this).bytes as Uint8List;

  /// Computes the SHA-256 hash of the current [Uint8List].
  Uint8List get mySha256 => h.sha256.convert(this).bytes as Uint8List;

  /// Computes the SHA-384 hash of the current [Uint8List].
  Uint8List get mySha384 => h.sha384.convert(this).bytes as Uint8List;

  /// Computes the SHA-512 hash of the current [Uint8List].
  Uint8List get mySha512 => h.sha512.convert(this).bytes as Uint8List;

  /// Computes the SHA-512/224 hash of the current [Uint8List].
  Uint8List get mySha512224 => h.sha512224.convert(this).bytes as Uint8List;

  /// Computes the SHA-512/256 hash of the current [Uint8List].
  Uint8List get mySha512256 => h.sha512256.convert(this).bytes as Uint8List;*/
}

/*
Đoạn code bạn cung cấp thực hiện việc mã hóa và giải mã bằng thuật toán AES (Advanced Encryption Standard) trong chế độ CBC (Cipher Block Chaining), kết hợp với việc sử dụng salt ngẫu nhiên và hàm dẫn xuất khóa dựa trên MD5. Đây là lý do tại sao mỗi lần mã hóa lại cho ra một kết quả khác nhau, nhưng vẫn có thể giải mã ngược lại được.

**Cụ thể về cách hoạt động của đoạn code:**

1. **Tạo Salt Ngẫu Nhiên:**
   - Hàm `_genRandomWithNonZero(8)` tạo ra một `salt` ngẫu nhiên dài 8 byte.
   - Salt này được sử dụng để tăng cường bảo mật, đảm bảo rằng cùng một plain text và passphrase khi mã hóa sẽ cho ra cipher text khác nhau mỗi lần.

2. **Dẫn Xuất Key và IV:**
   - Hàm `_deriveKeyAndIV(passphrase, salt)` dẫn xuất `key` và `IV` (Initialization Vector) từ passphrase và salt bằng cách sử dụng nhiều lần băm MD5.
   - Quá trình này tương tự như hàm `EVP_BytesToKey` trong OpenSSL.

3. **Mã Hóa Dữ Liệu:**
   - Sử dụng `key` và `IV` vừa dẫn xuất, hàm `encryptAESCryptoJS` mã hóa `plainText` bằng AES trong chế độ CBC.
   - Kết quả mã hóa được ghép với chuỗi `"Salted__"` và `salt` ban đầu, sau đó được mã hóa base64 để dễ dàng lưu trữ hoặc truyền tải.

4. **Giải Mã Dữ Liệu:**
   - Hàm `decryptAESCryptoJS` thực hiện ngược lại quá trình trên.
   - Nó tách `salt` từ dữ liệu mã hóa và dẫn xuất lại `key` và `IV` để giải mã dữ liệu.

**Tại sao kết quả mã hóa lại khác nhau mỗi lần?**

Việc sử dụng `salt` ngẫu nhiên trong mỗi lần mã hóa làm cho kết quả cipher text thay đổi, ngay cả khi sử dụng cùng một plain text và passphrase. Điều này giúp ngăn chặn các tấn công dò tìm mẫu và tăng cường bảo mật.

**Metaphor:** Hãy tưởng tượng `salt` như một gia vị đặc biệt mà bạn thêm vào công thức nấu ăn. Mỗi lần nấu, bạn thêm một chút gia vị bí mật khác nhau, khiến cho món ăn tuy cùng nguyên liệu nhưng hương vị mỗi lần lại độc đáo. Điều này làm cho kẻ xấu khó dự đoán và tái tạo lại món ăn của bạn.

**Thông tin mở rộng:**

- **Sự Quan Trọng của Salt và IV:**
  - Salt ngẫu nhiên và IV đảm bảo rằng dữ liệu mã hóa an toàn trước các tấn công phân tích mật mã.
  - Chúng ngăn chặn việc sử dụng các bảng tra cứu (lookup tables) hoặc tấn công dựa trên thống kê.

- **Hàm Dẫn Xuất Khóa (KDF):**
  - Việc sử dụng hàm băm MD5 trong quá trình dẫn xuất key và IV là một phương pháp cổ điển, nhưng hiện nay có những hàm KDF mạnh mẽ hơn như PBKDF2, scrypt hoặc bcrypt.
  - Sử dụng các hàm KDF hiện đại giúp tăng cường bảo mật, đặc biệt khi đối phó với các tấn công bẻ khóa mật khẩu.

- **Khuyến Nghị Bảo Mật:**
  - Xem xét việc thay thế MD5 bằng các thuật toán băm an toàn hơn như SHA-256.
  - Đảm bảo passphrase đủ mạnh và khó đoán để tăng cường an toàn cho dữ liệu mã hóa.

Nếu bạn quan tâm, bạn có thể tìm hiểu thêm về cách OpenSSL thực hiện mã hóa symetric với passphrase và tại sao việc sử dụng salt và hàm KDF là quan trọng trong việc bảo vệ thông tin.
 */
