// category_repository.dart
import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/network/base_response.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/basket_Model.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/color_entery.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/order_maintenance%20_model.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/order_product_model.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/data/model/create_Order_request.dart';
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
  Future<Either<Failure, PaginatedResponse<OrderEntity>>>
      getOrderMaintenanceByUserOld(PaginationParams paginationParams);
  Future<Either<Failure, OrderMaintenanceRequest>> getNewOrderMaintenance();
  Future<Either<Failure, PaginatedResponse<OrderEntity>>>
      getOrderMaintenanceRequestsForApproval(PaginationParams paginationParams);

  Future<Either<Failure, Map<String, dynamic>>> responseFromTheCustomer(
      {required int receiptItemId,
      bool? customerApproved,
      String? reasonForRefusingMaintenance});

  Future<Either<Failure, void>> addHandReceiptItemsByDm(
      int handReceiptId, CreateOrderDeliveryRequest createOrderRequest);

  Future<Either<Failure, PaginatedResponse<OrderProductModel>>>
      getOrderProductByUserOld(PaginationParams paginationParams);
  Future<Either<Failure, PaginatedResponse<OrderProductModel>>>
      getOrderProductByUserNew(PaginationParams paginationParams);
  Future<Either<Failure, List<BasketModel>>> getAllItemByOrder(int basketId);
  Future<Either<Failure, bool>> payWithApp(int orderMaintenancId);
}
