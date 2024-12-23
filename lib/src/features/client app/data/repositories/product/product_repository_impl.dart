import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product_entity.dart';
import 'package:maintenance_app/src/features/client%20app/domain/repositories/product/product_repository.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/pagination/paginated_response.dart';
import '../../../../../core/pagination/pagination_params.dart';
import '../../../domain/entities/category/category_entity.dart';
import '../../../domain/repositories/category/category_repository.dart';
import '../../data_sources/category/category_data_source.dart';
import '../../data_sources/product/product_data_source.dart';
import '../../model/category/category_model.dart';
import '../../model/meta_model.dart';


class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, PaginatedResponse<Product>>> getProductsByCategory(PaginationParams paginationParams) async {
    try {
      final response = await remoteDataSource.getProductByCategory(paginationParams);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}