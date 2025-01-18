enum OrderMaintenanceStatus {
  newOrder, // ID 1
  takeFromCustomer, // ID 2
  deliveryToBranch, // ID 3
  maintenanceEnd, // ID 4
  takeFromBranch, // ID 5
  returnToCustomer, // ID 6
  completed // ID 7
}
class OrderEntity {
  int? id;
  String? customerName;
  String? customerPhoneNumber;
  int? total;
  int? discount;
  int? totalAfterDiscount;
  int? handReceiptId;
  DateTime? deliveryDate;
  int? orderMaintenanceStatus;

  OrderEntity(
      {this.id,
        this.customerName,
        this.customerPhoneNumber,
        this.total,
        this.discount,
        this.totalAfterDiscount,
        this.handReceiptId,
        this.deliveryDate,
        this.orderMaintenanceStatus});
}

