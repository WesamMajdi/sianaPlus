import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/usecases/online_maintenance_parts/fetch_online_maintenance_parts.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/controller/state/handReceipt_state.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/controller/state/online_state.dart';

class OnlineCubit extends Cubit<OnlineState> {
  final OnlineUseCase onlineUseCase;

  OnlineCubit(this.onlineUseCase) : super(OnlineState());
  Future<void> fetchOnline({
    bool refresh = false,
    String searchQuery = '',
    String barcode = '',
  }) async {
    emit(state.copyWith(onlineStatus: OnlineStatus.loading));
    try {
      final page = refresh ? 1 : (state.currentPage + 1);

      final result = await onlineUseCase.getAllOnlineItem(
        PaginationParams(
          page: page,
          perPage: 10,
        ),
        searchQuery,
        barcode,
      );

      result.fold(
        (failure) => emit(state.copyWith(
          onlineStatus: OnlineStatus.failure,
          errorMessage: failure.message,
        )),
        (onlineReceipts) {
          final updatedList = refresh
              ? onlineReceipts.items
              : [...state.receiptsOnline, ...onlineReceipts.items];

          emit(state.copyWith(
            onlineStatus: OnlineStatus.success,
            receiptsOnline: updatedList,
            hasReachedEnd: onlineReceipts.items.length < 10,
            currentPage: page,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        onlineStatus: OnlineStatus.failure,
        errorMessage: 'Unexpected error occurred: $e',
      ));
    }
  }

  Future<void> updateStatusForOnlineItem({
    required int receiptItemId,
    int? status,
  }) async {
    emit(state.copyWith(onlineStatus: OnlineStatus.loading));
    try {
      final result = await onlineUseCase.updateStatusForOnlineItem(
        receiptItemId,
        status!,
      );
      result.fold(
        (failure) => emit(state.copyWith(
            onlineStatus: OnlineStatus.failure, errorMessage: failure.message)),
        (response) => emit(state.copyWith(
          onlineStatus: OnlineStatus.success,
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          onlineStatus: OnlineStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> defineMalfunctionForOnlineItem({
    required int receiptItemId,
    String? description,
  }) async {
    emit(state.copyWith(onlineStatus: OnlineStatus.loading));
    try {
      final result = await onlineUseCase.defineMalfunctionForOnlineItem(
        receiptItemId,
        description!,
      );
      result.fold(
        (failure) => emit(state.copyWith(
            onlineStatus: OnlineStatus.failure, errorMessage: failure.message)),
        (response) => emit(state.copyWith(
          onlineStatus: OnlineStatus.success,
          successMessage: 'Malfunction defined successfully',
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          onlineStatus: OnlineStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> enterMaintenanceCostForOnlinetItem({
    required int receiptItemId,
    required String costNotifiedToTheCustomer,
    int warrantyDaysNumber = 0,
  }) async {
    emit(state.copyWith(onlineStatus: OnlineStatus.loading));
    try {
      final result = await onlineUseCase.enterMaintenanceCostForOnlineItem(
        receiptItemId: receiptItemId,
        costNotifiedToTheCustomer: costNotifiedToTheCustomer,
        warrantyDaysNumber: warrantyDaysNumber,
      );
      result.fold(
        (failure) => emit(state.copyWith(
            onlineStatus: OnlineStatus.failure, errorMessage: failure.message)),
        (response) => emit(state.copyWith(
          onlineStatus: OnlineStatus.success,
          successMessage: 'Maintenance cost entered successfully',
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          onlineStatus: OnlineStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> getOnlineItem(int id) async {
    emit(state.copyWith(onlineStatus: OnlineStatus.loading));
    try {
      final result = await onlineUseCase.getOnlineItem(id);
      result.fold(
        (failure) => emit(state.copyWith(
            onlineStatus: OnlineStatus.failure, errorMessage: failure.message)),
        (online) => emit(state.copyWith(
          onlineStatus: OnlineStatus.success,
          onlineItem: online,
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          onlineStatus: OnlineStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> suspendMaintenanceForOnlineItem({
    required int receiptItemId,
    String? maintenanceSuspensionReason,
  }) async {
    emit(state.copyWith(onlineStatus: OnlineStatus.loading));
    try {
      final result = await onlineUseCase.suspendMaintenanceForOnlineItem(
        receiptItemId,
        maintenanceSuspensionReason,
      );
      result.fold(
        (failure) => emit(state.copyWith(
            onlineStatus: OnlineStatus.failure, errorMessage: failure.message)),
        (response) => emit(state.copyWith(
          onlineStatus: OnlineStatus.success,
          successMessage: 'Maintenance suspended successfully',
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          onlineStatus: OnlineStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> reopenMaintenanceOnlineItem({
    required int receiptItemId,
  }) async {
    emit(state.copyWith(onlineStatus: OnlineStatus.loading));
    try {
      final result = await onlineUseCase.reopenMaintenanceOnlineItem(
        receiptItemId,
      );
      result.fold(
        (failure) => emit(state.copyWith(
            onlineStatus: OnlineStatus.failure, errorMessage: failure.message)),
        (response) => emit(state.copyWith(
          onlineStatus: OnlineStatus.success,
          successMessage: 'Maintenance suspended successfully',
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          onlineStatus: OnlineStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }
}
