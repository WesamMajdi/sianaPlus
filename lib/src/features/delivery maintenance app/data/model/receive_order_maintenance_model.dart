import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/entities/receive_order_Maintenance_entity.dart';

class ReceiveMaintenanceOrderModel extends ReceiveMaintenanceOrderEntity {
  ReceiveMaintenanceOrderModel.fromJson(Map<String, dynamic> json)
      : super(
          id: json['id'],
          customerName: json['customerName'],
          locationForDelivery: json['locationForDelivery'],
          customerPhoneNumber: json['customerPhoneNumber'],
          total: (json['total'] as int?)?.toDouble(),
          discount: (json['discount'] as int?)?.toDouble(),
          totalAfterDiscount: (json['totalAfterDiscount'] as int?)?.toDouble(),
          handReceiptId: json['handReceiptId'],
          deliveryDate: json['deliveryDate'],
          orderMaintenanceStatus: json['orderMaintenanceStatus'],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerName': customerName,
      'locationForDelivery': locationForDelivery,
      'customerPhoneNumber': customerPhoneNumber,
      'total': total,
      'discount': discount,
      'totalAfterDiscount': totalAfterDiscount,
      'handReceiptId': handReceiptId,
      'deliveryDate': deliveryDate,
      'orderMaintenanceStatus': orderMaintenanceStatus,
    };
  }
}
