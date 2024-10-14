class CartItemModel {
  final int id;
  final String name;
  final double price;
  final String imagePath;
  int quantity;

  CartItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    this.quantity = 1,
  });
}
