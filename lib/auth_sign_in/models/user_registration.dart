
class UserRegistrationModel {
  String phone;
  String password;

  UserRegistrationModel({
    required this.phone,
    required this.password,
  });

  factory UserRegistrationModel.fromJson(Map<String, dynamic> json) {
    return UserRegistrationModel(
      phone: json['phone'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password,
    };
  }
}

//response
