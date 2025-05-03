// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/hand_receipt_maintenance_parts/hand_receipt_maintenance_parts_entitie.dart';

enum HandReceiptStatus { initial, loading, success, failure }

class HandReceiptState extends Equatable {
  final HandReceiptStatus handReceiptStatus;
  final List<HandReceiptEntity> receipts;
  final String errorMessage;
  final bool isUpdating;
  final int page;
  final bool hasReachedMax;
  final String successMessage;
  final String malfunctionDescription;
  final double? maintenanceCost;
  final HandReceiptEntity? handReceiptItem;

  HandReceiptState(
      {this.handReceiptStatus = HandReceiptStatus.initial,
      this.receipts = const <HandReceiptEntity>[],
      this.errorMessage = '',
      this.isUpdating = false,
      this.successMessage = '',
      this.malfunctionDescription = '',
      this.maintenanceCost,
      this.handReceiptItem,
      this.page = 1,
      this.hasReachedMax = false});

  factory HandReceiptState.initial() {
    return HandReceiptState(
        handReceiptStatus: HandReceiptStatus.initial,
        receipts: [],
        errorMessage: '',
        isUpdating: false,
        successMessage: '',
        malfunctionDescription: '',
        maintenanceCost: null,
        handReceiptItem: null,
        page: 1,
        hasReachedMax: false);
  }

  HandReceiptState copyWith({
    HandReceiptStatus? handReceiptStatus,
    List<HandReceiptEntity>? receipts,
    String? errorMessage,
    bool? isUpdating,
    String? successMessage,
    String? malfunctionDescription,
    double? maintenanceCost,
    HandReceiptEntity? handReceiptItem,
    int? page,
    bool? hasReachedMax,
  }) {
    return HandReceiptState(
      handReceiptStatus: handReceiptStatus ?? this.handReceiptStatus,
      receipts: receipts ?? this.receipts,
      errorMessage: errorMessage ?? this.errorMessage,
      isUpdating: isUpdating ?? this.isUpdating,
      successMessage: successMessage ?? this.successMessage,
      malfunctionDescription:
          malfunctionDescription ?? this.malfunctionDescription,
      maintenanceCost: maintenanceCost ?? this.maintenanceCost,
      handReceiptItem: handReceiptItem ?? this.handReceiptItem,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
        handReceiptStatus,
        receipts,
        errorMessage,
        isUpdating,
        successMessage,
        malfunctionDescription,
        maintenanceCost,
        handReceiptItem,
        page,
        hasReachedMax
      ];
}
