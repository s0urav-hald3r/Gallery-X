class ImageModel {
  final String id;
  final String imageUrl;
  final int likes;
  final int views;

  ImageModel(
      {required this.id,
      required this.imageUrl,
      required this.likes,
      required this.views});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'].toString(),
      imageUrl: json['webformatURL'],
      likes: json['likes'],
      views: json['views'],
    );
  }
}
