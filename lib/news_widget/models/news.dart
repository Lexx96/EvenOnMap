

// создали класс с свойствами для декодирования
class News {
  String name;
  String email;
  String body;
// конструктор класса
  News({
    required this.name,
    required this.email,
    required this.body,
  });
// метод для декодирования
  factory News.fromJson(Map<String, dynamic> json){
    return News(
      name: json['name'],
      email: json['email'],
      body: json['body']
    );
  }
}
