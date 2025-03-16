import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/data_sources/maintenance_parts_online/maintenance_parts_online_data_source.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/online_maintenance_parts/online_maintenance_parts_entity.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/repositories/online_maintenance_parts/online_maintenance_parts.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/pagination/paginated_response.dart';
import '../../../../../core/pagination/pagination_params.dart';

class OnlineRepositoryImpl implements OnlineRepository {
  final OnlineRemoteDataSource remoteDataSource;

  OnlineRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, PaginatedResponse<OnlineEntity>>> getAllOnlineItem(
      PaginationParams paginationParams,
      String? searchQuery,
      String? barcode) async {
    try {
      final response = await remoteDataSource.getAllOnlineItems(
          paginationParams, searchQuery, barcode);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> updateStatusForOnlineItem(
      int receiptItemId, int? status) async {
    try {
      final response =
          await remoteDataSource.updateStatusOnlineItem(receiptItemId, status!);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> defineMalfunctionForOnlineItem(
      int receiptItemId, String? description) async {
    try {
      final response = await remoteDataSource.defineMalfunctionOnlineItem(
          receiptItemId, description!);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>>
      enterMaintenanceCostForOnlineItem({
    required int receiptItemId,
    required String costNotifiedToTheCustomer,
    int warrantyDaysNumber = 0,
  }) async {
    try {
      final response = await remoteDataSource.enterMaintenanceCostForOnlineItem(
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
  Future<Either<Failure, Map<String, dynamic>>> suspendMaintenanceForOnlineItem(
      int receiptItemId, String? maintenanceSuspensionReason) async {
    try {
      final response = await remoteDataSource.suspendMaintenanceForOnlineItem(
          receiptItemId: receiptItemId,
          maintenanceSuspensionReason: maintenanceSuspensionReason!);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> reopenMaintenanceOnlineItem(
      int receiptItemId) async {
    try {
      final response = await remoteDataSource.reopenMaintenanceForOnlineItem(
          receiptItemId: receiptItemId);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, OnlineEntity>> getOnlineItem(int id) async {
    try {
      final response = await remoteDataSource.getOnlineItem(id);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
