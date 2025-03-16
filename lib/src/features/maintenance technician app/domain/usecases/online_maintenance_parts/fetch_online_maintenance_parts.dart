import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/error/failure.dart';
import 'package:maintenance_app/src/core/pagination/paginated_response.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/online_maintenance_parts/online_maintenance_parts_entity.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/repositories/online_maintenance_parts/online_maintenance_parts.dart';

class OnlineUseCase {
  final OnlineRepository repository;

  OnlineUseCase(this.repository);

  Future<Either<Failure, PaginatedResponse<OnlineEntity>>> getAllOnlineItem(
      PaginationParams paginationParams, String searchQuery, String barcode) {
    return repository.getAllOnlineItem(paginationParams, searchQuery, barcode);
  }

  Future<Either<Failure, Map<String, dynamic>>> updateStatusForOnlineItem(
      int receiptItemId, int? status) {
    return repository.updateStatusForOnlineItem(receiptItemId, status!);
  }

  Future<Either<Failure, Map<String, dynamic>>> defineMalfunctionForOnlineItem(
      int receiptItemId, String description) {
    return repository.defineMalfunctionForOnlineItem(
        receiptItemId, description);
  }

  Future<Either<Failure, Map<String, dynamic>>>
      enterMaintenanceCostForOnlineItem({
    required int receiptItemId,
    required String costNotifiedToTheCustomer,
    int warrantyDaysNumber = 0,
  }) {
    return repository.enterMaintenanceCostForOnlineItem(
      receiptItemId: receiptItemId,
      costNotifiedToTheCustomer: costNotifiedToTheCustomer,
      warrantyDaysNumber: warrantyDaysNumber,
    );
  }

  Future<Either<Failure, OnlineEntity>> getOnlineItem(int id) {
    return repository.getOnlineItem(id);
  }

  Future<Either<Failure, Map<String, dynamic>>> suspendMaintenanceForOnlineItem(
      int receiptItemId, String? maintenanceSuspensionReason) {
    return repository.suspendMaintenanceForOnlineItem(
        receiptItemId, maintenanceSuspensionReason!);
  }

  Future<Either<Failure, Map<String, dynamic>>> reopenMaintenanceOnlineItem(
    int receiptItemId,
  ) {
    return repository.reopenMaintenanceOnlineItem(receiptItemId);
  }
}
