import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/usecases/maintenance_parts/fetch_maintenance_parts.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/state/handReceipt_state.dart';

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
      final result = await handReceiptUseCase.getHandHandReceiptItem(
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
}
