// fetch_categories_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/product/product_model.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product/discount_entity.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product/product_entity.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product/search_product_entity.dart';
import 'package:maintenance_app/src/features/client%20app/domain/repositories/product/product_repository.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/pagination/paginated_response.dart';
import '../../../../../core/pagination/pagination_params.dart';
import '../../../data/model/category/category_model.dart';
import '../../entities/category/category_entity.dart';
import '../../repositories/category/category_repository.dart';

class ProductsUseCase {
  final ProductRepository repository;

  ProductsUseCase(this.repository);

  Future<Either<Failure, List<Product>>> getProductsByCategory(
      PaginationParams paginationParams) {
    return repository.getProductsByCategory(paginationParams);
  }

  Future<Either<Failure, List<DiscountEntity>>> getDiscounts(
      PaginationParams paginationParams) {
    return repository.getDiscounts(paginationParams);
  }

  Future<Either<Failure, void>> createFavorite(
      PaginationParams paginationParams) {
    return repository.createFavorite(paginationParams);
  }

  Future<Either<Failure, void>> deleteFavorite(
      PaginationParams paginationParams) {
    return repository.deleteFavorite(paginationParams);
  }

  Future<Either<Failure, void>> deleteAllFavorite() {
    return repository.deleteAllFavorite();
  }

  Future<Either<Failure, void>> createOrder(Map<String, Product> cartItems,
      {required int? region,
      required int? city,
      required int? village,
      required String addressLine1,
      required String addressLine2,
      required int orderId,
      required double totalAmount}) {
    return repository.createOrder(cartItems,
        region: region,
        city: city,
        village: village,
        addressLine1: addressLine1,
        addressLine2: addressLine2,
        orderId: orderId,
        totalAmount: totalAmount);
  }

  Future<Either<Failure, PaginatedResponse<SearchProductEntity>>>
      getSearchProduct(PaginationParams paginationParams) {
    return repository.getSearchProduct(paginationParams);
  }

  Future<Either<Failure, void>> createSearch(String searchText) {
    return repository.createSearch(searchText);
  }

  Future<Either<Failure, PaginatedResponse<SearchCategoryEntity>>>
      getSubCategory(PaginationParams paginationParams) {
    return repository.getSubCategory(paginationParams);
  }
}
