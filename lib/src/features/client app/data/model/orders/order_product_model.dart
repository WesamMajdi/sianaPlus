class OrderProductModel {
  final int id;
  final String customerName;
  final String customerPhoneNumber;
  final double total;
  final double discount;
  final double totalAfterDiscount;
  final String? deliveryDate;
  final String? locationForDelivery;
  final int orderStatus;

  OrderProductModel({
    required this.id,
    required this.customerName,
    required this.customerPhoneNumber,
    required this.total,
    required this.discount,
    required this.totalAfterDiscount,
    this.deliveryDate,
    this.locationForDelivery,
    required this.orderStatus,
  });

  // Factory method to create an OrderProduct from a JSON map
  factory OrderProductModel.fromJson(Map<String, dynamic> json) {
    return OrderProductModel(
      id: json['id'],
      customerName: json['customerName'],
      customerPhoneNumber: json['customerPhoneNumber'],
      total: json['total'].toDouble(),
      discount: json['discount'].toDouble(),
      totalAfterDiscount: json['totalAfterDiscount'].toDouble(),
      deliveryDate: json['deliveryDate'],
      locationForDelivery: json['locationForDelivery'],
      orderStatus: json['orderStatus'],
    );
  }

  // Method to convert the OrderProduct instance back to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerName': customerName,
      'customerPhoneNumber': customerPhoneNumber,
      'total': total,
      'discount': discount,
      'totalAfterDiscount': totalAfterDiscount,
      'deliveryDate': deliveryDate,
      'locationForDelivery': locationForDelivery,
      'orderStatus': orderStatus,
    };
  }
}
