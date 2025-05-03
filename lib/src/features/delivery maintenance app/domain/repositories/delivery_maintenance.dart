import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/error/failure.dart';
import 'package:maintenance_app/src/core/pagination/paginated_response.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/data/model/branch_model.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/data/model/receipt_item_convert_model.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/entities/order_maintenances_details_entity.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/entities/receive_order_Maintenance_entity.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/hand_receipt_maintenance_parts/hand_receipt_maintenance_parts_entitie.dart';

abstract class DeliveryMaintenanceRepository {
  Future<Either<Failure, PaginatedResponse<ReceiveMaintenanceOrderEntity>>>
      getAllForAllDelivery(
    PaginationParams paginationParams,
  );
  Future<Either<Failure, List<Branch>>> getBranches();
  Future<Either<Failure, PaginatedResponse<ReceiveMaintenanceOrderEntity>>>
      getAllTakeDelivery(
    PaginationParams paginationParams,
  );

  Future<Either<Failure, PaginatedResponse<ReceiveMaintenanceOrderEntity>>>
      getAllTakePerviousOrder(
    PaginationParams paginationParams,
  );

  Future<Either<Failure, Map<String, dynamic>>> takeOrderMaintenance(
      int orderMaintenancId);

  Future<Either<Failure, Map<String, dynamic>>> updateOrderMaintenance(
      int orderMaintenancId, int? status);

  Future<Either<Failure, OrderMaintenancesDetailsEntity>>
      getAllItemByOrderDetiles(int handReceiptId, int orderMaintenancId);

  Future<Either<Failure, Map<String, dynamic>>> selectBranch(
      int orderMaintenancId, int? branchId);

  Future<Either<Failure, PaginatedResponse<HandReceiptEntity>>>
      getAllForAllDeliveryTransfer(
    PaginationParams paginationParams,
  );

  Future<Either<Failure, void>> payWithCard(int orderMaintenancId);
  Future<Either<Failure, void>> payWithCash(int orderMaintenancId);

  Future<Either<Failure, PaginatedResponse<ReceiptItemConvertModel>>>
      getAllForAllDeliveryConvert(
    PaginationParams paginationParams,
  );
  Future<Either<Failure, PaginatedResponse<ReceiptItemConvertModel>>>
      getAllTakeDeliveryConvert(
    PaginationParams paginationParams,
  );
  Future<Either<Failure, PaginatedResponse<ReceiptItemConvertModel>>>
      getAllForDeliveryConvert(
    PaginationParams paginationParams,
  );
  Future<Either<Failure, Map<String, dynamic>>> takeOrderMaintenanceConvert(
      int orderMaintenancId);
  Future<Either<Failure, Map<String, dynamic>>> updateOrderMaintenanceConvert(
      int orderMaintenancId, int? status);

  Future<Either<Failure, PaginatedResponse<ReceiptItemConvertModel>>>
      getAllForAllDeliveryOutSide(
    PaginationParams paginationParams,
  );
  Future<Either<Failure, PaginatedResponse<ReceiptItemConvertModel>>>
      getAllTakeDeliveryOutSide(
    PaginationParams paginationParams,
  );
  Future<Either<Failure, PaginatedResponse<ReceiptItemConvertModel>>>
      getAllForDeliveryOutSide(
    PaginationParams paginationParams,
  );
  Future<Either<Failure, Map<String, dynamic>>> takeOrderMaintenanceoOutSide(
      int orderMaintenancId);
  Future<Either<Failure, Map<String, dynamic>>> updateOrderMaintenanceOutSide(
      int orderMaintenancId, int? status);
}
