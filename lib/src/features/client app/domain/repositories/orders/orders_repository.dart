// category_repository.dart
import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/network/base_response.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/color_entery.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/pagination/paginated_response.dart';
import '../../../data/model/orders/orders_model_request.dart';
import '../../entities/orders/orders_entity.dart';

abstract class OrderRepository {
  Future<Either<Failure, BaseResponse<List<OrderEntery>>>> getColorList();
  Future<Either<Failure, BaseResponse<List<OrderEntery>>>> getItemsList();
  Future<Either<Failure, BaseResponse<List<OrderEntery>>>> getCompaniesList();
  Future<Either<Failure, void>> createOrderMaintenance(
      CreateOrderRequest createOrderRequest);
  Future<Either<Failure, PaginatedResponse<OrderEntity>>>
  getOrderMaintenanceByUserNew(PaginationParams paginationParams);
  // Future<Either<Failure, PaginatedResponse<OrderEntity>>>
  //     getOrderCurrentMaintenanceItem(PaginationParams paginationParams);
}
