import 'package:http/http.dart' as http;

class PostEventRepository {
  static postNewEvent <Response> (Map <String, dynamic> eventJson) async {
    return await http.post(Uri.parse('http://23.152.0.13:3000/news'), body: eventJson);
  }
}