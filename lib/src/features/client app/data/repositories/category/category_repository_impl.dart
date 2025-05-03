import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/network/base_response.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/region/region_model.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/pagination/paginated_response.dart';
import '../../../../../core/pagination/pagination_params.dart';
import '../../../domain/entities/category/category_entity.dart';
import '../../../domain/repositories/category/category_repository.dart';
import '../../data_sources/category/category_data_source.dart';
import '../../model/category/category_model.dart';
import '../../model/meta_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, PaginatedResponse<CategoryModel>>> fetchCategories(
      PaginationParams paginationParams) async {
    try {
      final response = await remoteDataSource.getMainCategory(paginationParams);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedResponse<CategoryModel>>> getSubCategories(
      PaginationParams paginationParams) async {
    try {
      final response =
          await remoteDataSource.getSubCategories(paginationParams);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<List<BaseViewModel>>>> getRegion() async {
    try {
      final response = await remoteDataSource.getRegion();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<List<BaseViewModel>>>> getCity(
      int regionId) async {
    try {
      final response = await remoteDataSource.getCity(regionId);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<List<BaseViewModel>>>> getVillage(
      int cityId) async {
    try {
      final response = await remoteDataSource.getVillage(cityId);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getNewOrderId() async {
    try {
      final response = await remoteDataSource.getNewOrderId();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
