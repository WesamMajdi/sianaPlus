import '../../../../core/export file/exportfiles.dart';

class Product {
  final String name;
  final String description;
  final String imagePath;
  final double price;
  final double discount;
  final int quantity;
  final bool isFavorite;
  final List<Color> colors;
  final double rating;

  Product({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.discount,
    this.quantity = 1,
    this.isFavorite = false,
    required this.colors,
    required this.rating,
  });
}
