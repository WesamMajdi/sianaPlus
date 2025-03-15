import 'package:maintenance_app/src/features/delivery%20shop%20app/domain/entities/receive_order_entity.dart';

class ReceiveOrderModel extends ReceiveOrderEntity {
  ReceiveOrderModel.fromJson(Map<String, dynamic> json)
      : super(
          id: json['id'],
          customerName: json['customerName'],
          customerPhoneNumber: json['customerPhoneNumber'],
          total: (json['total'] as int?)?.toDouble(),
          discount: (json['discount'] as int?)?.toDouble(),
          totalAfterDiscount: (json['totalAfterDiscount'] as int?)?.toDouble(),
          deliveryDate: json['deliveryDate'],
          locationForDelivery: json['locationForDelivery'],
          orderStatus: json['orderStatus'],
        );

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
