import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/usecases/fetch_delivery_maintenance.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/state/delivery_maintenance_state.dart';

class DeliveryMaintenanceCubit extends Cubit<DeliveryMaintenanceState> {
  final DeliveryMaintenanceUseCase deliveryMaintenanceUseCase;

  DeliveryMaintenanceCubit(this.deliveryMaintenanceUseCase)
      : super(const DeliveryMaintenanceState());

  Future<void> fetchReceiveMaintenanceOrder({
    bool refresh = false,
  }) async {
    emit(state.copyWith(
        deliveryMaintenanceStatus: DeliveryMaintenanceStatus.loading));
    try {
      final page = (state.orders.isEmpty || refresh) ? 1 : (state.page + 1);

      final result = await deliveryMaintenanceUseCase
          .getAllForAllDelivery(PaginationParams(
        page: page,
        perPage: 10,
      ));

      result.fold(
          (failure) => emit(state.copyWith(
              deliveryMaintenanceStatus: DeliveryMaintenanceStatus.failure,
              errorMessage: failure.message)), (orders) {
        final updatedList =
            refresh ? orders.items : [...state.orders, ...orders.items];
        {
          emit(state.copyWith(
            deliveryMaintenanceStatus: DeliveryMaintenanceStatus.success,
            orders: updatedList,
            page: page,
            hasReachedMax: orders.items.length < 10,
          ));
        }
      });
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
      final page = refresh ? 1 : (state.page + 1);

      final result = await deliveryMaintenanceUseCase.getAllTakeDelivery(
        PaginationParams(
          page: page,
          perPage: 10,
        ),
      );

      result.fold(
        (failure) => emit(state.copyWith(
          deliveryMaintenanceStatus: DeliveryMaintenanceStatus.failure,
          errorMessage: failure.message,
        )),
        (ordersResponse) {
          final updatedList = refresh
              ? ordersResponse.items
              : [...state.ordersCurrent, ...ordersResponse.items];

          emit(state.copyWith(
            deliveryMaintenanceStatus: DeliveryMaintenanceStatus.success,
            ordersCurrent: updatedList,
            page: page,
            hasReachedMax: ordersResponse.items.length < 10,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        deliveryMaintenanceStatus: DeliveryMaintenanceStatus.failure,
        errorMessage: 'Unexpected error occurred: $e',
      ));
    }
  }

  Future<void> fetchPerviousOrder({
    bool refresh = false,
  }) async {
    emit(state.copyWith(
        deliveryMaintenanceStatus: DeliveryMaintenanceStatus.loading));
    try {
      final page = refresh ? 1 : 1;
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

  Future<bool> payWithCard(int orderMaintenancId) async {
    emit(state.copyWith(
        deliveryMaintenanceStatus: DeliveryMaintenanceStatus.loading));
    final result =
        await deliveryMaintenanceUseCase.payWithCard(orderMaintenancId);
    return result.fold(
      (failure) {
        emit(state.copyWith(
            deliveryMaintenanceStatus: DeliveryMaintenanceStatus.failure,
            errorMessage: failure.message));
        return false;
      },
      (_) {
        fetchReceiveMaintenanceOrder();
        return true;
      },
    );
  }

  Future<bool> payWithCash(int orderMaintenancId) async {
    emit(state.copyWith(
        deliveryMaintenanceStatus: DeliveryMaintenanceStatus.loading));
    final result =
        await deliveryMaintenanceUseCase.payWithCash(orderMaintenancId);
    return result.fold(
      (failure) {
        emit(state.copyWith(
            deliveryMaintenanceStatus: DeliveryMaintenanceStatus.failure,
            errorMessage: failure.message));
        return false;
      },
      (_) {
        fetchReceiveMaintenanceOrder();
        return true;
      },
    );
  }

  Future<void> fetchAllForAllDeliveryConvert({
    bool refresh = false,
    String barcode = '',
  }) async {
    emit(state.copyWith(
        deliveryMaintenanceConvertStatus:
            DeliveryMaintenanceConvertStatus.loading));
    try {
      final page =
          (state.ordersConvert.isEmpty || refresh) ? 1 : (state.page + 1);

      final result =
          await deliveryMaintenanceUseCase.getAllForAllDeliveryConvert(
              PaginationParams(
                page: page,
                perPage: 10,
              ),
              barcode);

      result.fold(
          (failure) => emit(state.copyWith(
              deliveryMaintenanceConvertStatus:
                  DeliveryMaintenanceConvertStatus.failure,
              errorMessage: failure.message)), (ordersConvert) {
        final updatedList = refresh
            ? ordersConvert.items
            : [...state.ordersConvert, ...ordersConvert.items];
        {
          emit(state.copyWith(
            deliveryMaintenanceConvertStatus:
                DeliveryMaintenanceConvertStatus.success,
            ordersConvert: updatedList,
            page: page,
            hasReachedMax: ordersConvert.items.length < 10,
          ));
        }
      });
    } catch (e) {
      emit(state.copyWith(
          deliveryMaintenanceConvertStatus:
              DeliveryMaintenanceConvertStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> fetchAllTakeDeliveryConvert({
    bool refresh = false,
    String barcode = '',
  }) async {
    emit(state.copyWith(
        deliveryMaintenanceConvertCurrentStatus:
            DeliveryMaintenanceCurrentConvertStatus.loading));

    try {
      final page = refresh ? 1 : 1;

      final result = await deliveryMaintenanceUseCase.getAllTakeDeliveryConvert(
          PaginationParams(
            page: page,
            perPage: 10,
          ),
          barcode);

      result.fold(
        (failure) => emit(state.copyWith(
          deliveryMaintenanceConvertCurrentStatus:
              DeliveryMaintenanceCurrentConvertStatus.failure,
          errorMessage: failure.message,
        )),
        (ordersCurrentConvert) {
          emit(state.copyWith(
            deliveryMaintenanceConvertCurrentStatus:
                DeliveryMaintenanceCurrentConvertStatus.success,
            ordersCurrentConvert: ordersCurrentConvert.items,
            page: page,
            hasReachedMax: ordersCurrentConvert.items.length < 10,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        deliveryMaintenanceConvertCurrentStatus:
            DeliveryMaintenanceCurrentConvertStatus.failure,
        errorMessage: 'Unexpected error occurred: $e',
      ));
    }
  }

  Future<void> fetchAllForDeliveryConvert({
    bool refresh = false,
  }) async {
    emit(state.copyWith(
        deliveryMaintenanceConvertStatus:
            DeliveryMaintenanceConvertStatus.loading));
    try {
      final page = refresh ? 1 : 1;
      final result = await deliveryMaintenanceUseCase
          .getAllForDeliveryConvert(PaginationParams(page: page));
      result.fold(
        (failure) => emit(state.copyWith(
            deliveryMaintenanceConvertStatus:
                DeliveryMaintenanceConvertStatus.failure,
            errorMessage: failure.message)),
        (ordersConvert) => emit(state.copyWith(
            deliveryMaintenanceConvertStatus:
                DeliveryMaintenanceConvertStatus.success,
            ordersConvert: ordersConvert.items)),
      );
    } catch (e) {
      emit(state.copyWith(
          deliveryMaintenanceConvertStatus:
              DeliveryMaintenanceConvertStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> takeOrderMaintenanceConvert({
    required int orderMaintenancId,
  }) async {
    emit(state.copyWith(
        deliveryMaintenanceConvertStatus:
            DeliveryMaintenanceConvertStatus.loading));
    try {
      final result =
          await deliveryMaintenanceUseCase.takeOrderMaintenanceConvert(
        orderMaintenancId,
      );
      result.fold(
        (failure) => emit(state.copyWith(
            deliveryMaintenanceConvertStatus:
                DeliveryMaintenanceConvertStatus.failure,
            errorMessage: failure.message)),
        (response) => emit(state.copyWith(
          deliveryMaintenanceConvertStatus:
              DeliveryMaintenanceConvertStatus.success,
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          deliveryMaintenanceConvertStatus:
              DeliveryMaintenanceConvertStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> updateOrderMaintenanceConvert(
      {required int orderMaintenancId, required int status}) async {
    emit(state.copyWith(
        deliveryMaintenanceConvertStatus:
            DeliveryMaintenanceConvertStatus.loading));
    try {
      final result = await deliveryMaintenanceUseCase
          .updateOrderMaintenanceConvert(orderMaintenancId, status);
      result.fold(
        (failure) => emit(state.copyWith(
            deliveryMaintenanceConvertStatus:
                DeliveryMaintenanceConvertStatus.failure,
            errorMessage: failure.message)),
        (response) => emit(state.copyWith(
          deliveryMaintenanceConvertStatus:
              DeliveryMaintenanceConvertStatus.success,
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          deliveryMaintenanceConvertStatus:
              DeliveryMaintenanceConvertStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> fetchAllForAllDeliveryOutSide({
    bool refresh = false,
    String barcode = '',
  }) async {
    emit(state.copyWith(
        deliveryMaintenanceOutSideStatus:
            DeliveryMaintenanceOutSideStatus.loading));
    try {
      final page =
          (state.ordersOutSide.isEmpty || refresh) ? 1 : (state.page + 1);

      final result =
          await deliveryMaintenanceUseCase.getAllForAllDeliveryOutSide(
              PaginationParams(
                page: page,
                perPage: 10,
              ),
              barcode);

      result.fold(
          (failure) => emit(state.copyWith(
              deliveryMaintenanceOutSideStatus:
                  DeliveryMaintenanceOutSideStatus.failure,
              errorMessage: failure.message)), (ordersOutSide) {
        final updatedList = refresh
            ? ordersOutSide.items
            : [...state.ordersOutSide, ...ordersOutSide.items];
        {
          emit(state.copyWith(
            deliveryMaintenanceOutSideStatus:
                DeliveryMaintenanceOutSideStatus.success,
            ordersOutSide: updatedList,
            page: page,
            hasReachedMax: ordersOutSide.items.length < 10,
          ));
        }
      });
    } catch (e) {
      emit(state.copyWith(
          deliveryMaintenanceOutSideStatus:
              DeliveryMaintenanceOutSideStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> setMaintenancePrice(
      {required int convertHandReceiptItemId,
      required double maintenancePrice}) async {
    emit(state.copyWith(
        deliveryMaintenanceOutSideStatus:
            DeliveryMaintenanceOutSideStatus.loading));

    print(convertHandReceiptItemId);
    print(maintenancePrice);

    try {
      final result = await deliveryMaintenanceUseCase.setMaintenancePrice(
          convertHandReceiptItemId: convertHandReceiptItemId,
          maintenancePrice: maintenancePrice);
      result.fold(
        (failure) => emit(state.copyWith(
            deliveryMaintenanceOutSideStatus:
                DeliveryMaintenanceOutSideStatus.failure,
            errorMessage: failure.message)),
        (response) => emit(state.copyWith(
          deliveryMaintenanceOutSideStatus:
              DeliveryMaintenanceOutSideStatus.success,
          successMessage: 'Maintenance suspended successfully',
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          deliveryMaintenanceOutSideStatus:
              DeliveryMaintenanceOutSideStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> fetchAllTakeDeliveryOutSide({
    bool refresh = false,
    String barcode = '',
  }) async {
    emit(state.copyWith(
        deliveryMaintenanceCurrentOutSideStatus:
            DeliveryMaintenanceCurrentOutSideStatus.loading));

    try {
      final page = refresh ? 1 : 1;

      final result = await deliveryMaintenanceUseCase.getAllTakeDeliveryOutSide(
          PaginationParams(
            page: page,
            perPage: 10,
          ),
          barcode);

      result.fold(
        (failure) => emit(state.copyWith(
          deliveryMaintenanceCurrentOutSideStatus:
              DeliveryMaintenanceCurrentOutSideStatus.failure,
          errorMessage: failure.message,
        )),
        (ordersCurrentOutSide) {
          emit(state.copyWith(
            deliveryMaintenanceCurrentOutSideStatus:
                DeliveryMaintenanceCurrentOutSideStatus.success,
            ordersCurrentOutSide: ordersCurrentOutSide.items,
            page: page,
            hasReachedMax: ordersCurrentOutSide.items.length < 10,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        deliveryMaintenanceCurrentOutSideStatus:
            DeliveryMaintenanceCurrentOutSideStatus.failure,
        errorMessage: 'Unexpected error occurred: $e',
      ));
    }
  }

  Future<void> fetchAllForDeliveryOutSide({
    bool refresh = false,
  }) async {
    emit(state.copyWith(
        deliveryMaintenancePerviousOutSideStatus:
            DeliveryMaintenancePerviousOutSideStatus.loading));
    try {
      final page = refresh ? 1 : 1;
      final result = await deliveryMaintenanceUseCase
          .getAllForDeliveryOutSide(PaginationParams(page: page));
      result.fold(
        (failure) => emit(state.copyWith(
            deliveryMaintenancePerviousOutSideStatus:
                DeliveryMaintenancePerviousOutSideStatus.failure,
            errorMessage: failure.message)),
        (ordersPervious) => emit(state.copyWith(
            deliveryMaintenancePerviousOutSideStatus:
                DeliveryMaintenancePerviousOutSideStatus.success,
            ordersPerviousOutSide: ordersPervious.items)),
      );
    } catch (e) {
      emit(state.copyWith(
          deliveryMaintenancePerviousOutSideStatus:
              DeliveryMaintenancePerviousOutSideStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> takeOrderMaintenanceoOutSide({
    required int orderMaintenancId,
  }) async {
    emit(state.copyWith(
        deliveryMaintenanceOutSideStatus:
            DeliveryMaintenanceOutSideStatus.loading));
    try {
      final result =
          await deliveryMaintenanceUseCase.takeOrderMaintenanceoOutSide(
        orderMaintenancId,
      );
      result.fold(
        (failure) => emit(state.copyWith(
            deliveryMaintenanceOutSideStatus:
                DeliveryMaintenanceOutSideStatus.failure,
            errorMessage: failure.message)),
        (response) => emit(state.copyWith(
          deliveryMaintenanceOutSideStatus:
              DeliveryMaintenanceOutSideStatus.success,
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          deliveryMaintenanceOutSideStatus:
              DeliveryMaintenanceOutSideStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> updateOrderMaintenanceOutSide(
      {required int orderMaintenancId, required int status}) async {
    emit(state.copyWith(
        deliveryMaintenanceOutSideStatus:
            DeliveryMaintenanceOutSideStatus.loading));
    try {
      final result = await deliveryMaintenanceUseCase
          .updateOrderMaintenanceOutSide(orderMaintenancId, status);
      result.fold(
        (failure) => emit(state.copyWith(
            deliveryMaintenanceOutSideStatus:
                DeliveryMaintenanceOutSideStatus.failure,
            errorMessage: failure.message)),
        (response) => emit(state.copyWith(
          deliveryMaintenanceOutSideStatus:
              DeliveryMaintenanceOutSideStatus.success,
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          deliveryMaintenanceOutSideStatus:
              DeliveryMaintenanceOutSideStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }
}
