// import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class ChatMessageEncryptAndDecrypt {
  // final key = encrypt.Key.fromLength(32);
  // final iv = encrypt.IV.fromLength(16);
  //used AES algorithm
  final key = encrypt.Key.fromBase64("bOCv6JzbX3VmzTvNDaCXSw==");
  final iv = encrypt.IV.fromBase64("hz2lLTKsl+KC3Dd2FRfKig==");
  encryptionText(String message) {
    if (message == "") {
      return "";
    }
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encryptedText = encrypter.encrypt(message, iv: iv);

    return encryptedText.base64;
  }

  decryptionText(String message) {
    if (message == "") {
      return "";
    }
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    return encrypter.decrypt(encrypt.Encrypted.fromBase64(message), iv: iv);
  }
}
