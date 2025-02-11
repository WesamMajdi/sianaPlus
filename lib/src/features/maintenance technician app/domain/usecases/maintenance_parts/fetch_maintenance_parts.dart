import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/error/failure.dart';
import 'package:maintenance_app/src/core/pagination/paginated_response.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/orders_model_request.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/maintenance_parts/maintenance_parts_entitie.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/repositories/maintenance_parts/maintenance_parts.dart';

class HandReceiptUseCase {
  final HandReceiptRepository repository;

  HandReceiptUseCase(this.repository);

  Future<Either<Failure, PaginatedResponse<HandReceiptEntity>>>
      getHandHandReceiptItem(PaginationParams paginationParams,
          String searchQuery, String barcode) {
    return repository.getHandHandReceiptItem(
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
    required int warrantyDaysNumber,
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
}
