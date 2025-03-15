import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/error/failure.dart';
import 'package:maintenance_app/src/core/pagination/paginated_response.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/recovered_maintenance_parts/recovered_maintenance_parts_entity.dart';

abstract class ReturnHandReceiptRepository {
  Future<Either<Failure, PaginatedResponse<ReturnHandReceiptEntity>>>
      getAllReturnHandReceiptItems(
    PaginationParams paginationParams,
    String? searchQuery,
    String? barcode,
  );

  Future<Either<Failure, Map<String, dynamic>>>
      updateStatusForReturnHandReceiptItem(
    int receiptItemId,
    int? status,
  );

  Future<Either<Failure, Map<String, dynamic>>>
      defineMalfunctionForReturnHandReceiptItem(
    int receiptItemId,
    String? description,
  );

  Future<Either<Failure, Map<String, dynamic>>>
      enterMaintenanceCostForReturnHandReceiptItem({
    required int receiptItemId,
    required double costNotifiedToTheCustomer,
    required int warrantyDaysNumber,
  });

  Future<Either<Failure, ReturnHandReceiptEntity>> getReturnHandReceiptItem(
      int id);
  Future<Either<Failure, Map<String, dynamic>>>
      suspenseMaintenanceForReturnHandReceiptItem({
    required int receiptItemId,
    required String? maintenanceSuspensionReason,
  });

  Future<Either<Failure, Map<String, dynamic>>>
      reOpenMaintenanceForReturnHandReceiptItem({
    required int receiptItemId,
  });
}
