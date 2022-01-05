import 'package:http/http.dart' as http;

/// Класс управления запросами модуля auth
class UserRegistrationRepository {

  /// Основной URL модуля
  static const _url = 'http://23.152.0.13:3000/auth/registration';

  /// Запрос на регистрацию пользователя
  static postUserRegistrationData<Response>(
      Map<String, dynamic> jsonRegistration) async {
    return await http.post(Uri.parse(_url),
        body: jsonRegistration);
  }
}
