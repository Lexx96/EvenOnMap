import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _SecureStorageKeys {
  static const _password = 'UserPassword';
  static const _phoneNumber = 'PhoneNumber';
}

abstract class _SharedPreferencesKeys {
  static const _accessToken = 'accessToken';
}

/// Класс управления запросами модуля auth
class UserLogInRepository {

  /// Основной URL модуля
  static const _url = 'http://23.152.0.13:3000/auth/login';

  /// Запрос на вход уже зарегистрированного пользователя
  static postUserLogInData<Response>(Map<String, dynamic> jsonLogIn) async {
    return await http.post(Uri.parse(_url),
        body: jsonLogIn);
  }
}

/// Класс управления сохранением и чтением accessToken
class SetAndReadDataFromSharedPreferences {
  final _storage = SharedPreferences.getInstance();

  /// Сохранение accessToken в SharedPreferences, принимает accessToken String [accessToken]
  Future<void> saveAccessToken({required String accessToken}) async {
    try{
      final storage = await _storage;
      await storage.setString(_SharedPreferencesKeys._accessToken, accessToken);
    }catch(e) {
      throw Exception(e);
    }
  }

  /// Чтение accessToken из SharedPreferences
  Future<String> readAccessToken() async {
    final storage = await _storage;
    try{
      final getAccessTokenFromSharedPreferences =
      storage.getString(_SharedPreferencesKeys._accessToken);
      return getAccessTokenFromSharedPreferences as String;
    }
    catch(e){
      return "Получить accessToken из SharedPreferences не удалось $e";
    }
  }
}

/// Класс управления сохранением и чтением номера пользователя и паролем
class WriteAndReadDataFromSecureStorage {

  /// Сохранение номера в SecureStorage, принмает номер пользователя String [phoneNumber]
  static Future<void> writePhoneNumber ({ required String phoneNumber}) async {
    try{
      final _secureStorage = FlutterSecureStorage();
        await _secureStorage.write(key: _SecureStorageKeys._phoneNumber, value: phoneNumber);
    }catch(e){
      throw Exception(e);
    }
  }

  /// Сохранение пароля в SecureStorage, принмает пароль String [password]
  static Future<String?> writeUserPassword ({required String password}) async {
    try{
      final _secureStorage = FlutterSecureStorage();
      await _secureStorage.write(key: _SecureStorageKeys._password, value: password);
    }catch(e){
      throw Exception(e);
    }
  }

  /// Проверка наличия номера пользователя в SecureStorage
  static Future<String?> readUserPhoneNumber () async {
    try{
      final _secureStorage = FlutterSecureStorage();
      final _logInFromSecureStorage = await _secureStorage.read(key: _SecureStorageKeys._phoneNumber);
        return _logInFromSecureStorage;
    }catch(_){
      return null;
    }
  }

  /// Проверка наличия пароля в SecureStorage
  static Future<String?> readUserPassword () async {
    try{
      final _secureStorage = FlutterSecureStorage();
      final _passwordFromSecureStorage = await _secureStorage.read(key: _SecureStorageKeys._password);
        return _passwordFromSecureStorage;
    }catch(_){
      return null;
    }
  }

  /// Удаление пароля и логина из SecureStorage
  static Future<String?> deleteUserPasswordAndLogIn () async {
    try{
      final _secureStorage = FlutterSecureStorage();
      await _secureStorage.delete(key: _SecureStorageKeys._password);
      await _secureStorage.delete(key: _SecureStorageKeys._phoneNumber);
    }catch(e){
      throw Exception(e);
    }
  }
}
