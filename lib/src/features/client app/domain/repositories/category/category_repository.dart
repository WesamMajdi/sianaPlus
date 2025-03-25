// category_repository.dart
import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/core/network/base_response.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/region/region_model.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/pagination/paginated_response.dart';
import '../../../../../core/pagination/pagination_params.dart';
import '../../../data/model/category/category_model.dart';
import '../../entities/category/category_entity.dart';

abstract class CategoryRepository {
  Future<Either<Failure, PaginatedResponse<CategoryModel>>> fetchCategories(
      PaginationParams paginationParams);
  Future<Either<Failure, PaginatedResponse<CategoryModel>>> getSubCategories(
      PaginationParams paginationParams);

  Future<Either<Failure, BaseResponse<List<BaseViewModel>>>> getRegion();
  Future<Either<Failure, BaseResponse<List<BaseViewModel>>>> getCity(
      int regionId);
  Future<Either<Failure, BaseResponse<List<BaseViewModel>>>> getVillage(
      int cityId);
}
