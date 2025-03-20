import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/error/failure.dart';
import 'package:maintenance_app/src/core/pagination/paginated_response.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/orders_model_request.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/data/data_sources/delivery_maintenance_data_source.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/data/model/branch_model.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/data/model/order_maintenances_details_model.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/entities/order_maintenances_details_entity.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/entities/receive_order_Maintenance_entity.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/repositories/delivery_maintenance.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/hand_receipt_maintenance_parts/hand_receipt_maintenance_parts_entitie.dart';

class DeliveryMaintenanceRepositoryImpl
    implements DeliveryMaintenanceRepository {
  final DeliveryMaintenanceRemoteDataSource remoteDataSource;

  DeliveryMaintenanceRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, PaginatedResponse<ReceiveMaintenanceOrderEntity>>>
      getAllForAllDelivery(PaginationParams paginationParams) async {
    try {
      final response =
          await remoteDataSource.getAllForAllDelivery(paginationParams);

      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedResponse<ReceiveMaintenanceOrderEntity>>>
      getAllTakeDelivery(PaginationParams paginationParams) async {
    try {
      final response =
          await remoteDataSource.getAllTakeDelivery(paginationParams);

      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedResponse<ReceiveMaintenanceOrderEntity>>>
      getAllTakePerviousOrder(PaginationParams paginationParams) async {
    try {
      final response =
          await remoteDataSource.getAllTakePerviousOrder(paginationParams);

      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> takeOrderMaintenance(
      int orderMaintenancId) async {
    try {
      final response =
          await remoteDataSource.takeOrderMaintenance(orderMaintenancId);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> updateOrderMaintenance(
      int orderMaintenancId, int? status) async {
    try {
      final response = await remoteDataSource.updateOrderMaintenance(
          orderMaintenancId, status);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, OrderMaintenancesDetailsEntity>>
      getAllItemByOrderDetiles(int handReceiptId, int orderMaintenancId) async {
    try {
      final response = await remoteDataSource.getAllItemByOrderDetiles(
          handReceiptId, orderMaintenancId);

      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Branch>>> getBranches() async {
    try {
      final response = await remoteDataSource.getBranches();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> selectBranch(
      int orderMaintenancId, int? branchId) async {
    try {
      final response =
          await remoteDataSource.selectBranch(orderMaintenancId, branchId);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedResponse<HandReceiptEntity>>>
      getAllForAllDeliveryTransfer(PaginationParams paginationParams) async {
    try {
      final response =
          await remoteDataSource.getAllForAllDeliveryTransfer(paginationParams);

      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
