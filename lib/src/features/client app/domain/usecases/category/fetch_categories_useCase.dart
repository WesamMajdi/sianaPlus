// fetch_categories_usecase.dart
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/pagination/paginated_response.dart';
import '../../../../../core/pagination/pagination_params.dart';
import '../../../data/model/category/category_model.dart';
import '../../entities/category/category_entity.dart';
import '../../repositories/category/category_repository.dart';

class CategoriesUseCase {
  final CategoryRepository repository;

  CategoriesUseCase(this.repository);

  Future<Either<Failure,  PaginatedResponse<CategoryModel>>> getMainCategory(PaginationParams paginationParams) {
    return repository.fetchCategories(paginationParams);
  }
  Future<Either<Failure,  PaginatedResponse<CategoryModel>>> getSubCategories(PaginationParams paginationParams) {
    return repository.getSubCategories(paginationParams);
  }
}
