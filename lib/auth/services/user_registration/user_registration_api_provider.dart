
import 'package:http/http.dart' as http;

class UserRegistrationProvider{

  Future<String> postUserRegistration(Map<String, dynamic> json) async{
    final response = await http.post(Uri.parse('http://23.152.0.13:3000/auth/registration'), body: json);
    if(response.statusCode == 201) {
      //print(response.body);
      return response.body;
    } else {
      throw Exception('Ошибка регистрации: $response.statusCode');
    }
  }
}