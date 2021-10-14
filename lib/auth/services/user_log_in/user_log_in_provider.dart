import 'dart:convert';
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
        final jsonLogInList =
            jsonDecode(response.body) as Map<String, dynamic>; // проблемка
        final jsonLogInModel = UserLogInModel.fromJson(jsonLogInList);
        return jsonLogInModel;
      } catch (_) {
        return jsonLogInModel;
      }
    }
    return jsonLogInModel;
  }
}
