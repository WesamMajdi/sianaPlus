import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/error/failure.dart';
import 'package:maintenance_app/src/core/pagination/paginated_response.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/hand_receipt_maintenance_parts/hand_receipt_maintenance_parts_entitie.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/repositories/hand_receipt_maintenance_parts/maintenance_parts.dart';

class HandReceiptUseCase {
  final HandReceiptRepository repository;

  HandReceiptUseCase(this.repository);

  Future<Either<Failure, PaginatedResponse<HandReceiptEntity>>>
      getAllHandHandReceiptItem(PaginationParams paginationParams,
          String searchQuery, String barcode) {
    return repository.getAllHandHandReceiptItem(
        paginationParams, searchQuery, barcode);
  }

  Future<Either<Failure, Map<String, dynamic>>> updateStatusForHandReceiptItem(
      int receiptItemId, int? status) {
    return repository.updateStatusForHandReceiptItem(receiptItemId, status!);
  }

  Future<Either<Failure, Map<String, dynamic>>>
      defineMalfunctionForHandReceiptItem(
          int receiptItemId, String description) {
    return repository.defineMalfunctionForHandReceiptItem(
        receiptItemId, description);
  }

  Future<Either<Failure, Map<String, dynamic>>>
      enterMaintenanceCostForHandReceiptItem({
    required int receiptItemId,
    required double costNotifiedToTheCustomer,
    int warrantyDaysNumber = 0,
  }) {
    return repository.enterMaintenanceCostForHandReceiptItem(
      receiptItemId: receiptItemId,
      costNotifiedToTheCustomer: costNotifiedToTheCustomer,
      warrantyDaysNumber: warrantyDaysNumber,
    );
  }

  Future<Either<Failure, HandReceiptEntity>> getHandReceiptItem(int id) {
    return repository.getHandReceiptItem(id);
  }

  Future<Either<Failure, Map<String, dynamic>>>
      suspendMaintenanceForHandReceiptItem(
          int receiptItemId, String? maintenanceSuspensionReason) {
    return repository.suspendMaintenanceForHandReceiptItem(
        receiptItemId, maintenanceSuspensionReason!);
  }

  Future<Either<Failure, Map<String, dynamic>>>
      reopenMaintenanceHandReceiptItem(
    int receiptItemId,
  ) {
    return repository.reopenMaintenanceHandReceiptItem(receiptItemId);
  }

  Future<Either<Failure, Map<String, dynamic>>>
      customerRefuseMaintenanceForHandReceiptItem(
          int receiptItemId, String reasonForRefusingMaintenance) {
    return repository.customerRefuseMaintenanceForHandReceiptItem(
        receiptItemId, reasonForRefusingMaintenance);
  }

  Future<Either<Failure, PaginatedResponse<HandReceiptEntity>>>
      getAllConvertFromBranch(PaginationParams paginationParams,
          String searchQuery, String barcode) {
    return repository.getAllConvertFromBranch(
        paginationParams, searchQuery, barcode);
  }
}
