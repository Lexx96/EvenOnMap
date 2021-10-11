import 'dart:convert';

import 'package:event_on_map/auth/models/log_in/user_log_in.dart';
import 'package:event_on_map/auth/models/registration/user_registration.dart';
import 'package:event_on_map/auth/services/user_log_in/user_log_in_repository.dart';
import 'package:event_on_map/auth/services/user_registration/user_registration_repository.dart';

class JsonDataCoder {


  Future userRegistrationPost(String phone,
      String password,
      UserRegistrationRepository _registrationRepository,) async {
    Map<String, dynamic> _registrationModel =
    UserRegistrationModel(phone: phone, password: password).toJson();

      _registrationRepository
          .postUserRegistrationData(_registrationModel)
          .then((jsonStringRegistration) {
        final listJsonRegistration =
        jsonDecode(jsonStringRegistration) as Map<String, dynamic>;
        final jsonRegistration =
        UserRegistrationModel.fromJson(listJsonRegistration);
      });
  }

   Future userLogInPost(
      String phone,
      String password,
      UserLogInRepository _logInRepository,) async{
    Map<String, dynamic> _logInModel = UserLogInModel(
        phone: phone, password: password).toJson();

      _logInRepository.postUserLogInData(_logInModel).then((jsonStringLogIn) {
        final listJsonLogIn = jsonDecode(jsonStringLogIn) as Map<String, dynamic>;
        final jsonLogIn = UserLogInModel.fromJson(listJsonLogIn);
        return jsonLogIn.userData!.phone;
      });
  }
}
