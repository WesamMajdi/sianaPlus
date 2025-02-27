class ReceiveOrderEntity {
  final int id;
  final String customerName;
  final String? customerPhoneNumber;
  final double? total;
  final double? discount;
  final double? totalAfterDiscount;
  final String? deliveryDate;
  final String? locationForDelivery;
  final int orderStatus;

  ReceiveOrderEntity({
    required this.id,
    required this.customerName,
    this.customerPhoneNumber,
    required this.total,
    required this.discount,
    required this.totalAfterDiscount,
    this.deliveryDate,
    this.locationForDelivery,
    required this.orderStatus,
  });
}
