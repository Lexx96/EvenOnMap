import 'dart:convert';
import 'package:event_on_map/auth/bloc/auth_bloc.dart';
import 'package:event_on_map/auth/models/log_in/user_log_in.dart';
import 'package:event_on_map/auth/services/user_log_in/user_log_in_api_repository.dart';
import 'package:http/http.dart';

class UserLogInProvider {
  Future<UserLogInModel> postUserLogIn(String phone, String password) async {
    final _jsonLogInPost =
        UserLogInModel(phone: phone, password: password).toJson();
    final Response response =
        await UserLogInRepository.postUserLogInData(_jsonLogInPost);
    final jsonLogInModel = UserLogInModel();

    if (response.statusCode == 201) {
      try {
        final jsonLogInList = jsonDecode(response.body) as Map<String, dynamic>;
        final jsonLogInModel = UserLogInModel.fromJson(jsonLogInList);
        return jsonLogInModel;
      } catch (_) {
        return jsonLogInModel;
      }
    } else if (response.statusCode == 401) {
      throw ErrorPasswordException();
    } else if (response.statusCode == 500) {
      throw NotRegisteredException();
    } else {
      throw Exception();
    }
  }

  /// сохранение accessToken в SharedPreferences
  Future <void> setAccessTokenInSharedPreferences(
      {required String accessToken}) async {
    try{
      SetAndReadAccessTokenFromSharedPreferences()
          .setAccessToken(accessToken: accessToken);
    }
    catch(_) {
      throw AccessTokenNotSetInSharedPreferencesException();
    }
  }
}
