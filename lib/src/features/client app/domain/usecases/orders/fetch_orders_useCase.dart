// fetch_categories_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/network/base_response.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/color_entery.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/region/region_model.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/orders/orders_entity.dart';
import 'package:maintenance_app/src/features/client%20app/domain/repositories/orders/orders_repository.dart';
import 'package:maintenance_app/src/features/client%20app/domain/repositories/product/product_repository.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/pagination/paginated_response.dart';
import '../../../../../core/pagination/pagination_params.dart';
import '../../../data/model/orders/orders_model_request.dart';
import '../../entities/product/product_entity.dart';

class OrderUseCase {
  final OrderRepository repository;

  OrderUseCase(this.repository);

  Future<Either<Failure, BaseResponse<List<OrderEntery>>>> getColorLsit() {
    return repository.getColorList();
  }

  Future<Either<Failure, BaseResponse<List<OrderEntery>>>> getItemsList() {
    return repository.getItemsList();
  }

  Future<Either<Failure, BaseResponse<List<OrderEntery>>>> getCompaniesList() {
    return repository.getCompaniesList();
  }

  Future<Either<Failure, void>> createOrderMaintenance(
      CreateOrderRequest createOrderRequest) {
    return repository.createOrderMaintenance(createOrderRequest);
  }

  Future<Either<Failure, PaginatedResponse<OrderEntity>>>
      getOrderMaintenanceByUserNew(PaginationParams paginationParams) {
    return repository.getOrderMaintenanceByUserNew(paginationParams);
  }

  Future<Either<Failure, PaginatedResponse<OrderEntity>>>
      getOrderMaintenanceByUserOld(PaginationParams paginationParams) {
    return repository.getOrderMaintenanceByUserOld(paginationParams);
  }
}
