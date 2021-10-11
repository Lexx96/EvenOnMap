

import 'package:http/http.dart' as http;

class ClearRepository {
  Future<String> registration(String phone, String password) async {

    final response = await http.post(
        Uri.parse('http://23.152.0.13:3000/auth/registration'),
        body: {
          "phone": phone,
          "password": password
        }
    );

    if(response.statusCode == 201) {
      print(response.body);
      return response.body;
      return 'Все хорошо';
    }
    else {
      return 'Жопа какая-то';
    }
  }
}