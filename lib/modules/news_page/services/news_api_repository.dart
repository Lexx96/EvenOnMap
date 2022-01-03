import 'package:event_on_map/modules/auth/services/user_log_in/user_log_in_api_repository.dart';
import 'package:http/http.dart' as http;

class NewsRepository {

  /// Получение accessToken из SharedPreferences и отправка запроса на сервер
  static getAllNews<Response>() async {
    String _accessToken = await SetAndReadDataFromSharedPreferences().readAccessToken();
    return await http.get(
      Uri.parse('http://23.152.0.13:3000/news'),
      headers: {'Authorization': 'Bearer ' + _accessToken},
    );
  }
}
