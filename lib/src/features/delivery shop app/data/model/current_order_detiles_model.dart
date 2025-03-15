import 'package:maintenance_app/src/features/delivery%20shop%20app/data/model/receive_order_detiels_model.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/domain/entities/current_order_detiles_entity.dart';

class OrderDetailsModel extends OrderCurrentDetailsEntity {
  OrderDetailsModel.fromJson(Map<String, dynamic> json)
      : super(
          orderStatus: json['orderStatus'],
          basketId: json['basketId'],
          orders: List<ReceiveOrderDetielsModel>.from(
            json['orders'].map(
                (orderJson) => ReceiveOrderDetielsModel.fromJson(orderJson)),
          ),
        );
  @override
  String toString() {
    return 'OrderDetailsModel(basketId: $basketId, orders: $orders)';
  }

  Map<String, dynamic> toJson() {
    return {
      'orderStatus': orderStatus,
      'basketId': basketId,
      'orders': orders!.map((order) => order.toJson()).toList(),
    };
  }
}
