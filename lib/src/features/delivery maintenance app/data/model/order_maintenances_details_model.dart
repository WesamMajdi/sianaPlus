import 'package:maintenance_app/src/features/delivery%20maintenance%20app/data/model/receive_order_maintenances_detiels_model.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/entities/order_maintenances_details_entity.dart';

class OrderMaintenancesDetielsModel extends OrderMaintenancesDetailsEntity {
  OrderMaintenancesDetielsModel.fromJson(Map<String, dynamic> json)
      : super(
          orderStatus: json['orderStatus'],
          handReceiptId: json['handReceiptId'],
          orders: json['orders'] != null && json['orders'] is List
              ? List<ReceiveOrderMaintenancesModel>.from(
                  (json['orders'] as List).map(
                    (orderJson) =>
                        ReceiveOrderMaintenancesModel.fromJson(orderJson),
                  ),
                )
              : [],
        );

  @override
  String toString() {
    return 'OrderDetailsModel(handReceiptId: $handReceiptId, orders: $orders)';
  }

  Map<String, dynamic> toJson() {
    return {
      'orderStatus': orderStatus,
      'handReceiptId': handReceiptId,
      'orders': orders?.map((order) => order.toJson()).toList() ?? [],
    };
  }
}
