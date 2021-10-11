import 'dart:convert';
import 'package:event_on_map/news_widget/models/news.dart';
import 'package:http/http.dart' as http;


class NewsProvider {

  Future<List<News>> getNews() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1/comments'));
    if(response.statusCode == 200) {
      final List<dynamic> newsJson = json.decode(response.body);
      return newsJson.map((json) => News.fromJson(json)).toList();
    }else {
      throw Exception('Error');
    }
  }
}