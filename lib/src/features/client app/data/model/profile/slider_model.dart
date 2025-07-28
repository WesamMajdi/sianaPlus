import 'package:maintenance_app/src/core/pagination/paginated_response.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/product/product_model.dart';

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

class HomeModel {
  final PaginatedResponse<ImageModel> images;
  final List<ProductModel> usedProduct;
  final List<ProductModel> spareParts;

  HomeModel({
    required this.images,
    required this.usedProduct,
    required this.spareParts,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      images: PaginatedResponse<ImageModel>.fromJson(
        json['images'],
        (imgJson) => ImageModel.fromJson(imgJson),
      ),
      usedProduct: List<ProductModel>.from(
        json['usedProduct'].map((p) => ProductModel.fromJson(p)),
      ),
      spareParts: List<ProductModel>.from(
        json['spareParts'].map((p) => ProductModel.fromJson(p)),
      ),
    );
  }
}
