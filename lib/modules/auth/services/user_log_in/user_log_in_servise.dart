import 'dart:convert';
import 'package:event_on_map/modules/auth/bloc/auth_bloc.dart';
import 'package:event_on_map/modules/auth/models/log_in/user_log_in.dart';
import 'package:event_on_map/modules/auth/services/user_log_in/user_log_in_api_repository.dart';
import 'package:http/http.dart';

/// Сервис обработки запросов модуля auth
class UserLogInProvider {

  /// Авторизация ранее зарегистрированного пользователя, принимает номер телефона
  /// пользователя String [phone], пароль пользователя String [password]
  Future<UserLogInModel> postUserLogIn(
    String phone,
    String password,
  ) async {
    final _jsonLogInPostModel =
        UserLogInModel(phone: phone, password: password).toJson();
    final Response response =
        await UserLogInRepository.postUserLogInData(_jsonLogInPostModel);
    if (response.statusCode == 201) {
      try {
        final jsonLogInMap = jsonDecode(response.body) as Map<String, dynamic>;
        final jsonLogInModel = UserLogInModel.fromJson(jsonLogInMap);
        return jsonLogInModel;
      } catch (e) {
        throw Exception('Ошибка получения данных от UserLogInModel.fromJson $e');
      }
    } else if (response.statusCode == 401) {
      throw ErrorPasswordException();
    } else if (response.statusCode == 500) {
      throw NotRegisteredException();
    } else {
      throw Exception();
    }
  }

  /// Сохранение accessToken в SharedPreferences, принимает String [accessToken]
  Future<void> setAccessTokenInSharedPreferences(
      {required String accessToken}) async {
    try {
      SetAndReadDataFromSharedPreferences()
          .saveAccessToken(accessToken: accessToken);
    } catch (_) {
      throw AccessTokenNotSetInSharedPreferencesException();
    }
  }
}

// не используются
// /// Сохранение логина в SecureStorage при регистрации и получение данных был ли авторизованн пользователь ранее
// static Future<String?> writeAdnReadLoginInSecureStorage({required String logIn}) async {
//   try {
//     final _logInFromSecureStorage = await WriteAndReadDataFromSecureStorage.readUserLogIn();
//     if(_logInFromSecureStorage == null) {
//       await WriteAndReadDataFromSecureStorage.writeUserLogIn(logIn: logIn);
//       final _logInFromSecureStorage = await WriteAndReadDataFromSecureStorage.readUserLogIn();
//       return _logInFromSecureStorage;
//     }else {
//       final _logInFromSecureStorage = await WriteAndReadDataFromSecureStorage.readUserLogIn();
//       return _logInFromSecureStorage;
//     }
//   } catch (e) {
//     throw Exception(e);
//   }
// }
//
// /// Сохранение пароля в SecureStorage при регистрации и получение данных был ли авторизованн пользователь ранее
// static Future<String?> writeAdnReadPasswordSecureStorage({required String password}) async {
//   try {
//     final _passwordFromSecureStorage = await WriteAndReadDataFromSecureStorage.readUserPassword();
//     if(_passwordFromSecureStorage == null) {
//       await WriteAndReadDataFromSecureStorage.writeUserPassword(password: password);
//       final _passwordFromSecureStorage = await WriteAndReadDataFromSecureStorage.readUserPassword();
//       return _passwordFromSecureStorage;
//     }else {
//       final _passwordFromSecureStorage = await WriteAndReadDataFromSecureStorage.readUserPassword();
//       return _passwordFromSecureStorage;
//     }
//   } catch (e) {
//     throw Exception(e);
//   }
// }