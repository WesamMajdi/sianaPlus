// category_repository.dart
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/pagination/paginated_response.dart';
import '../../../../../core/pagination/pagination_params.dart';
import '../../../data/model/category/category_model.dart';
import '../../entities/category/category_entity.dart';


abstract class CategoryRepository {
  Future<Either<Failure,  PaginatedResponse<CategoryModel>>> fetchCategories(PaginationParams paginationParams);
  Future<Either<Failure,  PaginatedResponse<CategoryModel>>> getSubCategories(PaginationParams paginationParams);
}
