import 'dart:convert';
import 'package:event_on_map/modules/news/bloc/news_bloc.dart';
import 'package:event_on_map/modules/news/models/news.dart';
import 'package:http/http.dart';
import 'news_api_repository.dart';

/// Сервис обработки запросов модуля news
class NewsProvider {

  /// Получение новостей с сервера
  Future<List<GetNewsFromServerModel>> getAllNewsFromServer() async {
    final Response response = await NewsRepository.getAllNews();
    List<GetNewsFromServerModel> newsJsonModel = [];
    if (response.statusCode == 200) {
      try {
        final newsJsonList = jsonDecode(response.body) as List<dynamic>;
        final newsJsonModel = newsJsonList.map((dynamic e) => GetNewsFromServerModel.fromJson(e as Map<String, dynamic>)).toList();
        return newsJsonModel;
      } catch (_) {
        return newsJsonModel;
      }
    } else if(response.statusCode == 400){
      throw DataErrorSendingServerException;
    } else if(response.statusCode == 500){
      throw NotRegisteredSendingServerException;
    } else {
      return newsJsonModel;
    }
  }
}
