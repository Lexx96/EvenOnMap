
import 'package:http/http.dart' as http;

class NewsRepository {
  static getNews <Response> () async {
    return await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1/comments'));
  }



  //метода
/*
получение данных с сервера
сохр в лок хранилище
чтение их лок хранил
 */
}