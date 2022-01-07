import 'package:event_on_map/modules/auth/models/log_in/user_login_data_model.dart';

/// Модель пользователя, для авторизации
class UserLogInModel {
  String? phone;
  String? password;
  String? accessToken;
  UserDataLogIn? userData;

  UserLogInModel({
    this.phone,
    this.password,
    this.accessToken,
    this.userData,
  });

  factory UserLogInModel.fromJson(Map<String, dynamic> json) {
    return UserLogInModel(
        accessToken: json["access-token"] as String,
        userData: json["user-data"] != null ? UserDataLogIn.fromJson(json["user-data"]) : null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "phone": phone as String,
      "password": password as String,
    };
  }
}
