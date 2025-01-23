// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/maintenance_parts/maintenance_parts_entitie.dart';

enum HandReceiptStatus { initial, loading, success, failure }

class HandReceiptState {
  final HandReceiptStatus handReceiptStatus;
  final List<HandReceiptEntity> receipts;
  final String errorMessage;
  final bool isUpdating;
  final String successMessage;
  final String malfunctionDescription;

  HandReceiptState({
    this.handReceiptStatus = HandReceiptStatus.initial,
    this.receipts = const <HandReceiptEntity>[],
    this.errorMessage = '',
    this.isUpdating = false,
    this.successMessage = '',
    this.malfunctionDescription = '',
  });

  factory HandReceiptState.initial() {
    return HandReceiptState(
      handReceiptStatus: HandReceiptStatus.initial,
      receipts: [],
      errorMessage: '',
      isUpdating: false,
      successMessage: '',
      malfunctionDescription: '',
    );
  }

  HandReceiptState copyWith({
    HandReceiptStatus? handReceiptStatus,
    List<HandReceiptEntity>? receipts,
    String? errorMessage,
    String? successMessage,
  }) {
    return HandReceiptState(
      handReceiptStatus: handReceiptStatus ?? this.handReceiptStatus,
      receipts: receipts ?? this.receipts,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  @override
  List<Object?> get props => [
        handReceiptStatus,
        receipts,
        errorMessage,
        successMessage,
      ];
}
