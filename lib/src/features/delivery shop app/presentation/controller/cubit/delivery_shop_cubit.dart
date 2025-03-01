import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/domain/usecases/fetch_delivery_shop.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/controller/state/deliveryShop_state.dart';

class DeliveryShopCubit extends Cubit<DeliveryShopState> {
  final DeliveryShopUseCase deliveryShopUseCase;

  DeliveryShopCubit(this.deliveryShopUseCase) : super(DeliveryShopState());

  Future<void> fetchReceiveOrder({
    bool refresh = false,
  }) async {
    emit(state.copyWith(deliveryShopStatus: DeliveryShopStatus.loading));
    try {
      final page = refresh ? 1 : (state.orders.length ~/ 10) + 1;
      final result = await deliveryShopUseCase
          .getAllHandHandReceiptItem(PaginationParams(page: page));
      result.fold(
        (failure) => emit(state.copyWith(
            deliveryShopStatus: DeliveryShopStatus.failure,
            errorMessage: failure.message)),
        (orders) => emit(state.copyWith(
            deliveryShopStatus: DeliveryShopStatus.success,
            orders: orders.items)),
      );
    } catch (e) {
      emit(state.copyWith(
          deliveryShopStatus: DeliveryShopStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> fetchOrderItemsByBasketId(
    int basketId, {
    bool refresh = false,
  }) async {
    emit(state.copyWith(deliveryShopStatus: DeliveryShopStatus.loading));
    try {
      final page = refresh ? 1 : (state.orders.length ~/ 10) + 1;
      final result = await deliveryShopUseCase.getAllItemsByOrder(
          PaginationParams(page: page), basketId);
      result.fold(
        (failure) => emit(state.copyWith(
            deliveryShopStatus: DeliveryShopStatus.failure,
            errorMessage: failure.message)),
        (orders) => emit(state.copyWith(
          deliveryShopStatus: DeliveryShopStatus.success,
          selectedOrderItems: orders.items,
          successMessage: "تم جلب العناصر بنجاح.",
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          deliveryShopStatus: DeliveryShopStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> takeOrder({
    required int basketId,
  }) async {
    emit(state.copyWith(deliveryShopStatus: DeliveryShopStatus.loading));
    try {
      final result = await deliveryShopUseCase.takeOrder(
        basketId,
      );
      result.fold(
        (failure) => emit(state.copyWith(
            deliveryShopStatus: DeliveryShopStatus.failure,
            errorMessage: failure.message)),
        (response) => emit(state.copyWith(
          deliveryShopStatus: DeliveryShopStatus.success,
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          deliveryShopStatus: DeliveryShopStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> fetchCurrentOrder({
    bool refresh = false,
  }) async {
    emit(state.copyWith(deliveryShopStatus: DeliveryShopStatus.loading));
    try {
      final page = refresh ? 1 : (state.orders.length ~/ 10) + 1;
      final result = await deliveryShopUseCase
          .getAllTakeDelivery(PaginationParams(page: page));
      result.fold(
        (failure) => emit(state.copyWith(
            deliveryShopStatus: DeliveryShopStatus.failure,
            errorMessage: failure.message)),
        (orders) => emit(state.copyWith(
            deliveryShopStatus: DeliveryShopStatus.success,
            orders: orders.items)),
      );
    } catch (e) {
      emit(state.copyWith(
          deliveryShopStatus: DeliveryShopStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> fetchAllItemByOrderDetiles(
    int basketId, {
    bool refresh = false,
  }) async {
    emit(state.copyWith(deliveryShopStatus: DeliveryShopStatus.loading));
    try {
      final result =
          await deliveryShopUseCase.getAllItemByOrderDetiles(basketId);
      result.fold(
        (failure) => emit(state.copyWith(
            deliveryShopStatus: DeliveryShopStatus.failure,
            errorMessage: failure.message)),
        (selectedOrderDetilesCurrentItems) => emit(state.copyWith(
          deliveryShopStatus: DeliveryShopStatus.success,
          selectedOrderDetilesCurrentItems: [selectedOrderDetilesCurrentItems],
          successMessage: "تم جلب العناصر بنجاح.",
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          deliveryShopStatus: DeliveryShopStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> fetchPerviousOrder({
    bool refresh = false,
  }) async {
    emit(state.copyWith(deliveryShopStatus: DeliveryShopStatus.loading));
    try {
      final page = refresh ? 1 : (state.orders.length ~/ 10) + 1;
      final result = await deliveryShopUseCase
          .getAllTakePerviousOrder(PaginationParams(page: page));
      result.fold(
        (failure) => emit(state.copyWith(
            deliveryShopStatus: DeliveryShopStatus.failure,
            errorMessage: failure.message)),
        (orders) => emit(state.copyWith(
            deliveryShopStatus: DeliveryShopStatus.success,
            ordersOld: orders.items)),
      );
    } catch (e) {
      emit(state.copyWith(
          deliveryShopStatus: DeliveryShopStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> updateStatusForOrder({
    required int orderId,
    int? status,
  }) async {
    emit(state.copyWith(deliveryShopStatus: DeliveryShopStatus.loading));
    try {
      final result = await deliveryShopUseCase.updateStatusForOrder(
        orderId,
        status!,
      );
      result.fold(
        (failure) => emit(state.copyWith(
            deliveryShopStatus: DeliveryShopStatus.failure,
            errorMessage: failure.message)),
        (response) => emit(state.copyWith(
          deliveryShopStatus: DeliveryShopStatus.success,
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          deliveryShopStatus: DeliveryShopStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }
}
