
import 'dart:convert';
import 'package:event_on_map/news_widget/models/news.dart';
import 'package:event_on_map/news_widget/services/news_api_repository.dart';
import 'package:http/http.dart';

class NewsProvider{

  Future<List<News>> getAllNews() async {
    final Response response = await NewsRepository.getNews();
    List<News> newsJsonModel = [];
    if(response.statusCode == 200) {
      try {
        final newsJsonList = jsonDecode(response.body) as List<dynamic>;
        newsJsonModel = newsJsonList
            .map(
                (dynamic json) => News.fromJson(json as Map<String, dynamic>))
            .toList();
        return newsJsonModel;
      } catch (_) {
        return newsJsonModel;
      }
    }
    return newsJsonModel;
  }

// метод который проверяет обновление токен
/*
чтение токена(отправка запроса если 403) то
получение нового токена
и сохр его в репозитории
 */
}

