import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/error/failure.dart';
import 'package:maintenance_app/src/core/pagination/paginated_response.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/maintenance_parts/maintenance_parts_entitie.dart';

abstract class HandReceiptRepository {
  Future<Either<Failure, PaginatedResponse<HandReceiptEntity>>>
      getHandHandReceiptItem(PaginationParams paginationParams,
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
    required int warrantyDaysNumber,
  });
}
