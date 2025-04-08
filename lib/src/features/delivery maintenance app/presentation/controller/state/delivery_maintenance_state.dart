import 'package:equatable/equatable.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/data/model/branch_model.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/entities/order_maintenances_details_entity.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/entities/receive_order_Maintenance_entity.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/hand_receipt_maintenance_parts/hand_receipt_maintenance_parts_entitie.dart';

enum DeliveryMaintenanceStatus { initial, loading, success, failure }

class DeliveryMaintenanceState extends Equatable {
  final DeliveryMaintenanceStatus deliveryMaintenanceStatus;
  final List<ReceiveMaintenanceOrderEntity> orders;
  final String errorMessage;
  final int orderCurrentPage;
  final int orderPerviousPage;
  final List<Branch> branch;
  final List<OrderMaintenancesDetailsEntity> selectedOrderDetilesItems;
  final String successMessage;
  final List<ReceiveMaintenanceOrderEntity> ordersOld;
  final List<ReceiveMaintenanceOrderEntity> ordersCurrent;

  const DeliveryMaintenanceState({
    this.deliveryMaintenanceStatus = DeliveryMaintenanceStatus.initial,
    this.orders = const <ReceiveMaintenanceOrderEntity>[],
    this.errorMessage = '',
    this.orderCurrentPage = 1,
    this.orderPerviousPage = 1,
    this.successMessage = '',
    this.branch = const <Branch>[],
    this.selectedOrderDetilesItems = const <OrderMaintenancesDetailsEntity>[],
    this.ordersOld = const <ReceiveMaintenanceOrderEntity>[],
    this.ordersCurrent = const <ReceiveMaintenanceOrderEntity>[],
  });

  factory DeliveryMaintenanceState.initial() {
    return const DeliveryMaintenanceState(
      deliveryMaintenanceStatus: DeliveryMaintenanceStatus.initial,
      orders: [],
      branch: [],
      selectedOrderDetilesItems: [],
      ordersOld: [],
      ordersCurrent: [],
      errorMessage: '',
      successMessage: '',
      orderCurrentPage: 1,
      orderPerviousPage: 1,
    );
  }

  DeliveryMaintenanceState copyWith({
    DeliveryMaintenanceStatus? deliveryMaintenanceStatus,
    List<ReceiveMaintenanceOrderEntity>? orders,
    HandReceiptEntity? transfer,
    final List<OrderMaintenancesDetailsEntity>? selectedOrderDetilesItems,
    String? errorMessage,
    String? successMessage,
    int? orderCurrentPage,
    int? orderPerviousPage,
    List<ReceiveMaintenanceOrderEntity>? ordersOld,
    List<ReceiveMaintenanceOrderEntity>? ordersCurrent,
    final List<Branch>? branch,
  }) {
    return DeliveryMaintenanceState(
        deliveryMaintenanceStatus:
            deliveryMaintenanceStatus ?? this.deliveryMaintenanceStatus,
        orders: orders ?? this.orders,
        selectedOrderDetilesItems:
            selectedOrderDetilesItems ?? this.selectedOrderDetilesItems,
        ordersCurrent: ordersCurrent ?? this.ordersCurrent,
        ordersOld: ordersOld ?? this.ordersOld,
        errorMessage: errorMessage ?? this.errorMessage,
        successMessage: successMessage ?? this.successMessage,
        orderCurrentPage: orderCurrentPage ?? this.orderCurrentPage,
        orderPerviousPage: orderPerviousPage ?? this.orderPerviousPage,
        branch: branch ?? this.branch);
  }

  @override
  List<Object?> get props => [
        deliveryMaintenanceStatus,
        orders,
        ordersCurrent,
        selectedOrderDetilesItems,
        ordersOld,
        errorMessage,
        branch,
        successMessage,
        orderCurrentPage,
        orderPerviousPage
      ];
}
