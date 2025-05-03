import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/network/base_response.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/basket_Model.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/color_entery.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/order_maintenance%20_model.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/order_product_model.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/orders_model.dart';
import 'package:maintenance_app/src/features/client%20app/domain/repositories/orders/orders_repository.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/data/model/create_Order_request.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/pagination/paginated_response.dart';
import '../../../../../core/pagination/pagination_params.dart';
import '../../data_sources/orders/orders_data_source.dart';
import '../../model/orders/orders_model_request.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, BaseResponse<List<OrderEntery>>>>
      getCompaniesList() async {
    try {
      final response = await remoteDataSource.getCompaniesList();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<List<OrderEntery>>>>
      getItemsList() async {
    try {
      final response = await remoteDataSource.getItemsList();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<List<OrderEntery>>>>
      getColorList() async {
    try {
      final response = await remoteDataSource.getColorList();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createOrderMaintenance(
      CreateOrderRequest createOrderRequest) async {
    try {
      await remoteDataSource.createOrderMaintenance(createOrderRequest);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedResponse<OrderModel>>>
      getOrderMaintenanceByUserNew(PaginationParams paginationParams) async {
    try {
      final response =
          await remoteDataSource.getOrderMaintenanceByUserNew(paginationParams);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedResponse<OrderModel>>>
      getOrderMaintenanceByUserOld(PaginationParams paginationParams) async {
    try {
      final response =
          await remoteDataSource.getOrderMaintenanceByUserOld(paginationParams);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, OrderMaintenanceRequest>>
      getNewOrderMaintenance() async {
    try {
      final response = await remoteDataSource.getNewOrderMaintenance();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedResponse<OrderModel>>>
      getOrderMaintenanceRequestsForApproval(
          PaginationParams paginationParams) async {
    try {
      final response = await remoteDataSource
          .getOrderMaintenanceRequestsForApproval(paginationParams);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> responseFromTheCustomer(
      {required int receiptItemId,
      bool? customerApproved,
      String? reasonForRefusingMaintenance}) async {
    try {
      final response = await remoteDataSource.responseFromTheCustomer(
        receiptItemId,
        customerApproved,
        reasonForRefusingMaintenance!,
      );
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addHandReceiptItemsByDm(
      int handReceiptId, CreateOrderDeliveryRequest createOrderRequest) async {
    try {
      final response = await remoteDataSource.addHandReceiptItemsByDm(
          handReceiptId, createOrderRequest);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedResponse<OrderProductModel>>>
      getOrderProductByUserNew(PaginationParams paginationParams) async {
    try {
      final response =
          await remoteDataSource.getOrderProductByUserNew(paginationParams);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedResponse<OrderProductModel>>>
      getOrderProductByUserOld(PaginationParams paginationParams) async {
    try {
      final response =
          await remoteDataSource.getOrderProductByUserOld(paginationParams);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BasketModel>>> getAllItemByOrder(
      int basketId) async {
    try {
      final response = await remoteDataSource.getAllItemByOrder(basketId);

      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> payWithApp(int orderMaintenancId) async {
    try {
      await remoteDataSource.payWithApp(orderMaintenancId);
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
