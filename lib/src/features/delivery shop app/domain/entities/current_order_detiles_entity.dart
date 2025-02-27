import 'package:maintenance_app/src/features/delivery%20shop%20app/data/model/receive_order_detiels_model.dart';

class OrderCurrentDetailsEntity {
  final int orderStatus;
  final int basketId;
  final List<ReceiveOrderDetielsModel>? orders;

  OrderCurrentDetailsEntity({
    required this.orderStatus,
    required this.basketId,
    required this.orders,
  });
}
