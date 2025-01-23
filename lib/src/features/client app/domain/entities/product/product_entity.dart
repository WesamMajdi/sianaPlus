import 'package:maintenance_app/src/features/client%20app/domain/entities/product/product_color.dart';

class Product {
  int? id;
  String? name;
  String? details;
  String? image;
  String? company;
  int? discount;
  int? price;
  int? count;
  int? cost;
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
      this.count,
      this.cost,
      this.countOrder,
      this.isFavorite=false,
      this.selectedColor,
      this.productColors});
}
