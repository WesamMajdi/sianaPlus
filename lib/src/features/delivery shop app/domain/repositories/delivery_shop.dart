import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/error/failure.dart';
import 'package:maintenance_app/src/core/pagination/paginated_response.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/domain/entities/current_order_detiles_entity.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/domain/entities/receive_order_detiels_entity.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/domain/entities/receive_order_entity.dart';

abstract class DeliveryShopRepository {
  Future<Either<Failure, PaginatedResponse<ReceiveOrderEntity>>>
      getAllForAllDelivery(
    PaginationParams paginationParams,
  );

  Future<Either<Failure, PaginatedResponse<ReceiveOrderDetielsEntity>>>
      getAllItemsByOrder(PaginationParams paginationParams, int basketId);

  Future<Either<Failure, Map<String, dynamic>>> takeOrder(int basketId);

  Future<Either<Failure, PaginatedResponse<ReceiveOrderEntity>>>
      getAllTakeDelivery(
    PaginationParams paginationParams,
  );

  Future<Either<Failure, PaginatedResponse<ReceiveOrderEntity>>>
      getAllTakePerviousOrder(
    PaginationParams paginationParams,
  );

  Future<Either<Failure, OrderCurrentDetailsEntity>> getAllItemByOrderDetiles(
      int basketId);
}
