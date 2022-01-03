class UserDataModel {
  String? id;
  String? phone;
  String? username;
  String? patronimyc;
  String? city;
  String? email;
  String? status;

  UserDataModel({
    this.id,
    this.phone,
    this.username,
    this.patronimyc,
    this.city,
    this.email,
    this.status,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json["id"] as String,
      phone: json["phone"] as String,
      username: json["username"] as String,
      patronimyc: json["patronimyc"] as String,
      city: json["city"] as String,
      email: json["email"] as String,
      status: json["status"] as String,
    );
  }
}
