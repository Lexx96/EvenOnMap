
import 'package:http/http.dart' as http;

class UserLogInProvider{

  Future<String> postUserLogIn(Map<String, dynamic> jsonLogIn) async{
    final response = await http.post(Uri.parse('http://23.152.0.13:3000/auth/login'), body: jsonLogIn);
    if(response.statusCode == 201) {
      //print(response.body);
      return response.body;
    } else {
      throw Exception('Ошибка входа: $response.statusCode');
    }
  }
}