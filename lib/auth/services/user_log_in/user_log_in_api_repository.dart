import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

class SetAndReadAccessTokenFromSharedPreferences {

  final _storage = SharedPreferences.getInstance();

  /// Сохранение accessToken в SharedPreferences
  Future<void> setAccessToken({required String accessToken}) async {
    final storage = await _storage;
    await storage.setString(_SharedPreferencesKeys._accessToken, accessToken);
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
