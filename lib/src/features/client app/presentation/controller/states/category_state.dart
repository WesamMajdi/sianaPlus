

import 'package:equatable/equatable.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product_entity.dart';

import '../../../domain/entities/category/category_entity.dart';

enum MainCategoryStatus { initial, loading, success, failure }
enum SubCategoryStatus { initial, loading, success, failure }
enum ProductStatus { initial, loading, success, failure }

class CategoryState extends Equatable {
  final MainCategoryStatus mainCategoryStatus;
  final SubCategoryStatus subCategoryStatus;
  final ProductStatus productStatus;
  final List<Category> categories;
  final List<Category> subCategories;
  final List<Product> products;
  final bool hasCategoryReachedMax;
  int categoryCurrentPage;
  int productCurrentPage;
  final String? errorMessage;
   Map<String, Product> cartItems;
  final double? totalAmount;

  CategoryState({

    this.mainCategoryStatus = MainCategoryStatus.initial,
    this.productStatus = ProductStatus.initial,
    this.subCategoryStatus = SubCategoryStatus.initial,
    this.categories = const <Category>[],
    this.products = const <Product>[],
    this.subCategories = const <Category>[],
    this.hasCategoryReachedMax = false,
    this.categoryCurrentPage = 1,
    this.productCurrentPage = 1,
    this.errorMessage,
    required this.cartItems,
    this.totalAmount,
  });

  CategoryState copyWith({
    MainCategoryStatus? mainCategoryStatus,
    SubCategoryStatus? subCategoryStatus,
    ProductStatus? productStatus,
    List<Category>? categories,
    List<Category>? subCategories,
    List<Product>? products,
    bool? hasCategoryReachedMax,
    int? categoryCurrentPage,
    int? productCurrentPage,
    String? errorMessage,
    Map<String, Product>? cartItems,
    double? totalAmount,
  }) {
    return CategoryState(
      mainCategoryStatus: mainCategoryStatus ?? this.mainCategoryStatus,
      subCategoryStatus: subCategoryStatus ?? this.subCategoryStatus,
      productStatus: productStatus ?? this.productStatus,

      categories: categories ?? this.categories,
      products: products ?? this.products,
      subCategories: subCategories ?? this.subCategories,
      hasCategoryReachedMax: hasCategoryReachedMax ?? this.hasCategoryReachedMax,
      categoryCurrentPage: categoryCurrentPage ?? this.categoryCurrentPage,
      productCurrentPage: productCurrentPage ?? this.productCurrentPage,
      errorMessage: errorMessage ?? this.errorMessage,
      cartItems: cartItems ?? this.cartItems,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  @override
  List<Object?> get props => [
    mainCategoryStatus,
    subCategoryStatus,
    productStatus,
    categories,
    products,
    subCategories,
    hasCategoryReachedMax,
    categoryCurrentPage,
    productCurrentPage,
    errorMessage,
    cartItems,
    totalAmount,
  ];
}