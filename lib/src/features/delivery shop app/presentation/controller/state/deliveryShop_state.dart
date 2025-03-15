import 'package:equatable/equatable.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/data/model/current_order_detiles_model.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/domain/entities/current_order_detiles_entity.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/domain/entities/receive_order_entity.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/domain/entities/receive_order_detiels_entity.dart';

enum DeliveryShopStatus { initial, loading, success, failure }

class DeliveryShopState extends Equatable {
  final DeliveryShopStatus deliveryShopStatus;
  final List<ReceiveOrderEntity> orders;
  final List<OrderCurrentDetailsEntity> selectedOrderDetilesCurrentItems;
  final List<ReceiveOrderEntity> ordersOld;
  final String errorMessage;
  final String successMessage;
  final String deliveryLocation;
  final double? totalCost;
  final List<ReceiveOrderDetielsEntity> selectedOrderItems;
  final int basketId;

  DeliveryShopState({
    this.deliveryShopStatus = DeliveryShopStatus.initial,
    this.orders = const <ReceiveOrderEntity>[],
    this.ordersOld = const <ReceiveOrderEntity>[],
    this.errorMessage = '',
    this.successMessage = '',
    this.deliveryLocation = '',
    this.totalCost,
    this.selectedOrderItems = const <ReceiveOrderDetielsEntity>[],
    this.basketId = 0,
    this.selectedOrderDetilesCurrentItems = const <OrderCurrentDetailsEntity>[],
  });

  factory DeliveryShopState.initial() {
    return DeliveryShopState(
      deliveryShopStatus: DeliveryShopStatus.initial,
      orders: [],
      ordersOld: [],
      errorMessage: '',
      successMessage: '',
      deliveryLocation: '',
      totalCost: null,
      selectedOrderItems: [],
      selectedOrderDetilesCurrentItems: [],
      basketId: 0,
    );
  }

  DeliveryShopState copyWith({
    DeliveryShopStatus? deliveryShopStatus,
    List<ReceiveOrderEntity>? orders,
    List<ReceiveOrderEntity>? ordersOld,
    String? errorMessage,
    String? successMessage,
    String? deliveryLocation,
    double? totalCost,
    List<ReceiveOrderDetielsEntity>? selectedOrderItems,
    List<OrderCurrentDetailsEntity>? selectedOrderDetilesCurrentItems,
    int? basketId,
  }) {
    return DeliveryShopState(
      deliveryShopStatus: deliveryShopStatus ?? this.deliveryShopStatus,
      orders: orders ?? this.orders,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      deliveryLocation: deliveryLocation ?? this.deliveryLocation,
      totalCost: totalCost ?? this.totalCost,
      ordersOld: ordersOld ?? this.ordersOld,
      selectedOrderItems: selectedOrderItems ?? this.selectedOrderItems,
      selectedOrderDetilesCurrentItems: selectedOrderDetilesCurrentItems ??
          this.selectedOrderDetilesCurrentItems,
      basketId: basketId ?? this.basketId,
    );
  }

  @override
  List<Object?> get props => [
        deliveryShopStatus,
        orders,
        errorMessage,
        successMessage,
        deliveryLocation,
        totalCost,
        ordersOld,
        selectedOrderItems,
        selectedOrderDetilesCurrentItems,
        basketId,
      ];
  List<ReceiveOrderDetielsEntity> getFilteredOrderItems() {
    List<ReceiveOrderDetielsEntity> filteredItems =
        selectedOrderItems.where((item) => item.id == basketId).toList();

    return filteredItems;
  }
}
