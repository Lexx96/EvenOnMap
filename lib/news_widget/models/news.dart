
class GetNewsFromServerModel {
  String id;
  String title;
  String description;
  dynamic lat;
  dynamic lng;
  String userId;
  String createdAt;
  String updatedAt;

  GetNewsFromServerModel({
    required this.id,
    required this.title,
    required this.description,
    required this.lat,
    required this.lng,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GetNewsFromServerModel.fromJson(Map<String, dynamic> newsJson){
    return GetNewsFromServerModel(
      id: newsJson['id'] as String,
      userId: newsJson['user_id'] as String,
      title: newsJson['title'] as String,
      description: newsJson['description'] as String,
      lat: newsJson['lat'] as dynamic,
      lng: newsJson['lng'] as dynamic,
      createdAt: newsJson['createdAt'] as String,
      updatedAt: newsJson['updatedAt'] as String,
    );
  }
}
