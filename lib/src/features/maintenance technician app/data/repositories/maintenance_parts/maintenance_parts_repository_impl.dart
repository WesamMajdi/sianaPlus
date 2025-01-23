import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/data_sources/maintenance_parts/maintenance_parts_data_source.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/maintenance_parts/maintenance_parts_entitie.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/repositories/maintenance_parts/maintenance_parts.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/pagination/paginated_response.dart';
import '../../../../../core/pagination/pagination_params.dart';

class HandReceiptRepositoryImpl implements HandReceiptRepository {
  final HandReceiptRemoteDataSource remoteDataSource;

  HandReceiptRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, PaginatedResponse<HandReceiptEntity>>>
      getHandHandReceiptItem(PaginationParams paginationParams,
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
          int receiptItemId, String description) async {
    try {
      final response = await remoteDataSource
          .defineMalfunctionForHandReceiptItem(receiptItemId, description);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
