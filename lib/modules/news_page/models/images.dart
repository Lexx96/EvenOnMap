class Images {
  final String id;
  final String newsId;
  final String photo;
  final String createdAt;
  final String updatedAt;

  Images({
    required this.id,
    required this.newsId,
    required this.photo,
    required this.createdAt,
    required this.updatedAt
  });


  factory Images.fromJson (Map<String, dynamic> imagesJson) {
         return Images(
          id: imagesJson['id'] as String,
          newsId: imagesJson['newsId'] as String,
          photo: imagesJson['photo'] as String,
          createdAt: imagesJson['createdAt'] as String,
          updatedAt: imagesJson['updatedAt'] as String,
        );
  }
}
