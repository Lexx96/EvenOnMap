/// Модель загрузки профиля пользователя
class User {
  final String id;
  final String phone;
  final String username;
  final String patronimyc;
  final String city;
  final String email;
  final String status;
  final String createdAt;
  final Map<String, dynamic> photo;

  User({
    required this.id,
    required this.phone,
    required this.username,
    required this.patronimyc,
    required this.city,
    required this.email,
    required this.status,
    required this.createdAt,
    required this.photo,
  });


  factory User.fromJson (Map<String, dynamic> userJson) {
    return User(
      id: userJson['id'] as String,
      phone: userJson['phone'] as String,
      username: userJson['username'] as String,
      patronimyc: userJson['patronimyc'] as String,
      city: userJson['city'] as String,
      email: userJson['email'] as String,
      status: userJson['status'] as String,
      createdAt: userJson['createdAt'] as String,
      photo: userJson['photo'] as Map<String, dynamic>,
    );
  }
}