class OrderProduct {
  final int total;
  final String locationForDelivery;
  final int? regionId;
  final int? cityId;
  final int? villageId;
  final int orderId;
  final String? addressLine1;
  final String? addressLine2;
  final int? shipmentId;
  final String barcode;
  final double discount;
  final List<OrderItem> orders;

  OrderProduct({
    required this.total,
    required this.locationForDelivery,
    required this.regionId,
    required this.cityId,
    required this.villageId,
    required this.orderId,
    required this.addressLine1,
    required this.addressLine2,
    required this.shipmentId,
    required this.barcode,
    required this.discount,
    required this.orders,
  });

  Map<String, dynamic> toJson() {
    return {
      "total": total,
      "locationForDelivery": locationForDelivery,
      "regionId": regionId,
      "cityId": cityId,
      "villageId": villageId,
      "orderId": orderId,
      "addressLine1": addressLine1,
      "addressLine2": addressLine2,
      "shipmentId": shipmentId,
      "barcode": barcode,
      "discount": discount,
      "orders": orders.map((item) => item.toJson()).toList(),
    };
  }
}

class OrderItem {
  int count;
  int discount;
  double price;
  int productColorId;
  String productName;
  String productColor;

  OrderItem({
    required this.count,
    required this.discount,
    required this.price,
    required this.productColorId,
    required this.productName,
    required this.productColor,
  });

  Map<String, dynamic> toJson() {
    return {
      "count": count,
      "discount": discount,
      "price": price,
      "productColorId": productColorId,
      "productName": productName,
      "productColor": productColor,
    };
  }
}
