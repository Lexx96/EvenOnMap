import 'package:http/http.dart' as http;

class UserRegistrationRepository {

  /// Регистрация нового пользователя
  static postUserRegistrationData<Response>(
      Map<String, dynamic> jsonRegistration) async {
    return await http.post(Uri.parse('http://23.152.0.13:3000/auth/registration'),
        body: jsonRegistration);
  }
}
