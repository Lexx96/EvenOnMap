import 'package:event_on_map/news_widget/models/news.dart';
import 'package:event_on_map/news_widget/services/news_api_provider.dart';
/*
уровень repository(хранилище) может взаимодействовать с поставщиком данных и
выполнять их преобразование перед передачей их на уровень бизнесс логики
получается repository(хранилище) нужен для инкапсуляции провайдера от бизнесс логики???
 */
class NewsRepository{
  NewsProvider _newsProvider = NewsProvider();  // создали инстанс класса провайдера
  Future<List<News>> getAllNews() => _newsProvider.getNews();
  // создали метод, который будет возвращать метод getNews класса NewsProvider
  // Future<List<News>> т.к Future т.к. getNews async, List т.к. это лист
  // данных(см.модель) и модель по типу класса News(это и есть модель)
}