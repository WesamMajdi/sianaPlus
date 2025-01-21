// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/model/maintenance_parts/maintenance_parts_model.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/maintenance_parts/maintenance_parts_entitie.dart';

enum HandReceiptStatus { initial, loading, success, failure }

class HandReceiptState {
  final HandReceiptStatus handReceiptStatus;
  final List<HandReceiptEntity> receipts;
  final String errorMessage;

  HandReceiptState({
    this.handReceiptStatus = HandReceiptStatus.initial,
    this.receipts = const <HandReceiptEntity>[],
    this.errorMessage = '',
  });

  factory HandReceiptState.initial() {
    return HandReceiptState(
      handReceiptStatus: HandReceiptStatus.initial,
      receipts: [],
      errorMessage: '',
    );
  }
  HandReceiptState copyWith({
    HandReceiptStatus? handReceiptStatus,
    List<HandReceiptEntity>? receipts,
    String? errorMessage,
  }) {
    return HandReceiptState(
      handReceiptStatus: handReceiptStatus ?? this.handReceiptStatus,
      receipts: receipts ?? this.receipts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  // ignore: override_on_non_overriding_member
  List<Object?> get props => [
        handReceiptStatus,
        receipts,
        errorMessage,
      ];
}
