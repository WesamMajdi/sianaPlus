import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/error/failure.dart';
import 'package:maintenance_app/src/core/pagination/paginated_response.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/model/recovered_maintenance_parts/recovered_maintenance_parts_model.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/recovered_maintenance_parts/recovered_maintenance_parts_entity.dart';

import '../../repositories/recovered_maintenance_parts/recovered_maintenance_parts.dart';
// import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/repositories/recovered_maintenance_parts/recovered_maintenance_parts.dart';

class ReturnHandReceiptUseCases {
  final ReturnHandReceiptRepository repository;

  ReturnHandReceiptUseCases(this.repository);

  Future<Either<Failure, PaginatedResponse<ReturnHandReceiptEntity>>>
      getAllReturnHandReceiptItems(
    PaginationParams paginationParams,
    String? searchQuery,
    String? barcode,
  ) {
    return repository.getAllReturnHandReceiptItems(
      paginationParams,
      searchQuery,
      barcode,
    );
  }

  Future<Either<Failure, ReturnHandReceiptEntity>> getReturnHandReceiptItem(
      int id) {
    return repository.getReturnHandReceiptItem(id);
  }

  Future<Either<Failure, Map<String, dynamic>>>
      updateStatusForReturnHandReceiptItem({
    required int receiptItemId,
    required int? status,
  }) {
    return repository.updateStatusForReturnHandReceiptItem(
      receiptItemId,
      status,
    );
  }

  Future<Either<Failure, Map<String, dynamic>>>
      defineMalfunctionForReturnHandReceiptItem({
    required int receiptItemId,
    required String? description,
  }) {
    return repository.defineMalfunctionForReturnHandReceiptItem(
      receiptItemId,
      description,
    );
  }

  Future<Either<Failure, Map<String, dynamic>>>
      enterMaintenanceCostForReturnHandReceiptItem({
    required int receiptItemId,
    required double costNotifiedToTheCustomer,
    required int warrantyDaysNumber,
  }) {
    return repository.enterMaintenanceCostForReturnHandReceiptItem(
      receiptItemId: receiptItemId,
      costNotifiedToTheCustomer: costNotifiedToTheCustomer,
      warrantyDaysNumber: warrantyDaysNumber,
    );
  }

  Future<Either<Failure, Map<String, dynamic>>>
      suspendMaintenanceForReturnHandReceiptItem(
          int receiptItemId, String? maintenanceSuspensionReason) {
    return repository.suspenseMaintenanceForReturnHandReceiptItem(
        maintenanceSuspensionReason: maintenanceSuspensionReason!,
        receiptItemId: receiptItemId);
  }

  Future<Either<Failure, Map<String, dynamic>>>
      reOpenMaintenanceForReturnHandReceiptItem(
    int receiptItemId,
  ) {
    return repository.reOpenMaintenanceForReturnHandReceiptItem(
        receiptItemId: receiptItemId);
  }
}
