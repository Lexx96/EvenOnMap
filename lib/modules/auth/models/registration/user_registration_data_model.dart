
/// Модель данных пользователя для регистрации
class UserDataRegistration {
  String status;
  String phone;
  String password;


  UserDataRegistration({
    required this.status,
    required this.phone,
    required this.password,
  });

  factory UserDataRegistration.fromJson(Map<String, dynamic> json){
    return UserDataRegistration(
      status: json ["status"] as String,
      phone: json ["phone"] as String,
      password: json["password"] as String,
    );
  }
}
