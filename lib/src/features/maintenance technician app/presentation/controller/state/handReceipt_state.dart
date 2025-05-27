// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/hand_receipt_maintenance_parts/hand_receipt_maintenance_parts_entitie.dart';

enum HandReceiptStatus { initial, loading, success, failure }

enum ConvertFromBranchStatus { initial, loading, success, failure }

class HandReceiptState extends Equatable {
  final HandReceiptStatus handReceiptStatus;
  final ConvertFromBranchStatus convertFromBranchStatus;
  final List<HandReceiptEntity> receipts;
  final List<HandReceiptEntity> listconvertFromBranch;
  final String errorMessage;
  final bool isUpdating;
  final int page;
  final int pageTransferre;
  final bool hasReachedMax;
  final bool hasReachedMaxTransferre;
  final String successMessage;
  final String malfunctionDescription;
  final double? maintenanceCost;
  final HandReceiptEntity? handReceiptItem;

  HandReceiptState(
      {this.handReceiptStatus = HandReceiptStatus.initial,
      this.convertFromBranchStatus = ConvertFromBranchStatus.initial,
      this.receipts = const <HandReceiptEntity>[],
      this.listconvertFromBranch = const <HandReceiptEntity>[],
      this.errorMessage = '',
      this.isUpdating = false,
      this.successMessage = '',
      this.malfunctionDescription = '',
      this.maintenanceCost,
      this.handReceiptItem,
      this.page = 1,
      this.pageTransferre = 1,
      this.hasReachedMax = false,
      this.hasReachedMaxTransferre = false});

  factory HandReceiptState.initial() {
    return HandReceiptState(
        handReceiptStatus: HandReceiptStatus.initial,
        convertFromBranchStatus: ConvertFromBranchStatus.initial,
        receipts: [],
        listconvertFromBranch: [],
        errorMessage: '',
        isUpdating: false,
        successMessage: '',
        malfunctionDescription: '',
        maintenanceCost: null,
        handReceiptItem: null,
        page: 1,
        pageTransferre: 1,
        hasReachedMax: false,
        hasReachedMaxTransferre: false);
  }

  HandReceiptState copyWith({
    HandReceiptStatus? handReceiptStatus,
    List<HandReceiptEntity>? receipts,
    ConvertFromBranchStatus? convertFromBranchStatus,
    List<HandReceiptEntity>? listconvertFromBranch,
    String? errorMessage,
    bool? isUpdating,
    String? successMessage,
    String? malfunctionDescription,
    double? maintenanceCost,
    HandReceiptEntity? handReceiptItem,
    int? page,
    int? pageTransferre,
    bool? hasReachedMax,
    bool? hasReachedMaxTransferre,
  }) {
    return HandReceiptState(
        handReceiptStatus: handReceiptStatus ?? this.handReceiptStatus,
        convertFromBranchStatus:
            convertFromBranchStatus ?? this.convertFromBranchStatus,
        listconvertFromBranch:
            listconvertFromBranch ?? this.listconvertFromBranch,
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
        hasReachedMaxTransferre:
            hasReachedMaxTransferre ?? this.hasReachedMaxTransferre,
        pageTransferre: pageTransferre ?? this.pageTransferre);
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
        hasReachedMax,
        listconvertFromBranch,
        convertFromBranchStatus,
        hasReachedMaxTransferre,
        pageTransferre,
      ];
}
