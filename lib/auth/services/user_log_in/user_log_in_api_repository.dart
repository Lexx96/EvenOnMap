import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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


abstract class _SecureStorageKeys {
  static const _password = 'isAuth';
  static const _logIn = 'isAuth';
}

class SetAndReadDataFromSecureStorage {

  /// Сохранение логина при регистрации и получение пароля при последующих входах в приложение
  static Future<String?> isAuthUserLogIn ({ required String logIn}) async {
    try{
      final _secureStorage = FlutterSecureStorage();

      final _logInFromSecureStorage = await _secureStorage.read(key: _SecureStorageKeys._logIn);

      if(_logInFromSecureStorage == null) {
        await _secureStorage.write(key: _SecureStorageKeys._logIn, value: logIn);
        final _logInFromSecureStorage = await _secureStorage.read(key: _SecureStorageKeys._logIn);
        return _logInFromSecureStorage;
      } else {
        return _logInFromSecureStorage;
      }
    }catch(e){
      throw Exception(e);
    }
  }

  /// Сохранение пароля при регистрации и получение пароля при последующих входах в приложение
  static Future<String?> isAuthUserPassword ({required String password}) async {
    try{
      final _secureStorage = FlutterSecureStorage();

      final _passwordFromSecureStorage = await _secureStorage.read(key: _SecureStorageKeys._password);

      if(_passwordFromSecureStorage == null) {
        await _secureStorage.write(key: _SecureStorageKeys._password, value: password);
        final _passwordFromSecureStorage = await _secureStorage.read(key: _SecureStorageKeys._password);
        return _passwordFromSecureStorage;
      } else {
        return _passwordFromSecureStorage;
      }
    }catch(e){
      throw Exception(e);
    }
  }
}



