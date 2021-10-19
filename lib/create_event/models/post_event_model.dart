

class NewEventModel {
  String? id;
  String? title;
  String? description;
  double? lat;
  double? lng;
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
      title: eventJson ['title'] as String,
      description: eventJson ['description'] as String,
      lat: eventJson ['lat'] as double,
      lng: eventJson ['lng'] as double,
      userId: eventJson ['userId'] as String,
      createAt: eventJson ['createAt'] as String,
      updateAt: eventJson ['updateAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id as String,
      "description": description as String,
      "lat": lat as double,
      "lng": lng as double,
      "userId": userId as String,
      "createAt": createAt as String,
      "updateAt": updateAt as String,
    };
  }
}
