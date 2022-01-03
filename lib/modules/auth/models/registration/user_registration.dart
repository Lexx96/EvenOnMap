

import 'package:event_on_map/modules/auth/models/registration/user_registration_data_model.dart';

class UserRegistrationModel {
  String? phone;
  String? password;
  String? accessToken;
  UserDataRegistration? userData;

  UserRegistrationModel({
     this.phone,
     this.password,
     this.accessToken,
     this.userData,
  });

  factory UserRegistrationModel.fromJson(Map<String, dynamic> json) {
    return UserRegistrationModel(
        accessToken: json["access-token"] as String,
        userData: json["user-data"] != null ? UserDataRegistration.fromJson(json["user-data"]) : null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "phone": phone as String,
      "password": password as String,
    };
  }
}
