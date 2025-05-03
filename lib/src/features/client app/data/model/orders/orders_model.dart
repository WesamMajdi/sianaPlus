import '../../../domain/entities/orders/orders_entity.dart';

class OrderModel extends OrderEntity {
  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customerName'];
    customerPhoneNumber = json['customerPhoneNumber'];
    total = json['total'];
    discount = json['discount'];
    totalAfterDiscount = json['totalAfterDiscount'];
    handReceiptId = json['handReceiptId'];
    deliveryDate = json['deliveryDate'] != null
        ? DateTime.parse(json['deliveryDate'])
        : null;
    createdAt = json['createdAt'];
    orderMaintenanceStatus = json['orderMaintenanceStatus'];
    isPayid = json['isPayid'];
    deliveryName = json['deliveryName'];
    locationForDelivery = json['locationForDelivery'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customerName'] = customerName;
    data['customerPhoneNumber'] = customerPhoneNumber;
    data['total'] = total;
    data['discount'] = discount;
    data['totalAfterDiscount'] = totalAfterDiscount;
    data['handReceiptId'] = handReceiptId;
    data['deliveryDate'] = deliveryDate?.toIso8601String();
    data['createdAt'] = createdAt;
    data['orderMaintenanceStatus'] = orderMaintenanceStatus;
    data['isPayid'] = isPayid;
    data['deliveryName'] = deliveryName;
    data['locationForDelivery'] = locationForDelivery;
    return data;
  }
}
