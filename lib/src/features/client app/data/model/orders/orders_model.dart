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
    deliveryDate = json['deliveryDate'];
    orderMaintenanceStatus = json['orderMaintenanceStatus'];
    isPayid = json['isPayid'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerName'] = this.customerName;
    data['customerPhoneNumber'] = this.customerPhoneNumber;
    data['total'] = this.total;
    data['discount'] = this.discount;
    data['totalAfterDiscount'] = this.totalAfterDiscount;
    data['handReceiptId'] = this.handReceiptId;
    data['deliveryDate'] = this.deliveryDate;
    data['orderMaintenanceStatus'] = this.orderMaintenanceStatus;
    data['isPayid'] = this.isPayid;
    data['createdAts'] = this.createdAt;
    return data;
  }
}
