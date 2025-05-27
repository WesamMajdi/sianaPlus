import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/error/failure.dart';
import 'package:maintenance_app/src/core/pagination/paginated_response.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/data/model/branch_model.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/data/model/create_order_request.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/data/model/receipt_item_convert_model.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/entities/order_maintenances_details_entity.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/entities/receive_order_Maintenance_entity.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/domain/repositories/delivery_maintenance.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/hand_receipt_maintenance_parts/hand_receipt_maintenance_parts_entitie.dart';

class DeliveryMaintenanceUseCase {
  final DeliveryMaintenanceRepository repository;

  DeliveryMaintenanceUseCase(this.repository);

  Future<Either<Failure, PaginatedResponse<ReceiveMaintenanceOrderEntity>>>
      getAllForAllDelivery(
    PaginationParams paginationParams,
  ) {
    return repository.getAllForAllDelivery(paginationParams);
  }

  Future<Either<Failure, List<Branch>>> getBranches() {
    return repository.getBranches();
  }

  Future<Either<Failure, PaginatedResponse<ReceiveMaintenanceOrderEntity>>>
      getAllTakeDelivery(
    PaginationParams paginationParams,
  ) {
    return repository.getAllTakeDelivery(paginationParams);
  }

  Future<Either<Failure, PaginatedResponse<ReceiveMaintenanceOrderEntity>>>
      getAllTakePerviousOrder(
    PaginationParams paginationParams,
  ) {
    return repository.getAllTakePerviousOrder(paginationParams);
  }

  Future<Either<Failure, Map<String, dynamic>>> takeOrderMaintenance(
      int orderMaintenancId) {
    return repository.takeOrderMaintenance(orderMaintenancId);
  }

  Future<Either<Failure, Map<String, dynamic>>> updateOrderMaintenance(
      int orderMaintenancId, int? status) {
    return repository.updateOrderMaintenance(orderMaintenancId, status);
  }

  Future<Either<Failure, OrderMaintenancesDetailsEntity>>
      getAllItemByOrderDetiles(int handReceiptId, int orderMaintenancId) {
    return repository.getAllItemByOrderDetiles(
        handReceiptId, orderMaintenancId);
  }

  Future<Either<Failure, Map<String, dynamic>>> selectBranch(
      int orderMaintenancId, int? branchId) {
    return repository.selectBranch(orderMaintenancId, branchId);
  }

  Future<Either<Failure, PaginatedResponse<HandReceiptEntity>>>
      getAllForAllDeliveryTransfer(
    PaginationParams paginationParams,
  ) {
    return repository.getAllForAllDeliveryTransfer(paginationParams);
  }

  Future<Either<Failure, void>> payWithCard(int orderMaintenancId) {
    return repository.payWithCard(orderMaintenancId);
  }

  Future<Either<Failure, void>> payWithCash(int orderMaintenancId) {
    return repository.payWithCash(orderMaintenancId);
  }

  Future<Either<Failure, PaginatedResponse<ReceiptItemConvertModel>>>
      getAllForAllDeliveryConvert(
    PaginationParams paginationParams,
    String barcode,
  ) {
    return repository.getAllForAllDeliveryConvert(paginationParams, barcode);
  }

  Future<Either<Failure, PaginatedResponse<ReceiptItemConvertModel>>>
      getAllTakeDeliveryConvert(
    PaginationParams paginationParams,
    String barcode,
  ) {
    return repository.getAllTakeDeliveryConvert(paginationParams, barcode);
  }

  Future<Either<Failure, PaginatedResponse<ReceiptItemConvertModel>>>
      getAllForDeliveryConvert(
    PaginationParams paginationParams,
  ) {
    return repository.getAllForDeliveryConvert(paginationParams);
  }

  Future<Either<Failure, Map<String, dynamic>>> updateOrderMaintenanceConvert(
      int orderMaintenancId, int? status) {
    return repository.updateOrderMaintenanceConvert(orderMaintenancId, status);
  }

  Future<Either<Failure, Map<String, dynamic>>> takeOrderMaintenanceConvert(
      int orderMaintenancId) {
    return repository.takeOrderMaintenanceConvert(orderMaintenancId);
  }

  Future<Either<Failure, PaginatedResponse<ReceiptItemConvertModel>>>
      getAllForAllDeliveryOutSide(
    PaginationParams paginationParams,
    String barcode,
  ) {
    return repository.getAllForAllDeliveryOutSide(paginationParams, barcode);
  }

  Future<Either<Failure, PaginatedResponse<ReceiptItemConvertModel>>>
      getAllTakeDeliveryOutSide(
    PaginationParams paginationParams,
    String barcode,
  ) {
    return repository.getAllTakeDeliveryOutSide(paginationParams, barcode);
  }

  Future<Either<Failure, PaginatedResponse<ReceiptItemConvertModel>>>
      getAllForDeliveryOutSide(
    PaginationParams paginationParams,
  ) {
    return repository.getAllForDeliveryOutSide(paginationParams);
  }

  Future<Either<Failure, Map<String, dynamic>>> updateOrderMaintenanceOutSide(
      int orderMaintenancId, int? status) {
    return repository.updateOrderMaintenanceOutSide(orderMaintenancId, status);
  }

  Future<Either<Failure, Map<String, dynamic>>> takeOrderMaintenanceoOutSide(
      int orderMaintenancId) {
    return repository.takeOrderMaintenanceoOutSide(orderMaintenancId);
  }

  Future<Either<Failure, Map<String, dynamic>>> setMaintenancePrice({
    required int convertHandReceiptItemId,
    required double maintenancePrice,
  }) {
    return repository.setMaintenancePrice(
        convertHandReceiptItemId: convertHandReceiptItemId,
        maintenancePrice: maintenancePrice);
  }
}
