import 'package:maintenance_app/src/features/delivery%20maintenance%20app/data/model/order_maintenances_details_model.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/data/model/receive_order_maintenances_detiels_model.dart';

class OrderMaintenancesDetailsEntity {
  final int orderStatus;
  final int handReceiptId;
  final List<ReceiveOrderMaintenancesModel>? orders;

  OrderMaintenancesDetailsEntity({
    required this.orderStatus,
    required this.handReceiptId,
    required this.orders,
  });
}
