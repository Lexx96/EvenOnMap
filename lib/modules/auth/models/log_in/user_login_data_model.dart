
/// Модель данных пользователя для авторизации
class UserDataLogIn {
  String status;
  String phone;
  String password;


  UserDataLogIn({
    required this.status,
    required this.phone,
    required this.password,
  });

  factory UserDataLogIn.fromJson(Map<String, dynamic> json){
    return UserDataLogIn(
      status: json ["status"] as String,
      phone: json ["phone"] as String,
      password: json["password"] as String,
    );
  }
}
