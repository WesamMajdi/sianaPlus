import 'package:maintenance_app/src/features/client%20app/domain/entities/product/product_color.dart';

class Product {
  int? id;
  String? name;
  String? details;
  String? image;
  String? company;
  dynamic discount;
  dynamic basePrice;
  dynamic originalPrice;
  dynamic price;
  dynamic userCount;
  dynamic count;
  dynamic cost;
  dynamic countOrder;
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
        this.basePrice,
        this.originalPrice,
      this.price,
      this.count,
      this.userCount=0,
      this.cost,
      this.countOrder,
      this.isFavorite=false,
      this.selectedColor,
      this.productColors});
}
