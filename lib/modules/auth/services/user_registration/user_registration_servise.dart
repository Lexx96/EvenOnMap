import 'dart:convert';
import 'package:event_on_map/modules/auth/bloc/auth_bloc.dart';
import 'package:event_on_map/modules/auth/models/registration/user_registration.dart';
import 'package:event_on_map/modules/auth/services/user_registration/user_registration_api_repository.dart';
import 'package:http/http.dart';

/// Сервис обработки запросов модуля auth
class UserRegistrationProvider {

  /// Регистрация нового пользователя, принимает номер телефона
  /// пользователя String [phone], пароль пользователя String [password]
  Future<UserRegistrationModel> postUserRegistration(
    String phone,
    String password,
  ) async {
    final _jsonRegistrationModel =
        UserRegistrationModel(phone: phone, password: password).toJson();
    final Response response =
        await UserRegistrationRepository.postUserRegistrationData(
            _jsonRegistrationModel);
    final jsonRegistrationModel = UserRegistrationModel();
    if (response.statusCode == 201) {
      try {
        final jsonRegistrationList =
            jsonDecode(response.body) as Map<String, dynamic>;
        final jsonRegistrationModel =
            UserRegistrationModel.fromJson(jsonRegistrationList);
        return jsonRegistrationModel;
      } catch (_) {
        return jsonRegistrationModel;
      }
    } else if (response.statusCode == 400) {
      throw UserAlreadyRegisteredException();
    } else {
      throw Exception();
    }
  }
}
