// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/recovered_maintenance_parts/recovered_maintenance_parts_entity.dart';

enum ReturnHandReceiptStatus { initial, loading, success, failure }

class ReturnHandReceiptState extends Equatable {
  final ReturnHandReceiptStatus returnHandReceiptStatus;
  final List<ReturnHandReceiptEntity> returnHandReceipts;
  final String errorMessage;
  final bool isUpdating;
  final String successMessage;
  final String malfunctionDescription;
  final double? maintenanceCost;
  final ReturnHandReceiptEntity? returnHandReceiptItem;

  ReturnHandReceiptState({
    this.returnHandReceiptStatus = ReturnHandReceiptStatus.initial,
    this.returnHandReceipts = const <ReturnHandReceiptEntity>[],
    this.errorMessage = '',
    this.isUpdating = false,
    this.successMessage = '',
    this.malfunctionDescription = '',
    this.maintenanceCost,
    this.returnHandReceiptItem,
  });

  factory ReturnHandReceiptState.initial() {
    return ReturnHandReceiptState(
      returnHandReceiptStatus: ReturnHandReceiptStatus.initial,
      returnHandReceipts: [],
      errorMessage: '',
      isUpdating: false,
      successMessage: '',
      malfunctionDescription: '',
      maintenanceCost: null,
      returnHandReceiptItem: null,
    );
  }

  ReturnHandReceiptState copyWith({
    ReturnHandReceiptStatus? returnHandReceiptStatus,
    List<ReturnHandReceiptEntity>? returnHandReceipts,
    String? errorMessage,
    bool? isUpdating,
    String? successMessage,
    String? malfunctionDescription,
    double? maintenanceCost,
    ReturnHandReceiptEntity? returnHandReceiptItem,
  }) {
    return ReturnHandReceiptState(
      returnHandReceiptStatus:
          returnHandReceiptStatus ?? this.returnHandReceiptStatus,
      returnHandReceipts: returnHandReceipts ?? this.returnHandReceipts,
      errorMessage: errorMessage ?? this.errorMessage,
      isUpdating: isUpdating ?? this.isUpdating,
      successMessage: successMessage ?? this.successMessage,
      malfunctionDescription:
          malfunctionDescription ?? this.malfunctionDescription,
      maintenanceCost: maintenanceCost ?? this.maintenanceCost,
      returnHandReceiptItem:
          returnHandReceiptItem ?? this.returnHandReceiptItem,
    );
  }

  @override
  List<Object?> get props => [
        returnHandReceiptStatus,
        returnHandReceipts,
        errorMessage,
        isUpdating,
        successMessage,
        malfunctionDescription,
        maintenanceCost,
        returnHandReceiptItem,
      ];
}
