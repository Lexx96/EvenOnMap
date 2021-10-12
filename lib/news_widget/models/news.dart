
class News {
  String name;
  String email;
  String body;

  News({
    required this.name,
    required this.email,
    required this.body,
  });

  factory News.fromJson(Map<String, dynamic> json){
    return News(
      name: json['name'] as String,
      email: json['email'] as String,
      body: json['body'] as String,
    );
  }
}
