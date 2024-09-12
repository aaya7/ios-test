import 'package:encrypt/encrypt.dart';

import '../../../data/constants/constant.dart';

class HiveEncryptionService {
  final _key = Key.fromUtf8(ConstantValue.encryptionKey);
  final _iv = IV.fromLength(16);

  String encrypt(String password) {
    final encrypter = Encrypter(AES(_key));
    final encrypted = encrypter.encrypt(password, iv: _iv);
    return encrypted.base64;
  }

  String decrypt(String encryptedPassword) {
    final encrypter = Encrypter(AES(_key));
    final encrypted = Encrypted.fromBase64(encryptedPassword);
    return encrypter.decrypt(encrypted, iv: _iv);
  }
}