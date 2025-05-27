import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/error/failure.dart';
import 'package:maintenance_app/src/core/pagination/paginated_response.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/hand_receipt_maintenance_parts/hand_receipt_maintenance_parts_entitie.dart';

abstract class HandReceiptRepository {
  Future<Either<Failure, PaginatedResponse<HandReceiptEntity>>>
      getAllHandHandReceiptItem(PaginationParams paginationParams,
          String? searchQuery, String? barcode);

  Future<Either<Failure, Map<String, dynamic>>> updateStatusForHandReceiptItem(
    int receiptItemId,
    int? status,
  );

  Future<Either<Failure, Map<String, dynamic>>>
      defineMalfunctionForHandReceiptItem(
    int receiptItemId,
    String? description,
  );

  Future<Either<Failure, Map<String, dynamic>>>
      enterMaintenanceCostForHandReceiptItem({
    required int receiptItemId,
    required double costNotifiedToTheCustomer,
    int warrantyDaysNumber = 0,
  });

  Future<Either<Failure, HandReceiptEntity>> getHandReceiptItem(int id);
  Future<Either<Failure, Map<String, dynamic>>>
      suspendMaintenanceForHandReceiptItem(
          int receiptItemId, String? maintenanceSuspensionReason);

  Future<Either<Failure, Map<String, dynamic>>>
      customerRefuseMaintenanceForHandReceiptItem(
          int receiptItemId, String reasonForRefusingMaintenance);

  Future<Either<Failure, Map<String, dynamic>>>
      reopenMaintenanceHandReceiptItem(int receiptItemId);

  Future<Either<Failure, PaginatedResponse<HandReceiptEntity>>>
      getAllConvertFromBranch(PaginationParams paginationParams,
          String? searchQuery, String? barcode);
}
