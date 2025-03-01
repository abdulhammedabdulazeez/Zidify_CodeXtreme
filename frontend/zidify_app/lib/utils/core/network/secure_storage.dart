import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  // Create storage
  final FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: _getAndroidOptions(),
    iOptions: _getIOSOptions(),
  );

  // Android options for encryption
  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true, // Ensures encryption
      );

  // iOS options for security
  static IOSOptions _getIOSOptions() => const IOSOptions();

  // Save User Id
  Future<void> saveUserId(String idKey, String idValue) async {
    await _storage.write(key: idKey, value: idValue);
  }

  // Read data (retrieve user id)
  Future<String?> readId(String idKey) async {
    return await _storage.read(key: idKey);
  }

  // Save data (like access token)
  Future<void> saveToken(String tokenKey, String tokenValue) async {
    await _storage.write(key: tokenKey, value: tokenValue);
  }

  // Read data (retrieve access token)
  Future<String?> readToken(String tokenKey) async {
    return await _storage.read(key: tokenKey);
  }

  // Delete a token
  Future<void> deleteToken(String tokenKey) async {
    await _storage.delete(key: tokenKey);
  }

  // Delete all tokens
  Future<void> deleteAllTokens() async {
    await _storage.deleteAll();
  }

  // Check if a token exists
  Future<bool> containsToken(String tokenKey) async {
    var value = await _storage.read(key: tokenKey);
    return value != null;
  }
}
