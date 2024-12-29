import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/network/base_response.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/color_entery.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/orders_model.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product/product_entity.dart';
import 'package:maintenance_app/src/features/client%20app/domain/repositories/orders/orders_repository.dart';
import 'package:maintenance_app/src/features/client%20app/domain/repositories/product/product_repository.dart';
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
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedResponse<OrderModel>>>
      getOrderMaintenanceByUser(PaginationParams paginationParams) async {
    try {
      final response =
          await remoteDataSource.getOrderMaintenanceByUser(paginationParams);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedResponse<OrderModel>>>
      getOrderCurrentMaintenanceItem(PaginationParams paginationParams) async {
    try {
      final response =
          await remoteDataSource.getCurrentOrderByUser(paginationParams);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
