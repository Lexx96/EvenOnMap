class NewEventModel {
  String? id;
  String? title;
  String? description;
  dynamic lat;
  dynamic lng;
  String? userId;
  String? createdAt;
  String? updatedAt;

  NewEventModel({
    this.id,
    this.title,
    this.description,
    this.lat,
    this.lng,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory NewEventModel.fromJson(Map<String, dynamic> eventJson) {
    return NewEventModel(
      id: eventJson['id'] as String,
      userId: eventJson['user_id'] as String,
      title: eventJson['title'] as String,
      description: eventJson['description'] as String,
      lat: eventJson['lat'] as double,
      lng: eventJson['lng'] as double,
      createdAt: eventJson['createdAt'] as String,
      updatedAt: eventJson['updatedAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title as String,
      "description": description as String,
      "lat": lat as String,
      "lng": lng as String,
    };
  }
}

