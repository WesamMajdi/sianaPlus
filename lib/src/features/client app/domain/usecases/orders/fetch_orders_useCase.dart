// fetch_categories_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/network/base_response.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/basket_Model.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/color_entery.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/order_maintenance%20_model.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/order_product_model.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/region/region_model.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/orders/orders_entity.dart';
import 'package:maintenance_app/src/features/client%20app/domain/repositories/orders/orders_repository.dart';
import 'package:maintenance_app/src/features/client%20app/domain/repositories/product/product_repository.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/data/model/create_Order_request.dart';

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

  Future<Either<Failure, int>> getNewOrderId() {
    return repository.getNewOrderId();
  }

  Future<Either<Failure, OrderMaintenanceRequest>> getNewOrderMaintenance() {
    return repository.getNewOrderMaintenance();
  }

  Future<Either<Failure, PaginatedResponse<OrderEntity>>>
      getOrderMaintenanceRequestsForApproval(
          PaginationParams paginationParams) {
    return repository.getOrderMaintenanceRequestsForApproval(paginationParams);
  }

  Future<Either<Failure, Map<String, dynamic>>> responseFromTheCustomer(
      {required int receiptItemId,
      bool? customerApproved,
      String? reasonForRefusingMaintenance}) {
    return repository.responseFromTheCustomer(
      receiptItemId: receiptItemId,
      customerApproved: customerApproved,
      reasonForRefusingMaintenance: reasonForRefusingMaintenance,
    );
  }

  Future<Either<Failure, void>> addHandReceiptItemsByDm(
      int handReceiptId, CreateOrderDeliveryRequest createOrderRequest) {
    return repository.addHandReceiptItemsByDm(
        handReceiptId, createOrderRequest);
  }

  Future<Either<Failure, PaginatedResponse<OrderProductModel>>>
      getOrderProductByUserNew(PaginationParams paginationParams) {
    return repository.getOrderProductByUserNew(paginationParams);
  }

  Future<Either<Failure, PaginatedResponse<OrderProductModel>>>
      getOrderProductByUserOld(PaginationParams paginationParams) {
    return repository.getOrderProductByUserOld(paginationParams);
  }

  Future<Either<Failure, List<BasketModel>>> getAllItemByOrder(int basketId) {
    return repository.getAllItemByOrder(basketId);
  }
}
