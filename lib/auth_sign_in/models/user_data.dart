
class UserData {
  String status;
  String phone;

  UserData({
    required this.status,
    required this.phone,
  });

  factory UserData.fromJson(Map<String, dynamic> json){
    return UserData(
      status: json ['status'] as String,
      phone: json ['phone'] as String,
    );
  }
}
