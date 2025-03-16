import 'package:equatable/equatable.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/data/model/branch_model.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/entities/order_maintenances_details_entity.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/entities/receive_order_Maintenance_entity.dart';

enum DeliveryMaintenanceStatus { initial, loading, success, failure }

class DeliveryMaintenanceState extends Equatable {
  final DeliveryMaintenanceStatus deliveryMaintenanceStatus;
  final List<ReceiveMaintenanceOrderEntity> orders;
  final String errorMessage;
  final List<Branch> branch;
  final List<OrderMaintenancesDetailsEntity> selectedOrderDetilesItems;
  final String successMessage;
  final List<ReceiveMaintenanceOrderEntity> ordersOld;
  final List<ReceiveMaintenanceOrderEntity> ordersCurrent;

  const DeliveryMaintenanceState({
    this.deliveryMaintenanceStatus = DeliveryMaintenanceStatus.initial,
    this.orders = const <ReceiveMaintenanceOrderEntity>[],
    this.errorMessage = '',
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
    );
  }

  DeliveryMaintenanceState copyWith({
    DeliveryMaintenanceStatus? deliveryMaintenanceStatus,
    List<ReceiveMaintenanceOrderEntity>? orders,
    final List<OrderMaintenancesDetailsEntity>? selectedOrderDetilesItems,
    String? errorMessage,
    String? successMessage,
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
      ];
}
