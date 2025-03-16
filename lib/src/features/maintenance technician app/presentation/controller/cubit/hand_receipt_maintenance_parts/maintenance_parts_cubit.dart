import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/usecases/hand_receipt_maintenance_parts/fetch_maintenance_parts.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/controller/state/handReceipt_state.dart';

class HandReceiptCubit extends Cubit<HandReceiptState> {
  final HandReceiptUseCase handReceiptUseCase;

  HandReceiptCubit(this.handReceiptUseCase) : super(HandReceiptState());

  Future<void> fetchHandReceipts({
    bool refresh = false,
    String searchQuery = '',
    String barcode = '',
  }) async {
    emit(state.copyWith(handReceiptStatus: HandReceiptStatus.loading));
    try {
      final page = refresh ? 1 : (state.receipts.length ~/ 10) + 1;
      final result = await handReceiptUseCase.getAllHandHandReceiptItem(
        PaginationParams(page: page),
        searchQuery,
        barcode,
      );
      result.fold(
        (failure) => emit(state.copyWith(
            handReceiptStatus: HandReceiptStatus.failure,
            errorMessage: failure.message)),
        (handReceipts) => emit(state.copyWith(
            handReceiptStatus: HandReceiptStatus.success,
            receipts: handReceipts.items)),
      );
    } catch (e) {
      emit(state.copyWith(
          handReceiptStatus: HandReceiptStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> updateStatusForHandReceiptItem({
    required int receiptItemId,
    int? status,
  }) async {
    emit(state.copyWith(handReceiptStatus: HandReceiptStatus.loading));
    try {
      final result = await handReceiptUseCase.updateStatusForHandReceiptItem(
        receiptItemId,
        status!,
      );
      result.fold(
        (failure) => emit(state.copyWith(
            handReceiptStatus: HandReceiptStatus.failure,
            errorMessage: failure.message)),
        (response) => emit(state.copyWith(
          handReceiptStatus: HandReceiptStatus.success,
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          handReceiptStatus: HandReceiptStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> defineMalfunctionForHandReceiptItem({
    required int receiptItemId,
    String? description,
  }) async {
    emit(state.copyWith(handReceiptStatus: HandReceiptStatus.loading));
    try {
      final result =
          await handReceiptUseCase.defineMalfunctionForHandReceiptItem(
        receiptItemId,
        description!,
      );
      result.fold(
        (failure) => emit(state.copyWith(
            handReceiptStatus: HandReceiptStatus.failure,
            errorMessage: failure.message)),
        (response) => emit(state.copyWith(
          handReceiptStatus: HandReceiptStatus.success,
          successMessage: 'Malfunction defined successfully',
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          handReceiptStatus: HandReceiptStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> enterMaintenanceCostForHandReceiptItem({
    required int receiptItemId,
    required double costNotifiedToTheCustomer,
    int warrantyDaysNumber = 0,
  }) async {
    emit(state.copyWith(handReceiptStatus: HandReceiptStatus.loading));
    try {
      final result =
          await handReceiptUseCase.enterMaintenanceCostForHandReceiptItem(
        receiptItemId: receiptItemId,
        costNotifiedToTheCustomer: costNotifiedToTheCustomer,
        warrantyDaysNumber: warrantyDaysNumber,
      );
      result.fold(
        (failure) => emit(state.copyWith(
            handReceiptStatus: HandReceiptStatus.failure,
            errorMessage: failure.message)),
        (response) => emit(state.copyWith(
          handReceiptStatus: HandReceiptStatus.success,
          successMessage: 'Maintenance cost entered successfully',
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          handReceiptStatus: HandReceiptStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> getHandReceiptItem(int id) async {
    emit(state.copyWith(handReceiptStatus: HandReceiptStatus.loading));
    try {
      final result = await handReceiptUseCase.getHandReceiptItem(id);
      result.fold(
        (failure) => emit(state.copyWith(
            handReceiptStatus: HandReceiptStatus.failure,
            errorMessage: failure.message)),
        (handReceipt) => emit(state.copyWith(
          handReceiptStatus: HandReceiptStatus.success,
          handReceiptItem: handReceipt,
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          handReceiptStatus: HandReceiptStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> suspendMaintenanceForHandReceiptItem({
    required int receiptItemId,
    String? maintenanceSuspensionReason,
  }) async {
    emit(state.copyWith(handReceiptStatus: HandReceiptStatus.loading));
    try {
      final result =
          await handReceiptUseCase.suspendMaintenanceForHandReceiptItem(
        receiptItemId,
        maintenanceSuspensionReason,
      );
      result.fold(
        (failure) => emit(state.copyWith(
            handReceiptStatus: HandReceiptStatus.failure,
            errorMessage: failure.message)),
        (response) => emit(state.copyWith(
          handReceiptStatus: HandReceiptStatus.success,
          successMessage: 'Maintenance suspended successfully',
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          handReceiptStatus: HandReceiptStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> reopenMaintenanceHandReceiptItem({
    required int receiptItemId,
  }) async {
    emit(state.copyWith(handReceiptStatus: HandReceiptStatus.loading));
    try {
      final result = await handReceiptUseCase.reopenMaintenanceHandReceiptItem(
        receiptItemId,
      );
      result.fold(
        (failure) => emit(state.copyWith(
            handReceiptStatus: HandReceiptStatus.failure,
            errorMessage: failure.message)),
        (response) => emit(state.copyWith(
          handReceiptStatus: HandReceiptStatus.success,
          successMessage: 'Maintenance suspended successfully',
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          handReceiptStatus: HandReceiptStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }
}
