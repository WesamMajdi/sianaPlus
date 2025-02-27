class ReceiveOrderDetielsEntity {
  final int id;
  final String? productName;
  final String? productImage;
  final String? productCompany;
  final String? productColor;
  final int? count;
  final double? price;
  final double? discount;
  final double? total;

  ReceiveOrderDetielsEntity({
    required this.id,
    required this.productName,
    required this.productImage,
    required this.productCompany,
    required this.productColor,
    required this.count,
    required this.price,
    required this.discount,
    required this.total,
  });

  @override
  String toString() {
    return 'ReceiveOrderDetielsEntity(id: $id, productName: $productName, productImage: $productImage, productCompany: $productCompany, productColor: $productColor, count: $count, price: $price, discount: $discount, total: $total)';
  }
}
