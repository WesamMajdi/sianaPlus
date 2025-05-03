import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/usecases/recovered_maintenance_parts/fetch_recovered_maintenance_parts.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/controller/state/returnHandReceipt_state.dart';

class ReturnHandReceiptCubit extends Cubit<ReturnHandReceiptState> {
  final ReturnHandReceiptUseCases returnHandReceiptUseCase;

  ReturnHandReceiptCubit(this.returnHandReceiptUseCase)
      : super(ReturnHandReceiptState());
  Future<void> getAllReturnHandReceiptItems({
    bool refresh = false,
    String searchQuery = '',
    String barcode = '',
  }) async {
    try {
      final page = refresh ? 1 : state.currentPage;
      if (refresh ||
          state.returnHandReceiptStatus != ReturnHandReceiptStatus.success) {
        emit(state.copyWith(
            returnHandReceiptStatus: ReturnHandReceiptStatus.loading));
      }

      final result =
          await returnHandReceiptUseCase.getAllReturnHandReceiptItems(
        PaginationParams(page: page, perPage: 10),
        barcode,
        searchQuery,
      );

      result.fold(
        (failure) => emit(state.copyWith(
          returnHandReceiptStatus: ReturnHandReceiptStatus.failure,
          errorMessage: failure.message,
        )),
        (returnHandReceipts) {
          final updatedList = refresh
              ? returnHandReceipts.items
              : [...state.returnHandReceipts, ...returnHandReceipts.items];

          emit(state.copyWith(
            returnHandReceiptStatus: ReturnHandReceiptStatus.success,
            returnHandReceipts: updatedList,
            hasReachedEnd: returnHandReceipts.items.length < 10,
            currentPage: page + 1,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        returnHandReceiptStatus: ReturnHandReceiptStatus.failure,
        errorMessage: 'Unexpected error occurred: $e',
      ));
    }
  }

  Future<void> getReturnHandReceiptItem(int id) async {
    emit(state.copyWith(
        returnHandReceiptStatus: ReturnHandReceiptStatus.loading));

    try {
      final result =
          await returnHandReceiptUseCase.getReturnHandReceiptItem(id);

      result.fold(
        (failure) {
          print("Failure: ${failure.message}");
          emit(state.copyWith(
            returnHandReceiptStatus: ReturnHandReceiptStatus.failure,
            errorMessage: failure.message,
          ));
        },
        (returnHandReceipt) {
          print("Success: $returnHandReceipt");
          emit(state.copyWith(
            returnHandReceiptStatus: ReturnHandReceiptStatus.success,
            returnHandReceiptItem: returnHandReceipt,
          ));
        },
      );
    } catch (e) {
      print("Error: $e");
      emit(state.copyWith(
        returnHandReceiptStatus: ReturnHandReceiptStatus.failure,
        errorMessage: 'Unexpected error occurred: $e',
      ));
    }
  }

  Future<void> updateReturnStatusForReceiptItem({
    required int receiptItemId,
    int? status,
  }) async {
    emit(state.copyWith(
        returnHandReceiptStatus: ReturnHandReceiptStatus.loading));
    try {
      final result =
          await returnHandReceiptUseCase.updateStatusForReturnHandReceiptItem(
        receiptItemId: receiptItemId,
        status: status,
      );
      result.fold(
        (failure) => emit(state.copyWith(
            returnHandReceiptStatus: ReturnHandReceiptStatus.failure,
            errorMessage: failure.message)),
        (response) => emit(state.copyWith(
          returnHandReceiptStatus: ReturnHandReceiptStatus.success,
          successMessage: 'Return status updated successfully',
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          returnHandReceiptStatus: ReturnHandReceiptStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> defineReturnMalfunctionForReceiptItem({
    required int receiptItemId,
    String? description,
  }) async {
    emit(state.copyWith(
        returnHandReceiptStatus: ReturnHandReceiptStatus.loading));
    try {
      final result = await returnHandReceiptUseCase
          .defineMalfunctionForReturnHandReceiptItem(
        description: description,
        receiptItemId: receiptItemId,
      );
      result.fold(
        (failure) => emit(state.copyWith(
            returnHandReceiptStatus: ReturnHandReceiptStatus.failure,
            errorMessage: failure.message)),
        (response) => emit(state.copyWith(
          returnHandReceiptStatus: ReturnHandReceiptStatus.success,
          successMessage: 'Malfunction defined successfully',
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          returnHandReceiptStatus: ReturnHandReceiptStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> enterReturnMaintenanceCostForItem(
      {required int receiptItemId,
      required double costNotifiedToTheCustomer,
      required int warrantyDaysNumber}) async {
    emit(state.copyWith(
        returnHandReceiptStatus: ReturnHandReceiptStatus.loading));
    try {
      final result = await returnHandReceiptUseCase
          .enterMaintenanceCostForReturnHandReceiptItem(
        receiptItemId: receiptItemId,
        costNotifiedToTheCustomer: costNotifiedToTheCustomer,
        warrantyDaysNumber: warrantyDaysNumber,
      );
      result.fold(
        (failure) => emit(state.copyWith(
            returnHandReceiptStatus: ReturnHandReceiptStatus.failure,
            errorMessage: failure.message)),
        (response) => emit(state.copyWith(
          returnHandReceiptStatus: ReturnHandReceiptStatus.success,
          successMessage: 'Maintenance cost entered successfully',
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          returnHandReceiptStatus: ReturnHandReceiptStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> suspendReturnMaintenanceForReceiptItem({
    required int receiptItemId,
    String? suspensionReason,
  }) async {
    emit(state.copyWith(
        returnHandReceiptStatus: ReturnHandReceiptStatus.loading));
    try {
      final result = await returnHandReceiptUseCase
          .suspendMaintenanceForReturnHandReceiptItem(
        receiptItemId,
        suspensionReason,
      );
      result.fold(
        (failure) => emit(state.copyWith(
            returnHandReceiptStatus: ReturnHandReceiptStatus.failure,
            errorMessage: failure.message)),
        (response) => emit(state.copyWith(
          returnHandReceiptStatus: ReturnHandReceiptStatus.success,
          successMessage: 'Maintenance suspended successfully',
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          returnHandReceiptStatus: ReturnHandReceiptStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }

  Future<void> reopenMaintenanceForReturnHandReceiptItem({
    required int receiptItemId,
  }) async {
    emit(state.copyWith(
        returnHandReceiptStatus: ReturnHandReceiptStatus.loading));
    try {
      final result = await returnHandReceiptUseCase
          .reOpenMaintenanceForReturnHandReceiptItem(
        receiptItemId,
      );
      result.fold(
        (failure) => emit(state.copyWith(
            returnHandReceiptStatus: ReturnHandReceiptStatus.failure,
            errorMessage: failure.message)),
        (response) => emit(state.copyWith(
          returnHandReceiptStatus: ReturnHandReceiptStatus.success,
          successMessage: 'Maintenance suspended successfully',
        )),
      );
    } catch (e) {
      emit(state.copyWith(
          returnHandReceiptStatus: ReturnHandReceiptStatus.failure,
          errorMessage: 'Unexpected error occurred: $e'));
    }
  }
}
