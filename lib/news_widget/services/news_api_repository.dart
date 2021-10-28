import 'package:event_on_map/auth/services/user_log_in/user_log_in_api_repository.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  static getAllNews<Response>() async {

    /// получение accessToken из SharedPreferences
    String _accessToken =
        await SetAndReadAccessTokenFromSharedPreferences().readAccessToken();

    return await http.get(
      Uri.parse('http://23.152.0.13:3000/news'),
      headers: {'Authorization': 'Bearer ' + _accessToken},
    );
  }
}
