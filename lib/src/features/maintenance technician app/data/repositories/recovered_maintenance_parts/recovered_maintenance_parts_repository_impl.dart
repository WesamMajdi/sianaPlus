// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/error/failure.dart';
import 'package:maintenance_app/src/core/pagination/paginated_response.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/data_sources/recovered_maintenance_parts/recovered_maintenance_parts_data_source.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/model/recovered_maintenance_parts/recovered_maintenance_parts_model.dart';

import '../../../domain/repositories/recovered_maintenance_parts/recovered_maintenance_parts.dart';
// import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/repositories/recovered_maintenance_parts/recovered_maintenance_parts.dart';

class ReturnHandReceiptRepositoryImpl implements ReturnHandReceiptRepository {
  final ReturnHandReceiptRemoteDataSource remoteDataSource;

  ReturnHandReceiptRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PaginatedResponse<ReturnHandReceiptModel>>>
      getAllReturnHandReceiptItems(PaginationParams paginationParams,
          String? searchQuery, String? barcode) async {
    try {
      final response = await remoteDataSource.getAllReturnHandReceiptItems(
          paginationParams, searchQuery, barcode);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ReturnHandReceiptModel>> getReturnHandReceiptItem(
      int id) async {
    try {
      final response = await remoteDataSource.getReturnHandReceiptItem(id);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>>
      updateStatusForReturnHandReceiptItem(
          int receiptItemId, int? status) async {
    try {
      final response = await remoteDataSource
          .updateStatusForReturnHandReceiptItem(receiptItemId, status!);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>>
      defineMalfunctionForReturnHandReceiptItem(
          int receiptItemId, String? description) async {
    try {
      final response =
          await remoteDataSource.defineMalfunctionForReturnHandReceiptItem(
              receiptItemId, description!);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>>
      enterMaintenanceCostForReturnHandReceiptItem({
    required int receiptItemId,
    required double costNotifiedToTheCustomer,
    required int warrantyDaysNumber,
  }) async {
    try {
      final response =
          await remoteDataSource.enterMaintenanceCostForReturnHandReceiptItem(
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
      suspenseMaintenanceForReturnHandReceiptItem(
          {required int receiptItemId,
          required String? maintenanceSuspensionReason}) async {
    try {
      final response =
          await remoteDataSource.suspenseMaintenanceForReturnHandReceiptItem(
              receiptItemId: receiptItemId,
              maintenanceSuspensionReason: maintenanceSuspensionReason!);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>>
      reOpenMaintenanceForReturnHandReceiptItem(
          {required int receiptItemId}) async {
    try {
      final response =
          await remoteDataSource.reOpenMaintenanceForReturnHandReceiptItem(
              receiptItemId: receiptItemId);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
