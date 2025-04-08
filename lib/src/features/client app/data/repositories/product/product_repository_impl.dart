import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/basket_Model.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product/product_entity.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product/search_product_entity.dart';
import 'package:maintenance_app/src/features/client%20app/domain/repositories/product/product_repository.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/pagination/paginated_response.dart';
import '../../../../../core/pagination/pagination_params.dart';
import '../../data_sources/product/product_data_source.dart';
import '../../model/product/discount_model.dart';
import '../../model/product/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<ProductModel>>> getProductsByCategory(
      PaginationParams paginationParams) async {
    try {
      final response =
          await remoteDataSource.getProductByCategory(paginationParams);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createFavorite(
      PaginationParams paginationParams) async {
    try {
      final response = await remoteDataSource.createFavorite(paginationParams);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFavorite(
      PaginationParams paginationParams) async {
    try {
      final response = await remoteDataSource.deleteFavorite(paginationParams);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAllFavorite() async {
    try {
      final response = await remoteDataSource.deleteAllFavorite();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DiscountModel>>> getDiscounts(
      PaginationParams paginationParams) async {
    try {
      final response = await remoteDataSource.getDiscounts(paginationParams);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createOrder(
    Map<String, Product> cartItems, {
    required int? region,
    required int? city,
    required int? village,
    required String addressLine1,
    required String addressLine2,
  }) async {
    try {
      final response = await remoteDataSource.createOrder(cartItems,
          region: region,
          city: city,
          village: village,
          addressLine1: addressLine1,
          addressLine2: addressLine2);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaginatedResponse<SearchProductEntity>>>
      getSearchProduct(PaginationParams paginationParams) async {
    try {
      final response =
          await remoteDataSource.getSearchProduct(paginationParams);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createSearch(String searchText) async {
    try {
      final response = await remoteDataSource.createSearch(searchText);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
