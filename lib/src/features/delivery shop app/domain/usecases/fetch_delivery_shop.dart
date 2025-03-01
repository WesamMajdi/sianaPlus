import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/error/failure.dart';
import 'package:maintenance_app/src/core/pagination/paginated_response.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/data/model/current_order_detiles_model.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/domain/entities/current_order_detiles_entity.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/domain/entities/receive_order_detiels_entity.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/domain/entities/receive_order_entity.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/domain/repositories/delivery_shop.dart';

class DeliveryShopUseCase {
  final DeliveryShopRepository repository;

  DeliveryShopUseCase(this.repository);

  Future<Either<Failure, PaginatedResponse<ReceiveOrderEntity>>>
      getAllHandHandReceiptItem(
    PaginationParams paginationParams,
  ) {
    return repository.getAllForAllDelivery(paginationParams);
  }

  Future<Either<Failure, PaginatedResponse<ReceiveOrderDetielsEntity>>>
      getAllItemsByOrder(PaginationParams paginationParams, int basketId) {
    return repository.getAllItemsByOrder(paginationParams, basketId);
  }

  Future<Either<Failure, Map<String, dynamic>>> takeOrder(int basketId) {
    return repository.takeOrder(basketId);
  }

  Future<Either<Failure, PaginatedResponse<ReceiveOrderEntity>>>
      getAllTakeDelivery(
    PaginationParams paginationParams,
  ) {
    return repository.getAllForAllDelivery(paginationParams);
  }

  Future<Either<Failure, PaginatedResponse<ReceiveOrderEntity>>>
      getAllTakePerviousOrder(
    PaginationParams paginationParams,
  ) {
    return repository.getAllTakePerviousOrder(paginationParams);
  }

  Future<Either<Failure, OrderCurrentDetailsEntity>> getAllItemByOrderDetiles(
      int basketId) {
    return repository.getAllItemByOrderDetiles(basketId);
  }

  Future<Either<Failure, Map<String, dynamic>>> updateStatusForOrder(
      int orderId, int? status) {
    return repository.updateStatusForOrder(orderId, status!);
  }
}
