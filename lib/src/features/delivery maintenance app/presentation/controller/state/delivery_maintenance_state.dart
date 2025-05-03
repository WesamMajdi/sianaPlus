import 'package:equatable/equatable.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/data/model/branch_model.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/data/model/receipt_item_convert_model.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/entities/order_maintenances_details_entity.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/entities/receive_order_Maintenance_entity.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/hand_receipt_maintenance_parts/hand_receipt_maintenance_parts_entitie.dart';

// Enums
enum DeliveryMaintenanceStatus { initial, loading, success, failure }

enum DeliveryMaintenanceConvertStatus { initial, loading, success, failure }

enum DeliveryMaintenanceCurrentConvertStatus {
  initial,
  loading,
  success,
  failure
}

enum DeliveryMaintenancePerviousConvertStatus {
  initial,
  loading,
  success,
  failure
}

enum DeliveryMaintenanceOutSideStatus { initial, loading, success, failure }

enum DeliveryMaintenanceCurrentOutSideStatus {
  initial,
  loading,
  success,
  failure
}

enum DeliveryMaintenancePerviousOutSideStatus {
  initial,
  loading,
  success,
  failure
}

// State Class
class DeliveryMaintenanceState extends Equatable {
  final DeliveryMaintenanceStatus deliveryMaintenanceStatus;
  final DeliveryMaintenanceConvertStatus deliveryMaintenanceConvertStatus;
  final DeliveryMaintenanceCurrentConvertStatus
      deliveryMaintenanceConvertCurrentStatus;
  final DeliveryMaintenancePerviousConvertStatus
      deliveryMaintenancePerviousConvertStatus;
  final DeliveryMaintenanceOutSideStatus deliveryMaintenanceOutSideStatus;
  final DeliveryMaintenanceCurrentOutSideStatus
      deliveryMaintenanceCurrentOutSideStatus;
  final DeliveryMaintenancePerviousOutSideStatus
      deliveryMaintenancePerviousOutSideStatus;
  final List<ReceiveMaintenanceOrderEntity> orders;
  final List<ReceiptItemConvertModel> ordersConvert;
  final List<ReceiptItemConvertModel> ordersCurrentConvert;
  final List<ReceiptItemConvertModel> ordersPerviousConvert;
  final List<ReceiptItemConvertModel> ordersOutSide;
  final List<ReceiptItemConvertModel> ordersCurrentOutSide;
  final List<ReceiptItemConvertModel> ordersPerviousOutSide;
  final List<Branch> branch;
  final List<OrderMaintenancesDetailsEntity> selectedOrderDetilesItems;
  final List<ReceiveMaintenanceOrderEntity> ordersOld;
  final List<ReceiveMaintenanceOrderEntity> ordersCurrent;
  final String errorMessage;
  final String successMessage;
  final int orderCurrentPage;
  final int orderPerviousPage;
  final int page;
  final bool hasReachedMax;

  const DeliveryMaintenanceState({
    this.deliveryMaintenanceStatus = DeliveryMaintenanceStatus.initial,
    this.deliveryMaintenanceConvertStatus =
        DeliveryMaintenanceConvertStatus.initial,
    this.deliveryMaintenanceConvertCurrentStatus =
        DeliveryMaintenanceCurrentConvertStatus.initial,
    this.deliveryMaintenancePerviousConvertStatus =
        DeliveryMaintenancePerviousConvertStatus.initial,
    this.deliveryMaintenanceOutSideStatus =
        DeliveryMaintenanceOutSideStatus.initial,
    this.deliveryMaintenanceCurrentOutSideStatus =
        DeliveryMaintenanceCurrentOutSideStatus.initial,
    this.deliveryMaintenancePerviousOutSideStatus =
        DeliveryMaintenancePerviousOutSideStatus.initial,
    this.orders = const [],
    this.ordersConvert = const [],
    this.ordersCurrentConvert = const [],
    this.ordersPerviousConvert = const [],
    this.ordersOutSide = const [],
    this.ordersCurrentOutSide = const [],
    this.ordersPerviousOutSide = const [],
    this.branch = const [],
    this.selectedOrderDetilesItems = const [],
    this.ordersOld = const [],
    this.ordersCurrent = const [],
    this.errorMessage = '',
    this.successMessage = '',
    this.orderCurrentPage = 1,
    this.orderPerviousPage = 1,
    this.page = 1,
    this.hasReachedMax = false,
  });

  factory DeliveryMaintenanceState.initial() {
    return const DeliveryMaintenanceState();
  }

  DeliveryMaintenanceState copyWith({
    DeliveryMaintenanceStatus? deliveryMaintenanceStatus,
    DeliveryMaintenanceConvertStatus? deliveryMaintenanceConvertStatus,
    DeliveryMaintenanceCurrentConvertStatus?
        deliveryMaintenanceConvertCurrentStatus,
    DeliveryMaintenancePerviousConvertStatus?
        deliveryMaintenancePerviousConvertStatus,
    DeliveryMaintenanceOutSideStatus? deliveryMaintenanceOutSideStatus,
    DeliveryMaintenanceCurrentOutSideStatus?
        deliveryMaintenanceCurrentOutSideStatus,
    DeliveryMaintenancePerviousOutSideStatus?
        deliveryMaintenancePerviousOutSideStatus,
    List<ReceiveMaintenanceOrderEntity>? orders,
    List<ReceiptItemConvertModel>? ordersConvert,
    List<ReceiptItemConvertModel>? ordersCurrentConvert,
    List<ReceiptItemConvertModel>? ordersPerviousConvert,
    List<ReceiptItemConvertModel>? ordersOutSide,
    List<ReceiptItemConvertModel>? ordersCurrentOutSide,
    List<ReceiptItemConvertModel>? ordersPerviousOutSide,
    List<Branch>? branch,
    List<OrderMaintenancesDetailsEntity>? selectedOrderDetilesItems,
    List<ReceiveMaintenanceOrderEntity>? ordersOld,
    List<ReceiveMaintenanceOrderEntity>? ordersCurrent,
    String? errorMessage,
    String? successMessage,
    int? orderCurrentPage,
    int? orderPerviousPage,
    int? page,
    bool? hasReachedMax,
  }) {
    return DeliveryMaintenanceState(
        deliveryMaintenanceStatus:
            deliveryMaintenanceStatus ?? this.deliveryMaintenanceStatus,
        deliveryMaintenanceConvertStatus: deliveryMaintenanceConvertStatus ??
            this.deliveryMaintenanceConvertStatus,
        deliveryMaintenanceConvertCurrentStatus:
            deliveryMaintenanceConvertCurrentStatus ??
                this.deliveryMaintenanceConvertCurrentStatus,
        deliveryMaintenancePerviousConvertStatus:
            deliveryMaintenancePerviousConvertStatus ??
                this.deliveryMaintenancePerviousConvertStatus,
        deliveryMaintenanceOutSideStatus: deliveryMaintenanceOutSideStatus ??
            this.deliveryMaintenanceOutSideStatus,
        deliveryMaintenanceCurrentOutSideStatus:
            deliveryMaintenanceCurrentOutSideStatus ??
                this.deliveryMaintenanceCurrentOutSideStatus,
        deliveryMaintenancePerviousOutSideStatus:
            deliveryMaintenancePerviousOutSideStatus ??
                this.deliveryMaintenancePerviousOutSideStatus,
        orders: orders ?? this.orders,
        ordersConvert: ordersConvert ?? this.ordersConvert,
        ordersCurrentConvert: ordersCurrentConvert ?? this.ordersCurrentConvert,
        ordersPerviousConvert:
            ordersPerviousConvert ?? this.ordersPerviousConvert,
        branch: branch ?? this.branch,
        selectedOrderDetilesItems:
            selectedOrderDetilesItems ?? this.selectedOrderDetilesItems,
        ordersOld: ordersOld ?? this.ordersOld,
        ordersCurrent: ordersCurrent ?? this.ordersCurrent,
        errorMessage: errorMessage ?? this.errorMessage,
        successMessage: successMessage ?? this.successMessage,
        orderCurrentPage: orderCurrentPage ?? this.orderCurrentPage,
        orderPerviousPage: orderPerviousPage ?? this.orderPerviousPage,
        page: page ?? this.page,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        ordersOutSide: ordersOutSide ?? this.ordersOutSide,
        ordersCurrentOutSide: ordersCurrentOutSide ?? this.ordersCurrentOutSide,
        ordersPerviousOutSide:
            ordersPerviousOutSide ?? this.ordersPerviousOutSide);
  }

  @override
  List<Object?> get props => [
        deliveryMaintenanceStatus,
        deliveryMaintenanceConvertStatus,
        deliveryMaintenanceConvertCurrentStatus,
        deliveryMaintenancePerviousConvertStatus,
        deliveryMaintenanceOutSideStatus,
        deliveryMaintenanceCurrentOutSideStatus,
        deliveryMaintenancePerviousOutSideStatus,
        orders,
        ordersConvert,
        ordersCurrentConvert,
        ordersPerviousConvert,
        branch,
        selectedOrderDetilesItems,
        ordersOld,
        ordersCurrent,
        errorMessage,
        successMessage,
        orderCurrentPage,
        orderPerviousPage,
        page,
        hasReachedMax,
        ordersOutSide,
        ordersCurrentOutSide,
        ordersPerviousOutSide
      ];
}
