import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/error/failure.dart';
import 'package:maintenance_app/src/core/pagination/paginated_response.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/orders/orders_details_entity.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/data/data_sources/delivery_shop_data_source.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/data/model/current_order_detiles_model.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/domain/entities/current_order_detiles_entity.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/domain/entities/receive_order_detiels_entity.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/domain/entities/receive_order_entity.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/domain/repositories/delivery_shop.dart';

class DeliveryShopRepositoryImpl implements DeliveryShopRepository {
  final DeliveryShopRemoteDataSource remoteDataSource;

  DeliveryShopRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, PaginatedResponse<ReceiveOrderEntity>>>
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
  Future<Either<Failure, PaginatedResponse<ReceiveOrderDetielsEntity>>>
      getAllItemsByOrder(
          PaginationParams paginationParams, int basketId) async {
    try {
      final response =
          await remoteDataSource.getAllItemsByOrder(paginationParams, basketId);

      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> takeOrder(int basketId) async {
    try {
      final response = await remoteDataSource.takeOrder(basketId);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedResponse<ReceiveOrderEntity>>>
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
  Future<Either<Failure, PaginatedResponse<ReceiveOrderEntity>>>
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
  Future<Either<Failure, OrderCurrentDetailsEntity>> getAllItemByOrderDetiles(
      int basketId) async {
    try {
      final response =
          await remoteDataSource.getAllItemByOrderDetiles(basketId);

      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
