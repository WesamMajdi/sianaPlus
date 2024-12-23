// category_repository.dart
import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/product/product_model.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product/product_entity.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/pagination/paginated_response.dart';
import '../../../../../core/pagination/pagination_params.dart';
import '../../../data/model/category/category_model.dart';
import '../../entities/category/category_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, PaginatedResponse<Product>>> getProductsByCategory(
      PaginationParams paginationParams);
}
