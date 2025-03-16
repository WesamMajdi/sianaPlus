import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/error/failure.dart';
import 'package:maintenance_app/src/core/pagination/paginated_response.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/online_maintenance_parts/online_maintenance_parts_entity.dart';

abstract class OnlineRepository {
  Future<Either<Failure, PaginatedResponse<OnlineEntity>>> getAllOnlineItem(
      PaginationParams paginationParams, String? searchQuery, String? barcode);

  Future<Either<Failure, Map<String, dynamic>>> updateStatusForOnlineItem(
    int receiptItemId,
    int? status,
  );

  Future<Either<Failure, Map<String, dynamic>>> defineMalfunctionForOnlineItem(
    int receiptItemId,
    String? description,
  );

  Future<Either<Failure, Map<String, dynamic>>>
      enterMaintenanceCostForOnlineItem({
    required int receiptItemId,
    required String costNotifiedToTheCustomer,
    int warrantyDaysNumber = 0,
  });

  Future<Either<Failure, OnlineEntity>> getOnlineItem(int id);
  Future<Either<Failure, Map<String, dynamic>>> suspendMaintenanceForOnlineItem(
      int receiptItemId, String? maintenanceSuspensionReason);

  Future<Either<Failure, Map<String, dynamic>>> reopenMaintenanceOnlineItem(
      int receiptItemId);
}
