

class NewEventModel {
  String? id;
  String? title;
  String? description;
  dynamic lat;
  dynamic lng;
  String? userId;
  String? createAt;
  String? updateAt;

  NewEventModel({
    this.id,
    this.title,
    this.description,
    this.lat,
    this.lng,
    this.userId,
    this.createAt,
    this.updateAt,
  });

  factory NewEventModel.fromJson(Map<String, dynamic> eventJson){
    return NewEventModel(
      id: eventJson ['id'] as String,
      userId: eventJson ['userId'] as String,
      title: eventJson ['title'] as String,
      description: eventJson ['description'] as String,
      lat: eventJson ['lat'] as double,
      lng: eventJson ['lng'] as double,
      createAt: eventJson ['createAt'] as String,
      updateAt: eventJson ['updateAt'] as String,
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
