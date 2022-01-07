import 'package:event_on_map/modules/auth/services/user_log_in/user_log_in_api_repository.dart';
import 'package:event_on_map/utils/app_url/app_url.dart';
import 'package:http/http.dart' as http;

/// Класс управления запросами модуля news
class NewsRepository {

  /// Получение accessToken из SharedPreferences и получение новостей
  static getAllNews<Response>() async {
    String _accessToken = await SetAndReadDataFromSharedPreferences().readAccessToken();
    return await http.get(
      Uri.parse(AppUrl.urlGetNews),
      headers: {'Authorization': 'Bearer ' + _accessToken},
    );
  }
}
