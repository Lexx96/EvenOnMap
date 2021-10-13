import 'package:http/http.dart' as http;

class UserLogInRepository {
  static postUserLogInData <Response> (Map<String, dynamic> jsonLogIn) async {
    return await http.post(
        Uri.parse('http://23.152.0.13:3000/auth/login'), body: jsonLogIn);
  }
}