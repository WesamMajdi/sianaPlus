class Order {
  final int id;
  final String imageUrl;
  final String serviceName;
  final double price;
  final String? status;
  final String? deliveryTime;

  Order({
    required this.id,
    required this.imageUrl,
    required this.serviceName,
    required this.price,
    this.status,
    this.deliveryTime,
  });
}
