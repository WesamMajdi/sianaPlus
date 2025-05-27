class ImageModel {
  final int id;
  final String imagePath;
  final String caption;
  final int sortOrder;

  ImageModel({
    required this.id,
    required this.imagePath,
    required this.caption,
    required this.sortOrder,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      imagePath: json['imagePath'],
      caption: json['caption'],
      sortOrder: json['sortOrder'],
    );
  }
}
