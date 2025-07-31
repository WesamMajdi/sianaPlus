import 'package:maintenance_app/src/features/client%20app/domain/entities/product/product_color.dart';
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

  Product({
    this.id,
    this.name,
    this.details,
    this.image,
    this.company,
    this.discount,
    this.basePrice,
    this.originalPrice,
    this.price,
    this.count,
    this.userCount = 1,
    this.cost,
    this.countOrder,
    this.isFavorite = false,
    this.selectedColor,
    this.productColors,
  });

  Product copyWith({
    int? id,
    String? name,
    String? details,
    String? image,
    String? company,
    dynamic discount,
    dynamic basePrice,
    dynamic originalPrice,
    dynamic price,
    dynamic userCount,
    dynamic count,
    dynamic cost,
    dynamic countOrder,
    bool? isFavorite,
    List<ProductColorEntity>? productColors,
    ProductColorEntity? selectedColor,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      details: details ?? this.details,
      image: image ?? this.image,
      company: company ?? this.company,
      discount: discount ?? this.discount,
      basePrice: basePrice ?? this.basePrice,
      originalPrice: originalPrice ?? this.originalPrice,
      price: price ?? this.price,
      userCount: userCount ?? this.userCount,
      count: count ?? this.count,
      cost: cost ?? this.cost,
      countOrder: countOrder ?? this.countOrder,
      isFavorite: isFavorite ?? this.isFavorite,
      productColors: productColors ?? this.productColors,
      selectedColor: selectedColor ?? this.selectedColor,
    );
  }
}
