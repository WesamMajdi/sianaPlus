import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/error/failure.dart';
import 'package:maintenance_app/src/core/pagination/paginated_response.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/data/model/branch_model.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/entities/order_maintenances_details_entity.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/entities/receive_order_Maintenance_entity.dart';

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
}
