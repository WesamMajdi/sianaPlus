import 'package:maintenance_app/src/features/client%20app/domain/entities/product/product_color.dart';

class Product {
  int? id;
  String? name;
  String? details;
  String? image;
  String? company;
  double? discount;
  double? price;
  double? originalPrice;
  double? basePrice;
  int? count;
  double? cost;
  int? countOrder;
  bool? isFavorite;
  List<ProductColorEntity>? productColors;
  ProductColorEntity? selectedColor;

  Product(
      {this.id,
      this.name,
      this.details,
      this.image,
      this.company,
      this.discount,
      this.price,
      this.originalPrice,
      this.basePrice,
      this.count,
      this.cost,
      this.countOrder,
      this.isFavorite = false,
      this.selectedColor,
      this.productColors});
}
