import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/data_sources/maintenance_parts_hand_receipt/maintenance_parts_data_source.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/hand_receipt_maintenance_parts/hand_receipt_maintenance_parts_entitie.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/repositories/hand_receipt_maintenance_parts/maintenance_parts.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/pagination/paginated_response.dart';
import '../../../../../core/pagination/pagination_params.dart';

class HandReceiptRepositoryImpl implements HandReceiptRepository {
  final HandReceiptRemoteDataSource remoteDataSource;

  HandReceiptRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, PaginatedResponse<HandReceiptEntity>>>
      getAllHandHandReceiptItem(PaginationParams paginationParams,
          String? searchQuery, String? barcode) async {
    try {
      final response = await remoteDataSource.getAllHandReceiptItems(
          paginationParams, searchQuery, barcode);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> updateStatusForHandReceiptItem(
      int receiptItemId, int? status) async {
    try {
      final response = await remoteDataSource.updateStatusForHandReceiptItem(
          receiptItemId, status!);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>>
      defineMalfunctionForHandReceiptItem(
          int receiptItemId, String? description) async {
    try {
      final response = await remoteDataSource
          .defineMalfunctionForHandReceiptItem(receiptItemId, description!);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>>
      customerRefuseMaintenanceForHandReceiptItem(
    int receiptItemId,
    String reasonForRefusingMaintenance,
  ) async {
    try {
      final response =
          await remoteDataSource.customerRefuseMaintenanceForHandReceiptItem(
              receiptItemId: receiptItemId,
              reasonForRefusingMaintenance: reasonForRefusingMaintenance);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>>
      enterMaintenanceCostForHandReceiptItem({
    required int receiptItemId,
    required double costNotifiedToTheCustomer,
    int warrantyDaysNumber = 0,
  }) async {
    try {
      final response =
          await remoteDataSource.enterMaintenanceCostForHandReceiptItem(
        receiptItemId: receiptItemId,
        costNotifiedToTheCustomer: costNotifiedToTheCustomer,
        warrantyDaysNumber: warrantyDaysNumber,
      );
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>>
      suspendMaintenanceForHandReceiptItem(
          int receiptItemId, String? maintenanceSuspensionReason) async {
    try {
      final response =
          await remoteDataSource.suspendMaintenanceForHandReceiptItem(
              receiptItemId: receiptItemId,
              maintenanceSuspensionReason: maintenanceSuspensionReason!);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>>
      reopenMaintenanceHandReceiptItem(int receiptItemId) async {
    try {
      final response =
          await remoteDataSource.reopenMaintenanceForReturnHandReceiptItem(
              receiptItemId: receiptItemId);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, HandReceiptEntity>> getHandReceiptItem(int id) async {
    try {
      final response = await remoteDataSource.getHandReceiptItem(id);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedResponse<HandReceiptEntity>>>
      getAllConvertFromBranch(PaginationParams paginationParams,
          String? searchQuery, String? barcode) async {
    try {
      final response = await remoteDataSource.getAllConvertFromBranch(
          paginationParams, searchQuery, barcode);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
