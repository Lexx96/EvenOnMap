
import 'package:event_on_map/news_page/models/user.dart';

import 'images.dart';

class GetNewsFromServerModel {
  String id;
  String title;
  String description;
  dynamic lat;
  dynamic lng;
  String userId;
  String createdAt;
  String updatedAt;
  List<Images> images;
  Map<String, dynamic> user;

  GetNewsFromServerModel({
    required this.id,
    required this.title,
    required this.description,
    required this.lat,
    required this.lng,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
    required this.user,
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
      images: (newsJson['images'] as List<dynamic>)
          .map((dynamic e) => Images.fromJson(e as Map<String, dynamic>))
          .toList(),
      user: newsJson['user'] as Map<String, dynamic>
    );
  }
}
