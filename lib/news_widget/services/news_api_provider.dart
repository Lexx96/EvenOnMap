
import 'package:http/http.dart' as http;


class NewsProvider {

  Future<String> getNews() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1/comments'));
    if(response.statusCode == 200) {
      return response.body;
    }else {
      throw Exception(response.statusCode);
    }
  }
}