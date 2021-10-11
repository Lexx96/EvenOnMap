import 'dart:convert';
import 'package:event_on_map/news_widget/models/news.dart';
import 'package:http/http.dart' as http;

// Provider в BLoC отвечает за предоставление аозможность get запросов
class NewsProvider {

  Future<List<News>> getNews() async {
    Uri url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1/comments');  // ложим юрл в переменную
    final response = await http.get(url);             // делаем гет запрос и результат ложим в переменную
    if(response.statusCode == 200) {  // проверяем на правельность
      final List<dynamic> newsJson = json.decode(response.body);    // в перемнную положили декодированное боди запроса
      return newsJson.map((json) => News.fromJson(json)).toList();  // возвращаем переменную с боди ответа и мапим в метод News.fromJson и делаем toList()
    }else {
      throw Exception('Error');  // в случае если статус код не 200 выдвем ошибку
    }
  }
}