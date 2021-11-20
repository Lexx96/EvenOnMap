import 'package:event_on_map/auth/services/user_log_in/user_log_in_api_repository.dart';
import 'package:http/http.dart' as http;

class PostEventRepository {
  /// Получение токена из SharedPreferences при создании нового события
  static postNewEvent<Response>(Map<String, dynamic> eventJson) async {
    String _accessToken =
        await SetAndReadAccessTokenFromSharedPreferences().readAccessToken();

    return await http.post(
      Uri.parse('http://23.152.0.13:3000/news'),
      body: eventJson,
      headers: {'Authorization': 'Bearer ' + _accessToken},
    );
  }
}
