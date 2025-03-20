import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/usecases/fetch_delivery_maintenance.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/state/delivery_maintenance_state.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/controller/state/deliveryShop_state.dart';

class DeliveryMaintenanceCubit extends Cubit<DeliveryMaintenanceState> {
  final DeliveryMaintenanceUseCase deliveryMaintenanceUseCase;

  DeliveryMaintenanceCubit(this.deliveryMaintenanceUseCase)
      : super(DeliveryMaintenanceState());

  Future<void> fetchReceiveMaintenanceOrder({
    bool refresh = false,
  }) async {
    emit(state.copyWith(
        deliveryMaintenanceStatus: DeliveryMaintenanceStatus.loading));
    try {
      final page = refresh ? 1 : (state.orders.length ~/ 10) + 1;
      final result = await deliveryMaintenanceUseCase
          .getAllForAllDelivery(PaginationParams(page: page));
      result.fold(
        (failure) => emit(state.copyWith(
            deliveryMaintenanceStatus: DeliveryMaintenanceStatus.failure,
            errorMessage: failure.message)),
        (orders) => emit(state.copyWith(
            deliveryMaintenanceStatus: DeliveryMaintenanceStatus.success,
            orders: orders.items)),
      );
    } catch (e) {
      emit(state.copyWith(
          deliveryMaintenanceStatus: DeliveryMaintenanceStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> fetchAllTakeDelivery({
    bool refresh = false,
  }) async {
    emit(state.copyWith(
        deliveryMaintenanceStatus: DeliveryMaintenanceStatus.loading));
    try {
      final page = refresh ? 1 : (state.ordersCurrent.length ~/ 10) + 1;
      final result = await deliveryMaintenanceUseCase
          .getAllTakeDelivery(PaginationParams(page: page));
      result.fold(
        (failure) => emit(state.copyWith(
            deliveryMaintenanceStatus: DeliveryMaintenanceStatus.failure,
            errorMessage: failure.message)),
        (ordersCurrent) => emit(state.copyWith(
            deliveryMaintenanceStatus: DeliveryMaintenanceStatus.success,
            ordersCurrent: ordersCurrent.items)),
      );
    } catch (e) {
      emit(state.copyWith(
          deliveryMaintenanceStatus: DeliveryMaintenanceStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> fetchPerviousOrder({
    bool refresh = false,
  }) async {
    emit(state.copyWith(
        deliveryMaintenanceStatus: DeliveryMaintenanceStatus.loading));
    try {
      final page = refresh ? 1 : (state.orders.length ~/ 10) + 1;
      final result = await deliveryMaintenanceUseCase
          .getAllTakePerviousOrder(PaginationParams(page: page));
      result.fold(
        (failure) => emit(state.copyWith(
            deliveryMaintenanceStatus: DeliveryMaintenanceStatus.failure,
            errorMessage: failure.message)),
        (orders) => emit(state.copyWith(
            deliveryMaintenanceStatus: DeliveryMaintenanceStatus.success,
            ordersOld: orders.items)),
      );
    } catch (e) {
      emit(state.copyWith(
          deliveryMaintenanceStatus: DeliveryMaintenanceStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> takeOrder({
    required int orderMaintenancId,
  }) async {
    emit(state.copyWith(
        deliveryMaintenanceStatus: DeliveryMaintenanceStatus.loading));
    try {
      final result = await deliveryMaintenanceUseCase.takeOrderMaintenance(
        orderMaintenancId,
      );
      result.fold(
        (failure) => emit(state.copyWith(
            deliveryMaintenanceStatus: DeliveryMaintenanceStatus.failure,
            errorMessage: failure.message)),
        (response) => emit(state.copyWith(
          deliveryMaintenanceStatus: DeliveryMaintenanceStatus.success,
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          deliveryMaintenanceStatus: DeliveryMaintenanceStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> updateOrderMaintenance(
      {required int orderMaintenancId, required int status}) async {
    emit(state.copyWith(
        deliveryMaintenanceStatus: DeliveryMaintenanceStatus.loading));
    try {
      final result = await deliveryMaintenanceUseCase.updateOrderMaintenance(
          orderMaintenancId, status);
      result.fold(
        (failure) => emit(state.copyWith(
            deliveryMaintenanceStatus: DeliveryMaintenanceStatus.failure,
            errorMessage: failure.message)),
        (response) => emit(state.copyWith(
          deliveryMaintenanceStatus: DeliveryMaintenanceStatus.success,
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          deliveryMaintenanceStatus: DeliveryMaintenanceStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> fetchAllItemByOrderDetiles(
    int handReceiptId,
    int orderMaintenancId, {
    bool refresh = false,
  }) async {
    emit(state.copyWith(
        deliveryMaintenanceStatus: DeliveryMaintenanceStatus.loading));
    try {
      final result = await deliveryMaintenanceUseCase.getAllItemByOrderDetiles(
          handReceiptId, orderMaintenancId);
      result.fold(
        (failure) => emit(state.copyWith(
            deliveryMaintenanceStatus: DeliveryMaintenanceStatus.failure,
            errorMessage: failure.message)),
        (selectedOrderDetilesItems) => emit(state.copyWith(
          deliveryMaintenanceStatus: DeliveryMaintenanceStatus.success,
          selectedOrderDetilesItems: [selectedOrderDetilesItems],
          successMessage: "تم جلب العناصر بنجاح.",
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          deliveryMaintenanceStatus: DeliveryMaintenanceStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> fetchBranch() async {
    emit(state.copyWith(
        deliveryMaintenanceStatus: DeliveryMaintenanceStatus.loading));
    try {
      final result = await deliveryMaintenanceUseCase.getBranches();
      result.fold(
        (failure) => emit(state.copyWith(
            deliveryMaintenanceStatus: DeliveryMaintenanceStatus.failure,
            errorMessage: failure.message)),
        (branch) => emit(state.copyWith(
          deliveryMaintenanceStatus: DeliveryMaintenanceStatus.success,
          branch: branch,
          successMessage: "تم جلب العناصر بنجاح.",
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          deliveryMaintenanceStatus: DeliveryMaintenanceStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> selectBranch(
      {required int orderMaintenancId, required int branchId}) async {
    emit(state.copyWith(
        deliveryMaintenanceStatus: DeliveryMaintenanceStatus.loading));
    try {
      final result = await deliveryMaintenanceUseCase.selectBranch(
          orderMaintenancId, branchId);
      result.fold(
        (failure) => emit(state.copyWith(
            deliveryMaintenanceStatus: DeliveryMaintenanceStatus.failure,
            errorMessage: failure.message)),
        (response) => emit(state.copyWith(
          deliveryMaintenanceStatus: DeliveryMaintenanceStatus.success,
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          deliveryMaintenanceStatus: DeliveryMaintenanceStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  // Future<void> getAllForAllDeliveryTransfer({
  //   bool refresh = false,
  // }) async {
  //   emit(state.copyWith(
  //       deliveryMaintenanceStatus: DeliveryMaintenanceStatus.loading));
  //   try {
  //     final page = refresh ? 1 : (state.orders.length ~/ 10) + 1;
  //     final result = await deliveryMaintenanceUseCase
  //         .getAllForAllDeliveryTransfer(PaginationParams(page: page));
  //     result.fold(
  //       (failure) => emit(state.copyWith(
  //           deliveryMaintenanceStatus: DeliveryMaintenanceStatus.failure,
  //           errorMessage: failure.message)),
  //       (transfer) => emit(state.copyWith(
  //           deliveryMaintenanceStatus: DeliveryMaintenanceStatus.success,
  //           transfer: transfer.items)),
  //     );
  //   } catch (e) {
  //     emit(state.copyWith(
  //         deliveryMaintenanceStatus: DeliveryMaintenanceStatus.failure,
  //         errorMessage: 'Unexpected error occurred: $e'));
  //   }
  // }
}
