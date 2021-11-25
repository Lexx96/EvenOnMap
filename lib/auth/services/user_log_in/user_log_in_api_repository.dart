import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _SecureStorageKeys {
  static const _password = 'UserPassword';
  static const _logIn = 'UserLogIn';
}

class UserLogInRepository {

  /// Отправка запроса на вход уже зарегистрированного пользователя
  static postUserLogInData<Response>(Map<String, dynamic> jsonLogIn) async {
    return await http.post(Uri.parse('http://23.152.0.13:3000/auth/login'),
        body: jsonLogIn);
  }
}

abstract class _SharedPreferencesKeys {
  static const _accessToken = 'accessToken';
}

class SetAndReadDataFromSharedPreferences {

  final _storage = SharedPreferences.getInstance();

  /// Сохранение accessToken в SharedPreferences
  Future<void> setAccessToken({required String accessToken}) async {
    try{
      final storage = await _storage;
      await storage.setString(_SharedPreferencesKeys._accessToken, accessToken);
    }catch(e) {
      throw Exception(e);
    }
  }

  /// Получение accessToken из SharedPreferences
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

class WriteAndReadDataFromSecureStorage {


  /// Проверка наличия логина в SecureStorage
  static Future<String?> readUserLogIn () async {
    try{
      final _secureStorage = FlutterSecureStorage();
      final _logInFromSecureStorage = await _secureStorage.read(key: _SecureStorageKeys._logIn);
      if(_logInFromSecureStorage != null) {
        return _logInFromSecureStorage;
      } else {
        return null;
      }
    }catch(e){
      throw Exception(e);
    }
  }

  /// Сохранение логина в SecureStorage
  static Future<void> writeUserLogIn ({ required String logIn}) async {
    try{
      final _secureStorage = FlutterSecureStorage();
        await _secureStorage.write(key: _SecureStorageKeys._logIn, value: logIn);
    }catch(e){
      throw Exception(e);
    }
  }

  /// Проверка наличия пароля в SecureStorage
  static Future<String?> readUserPassword () async {
    try{
      final _secureStorage = FlutterSecureStorage();
      final _passwordFromSecureStorage = await _secureStorage.read(key: _SecureStorageKeys._password);
      if(_passwordFromSecureStorage != null) {
        return _passwordFromSecureStorage;
      } else {
        return null;
      }
    }catch(e){
      throw Exception(e);
    }
  }

  /// Сохранение пароля в SecureStorage
  static Future<String?> writeUserPassword ({required String password}) async {
    try{
      final _secureStorage = FlutterSecureStorage();
        await _secureStorage.write(key: _SecureStorageKeys._password, value: password);
    }catch(e){
      throw Exception(e);
    }
  }

  /// Удаление пароля и логина из SecureStorage
  static Future<String?> deleteUserPasswordAndLogIn () async {
    try{
      final _secureStorage = FlutterSecureStorage();
      await _secureStorage.delete(key: _SecureStorageKeys._password);
      await _secureStorage.delete(key: _SecureStorageKeys._logIn);
    }catch(e){
      throw Exception(e);
    }
  }
}
