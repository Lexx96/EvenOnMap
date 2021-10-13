
import 'dart:convert';
import 'package:event_on_map/auth/models/log_in/user_log_in.dart';
import 'package:event_on_map/auth/services/user_log_in/user_log_in_api_repository.dart';
import 'package:http/http.dart';

class UserLogInProvider {

  Future<List<UserLogInModel>> postUserLogIn(String phone, String password) async {
    final _jsonLogInPost = UserLogInModel(phone: phone, password: password).toJson();
    final Response response = await UserLogInRepository.postUserLogInData(_jsonLogInPost);
    List<UserLogInModel> jsonLogInModel = [];

    if (response.statusCode == 201) {
      try{
        print('1111111111111111111111111111111111');
        //print(response.body);
        final jsonLogInList = jsonDecode(response.body) as List<dynamic>; // проблемка
        print(jsonLogInList.toString());
        final jsonLogInModel = jsonLogInList
            .map((dynamic json) =>
            UserLogInModel.fromJson(json as Map<String, dynamic>))
            .toList();

        return jsonLogInModel;
      }
      catch(_){
        return jsonLogInModel;
      }
    }
    return jsonLogInModel;
  }
}
