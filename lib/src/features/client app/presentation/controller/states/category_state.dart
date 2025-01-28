import 'package:equatable/equatable.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product/product_color.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product/product_entity.dart';

import '../../../domain/entities/category/category_entity.dart';

enum MainCategoryStatus { initial, loading, success, failure }
enum OrderStatus { initial, loading, success, failure }

enum SubCategoryStatus { initial, loading, success, failure }

enum ProductStatus { initial, loading, success, failure }

class CategoryState extends Equatable {
  final MainCategoryStatus mainCategoryStatus;
  final SubCategoryStatus subCategoryStatus;
  final OrderStatus orderStatus;
  final ProductStatus productStatus;
  final ProductColorEntity? productColor;
  final List<Category> categories;
  final List<Product> favouriteProducts;
  final List<Category> subCategories;
  final List<Product> products;
  final bool hasCategoryReachedMax;
  int categoryCurrentPage;
  int selectedCategoryId;
  int productCurrentPage;
  int? selectedIndex;
  final String? errorMessage;
  Map<String, Product> cartItems;
  double? totalAmount = 0;
  // bool isColorSelected;

  CategoryState({
    this.mainCategoryStatus = MainCategoryStatus.initial,
    this.productStatus = ProductStatus.initial,
    this.orderStatus = OrderStatus.initial,
    this.subCategoryStatus = SubCategoryStatus.initial,
    this.categories = const <Category>[],
    this.products = const <Product>[],
    this.favouriteProducts = const <Product>[],
    this.subCategories = const <Category>[],
    this.hasCategoryReachedMax = false,
    this.productColor,
    this.selectedIndex,
    this.categoryCurrentPage = 1,
    this.productCurrentPage = 1,
    this.selectedCategoryId = 0,
    this.errorMessage,
    required this.cartItems,
    this.totalAmount = 0,
  });

  CategoryState copyWith({
    MainCategoryStatus? mainCategoryStatus,
    SubCategoryStatus? subCategoryStatus,
    OrderStatus?orderStatus,
    ProductStatus? productStatus,
    ProductColorEntity? productColor,

    List<Category>? categories,
    List<Category>? subCategories,
    List<Product>? products,
    List<Product>? favouriteProducts,
    bool? hasCategoryReachedMax,
    int? selectedIndex,
    int? categoryCurrentPage,
    int? productCurrentPage,
    int? selectedCategoryId,
    String? errorMessage,
    Map<String, Product>? cartItems,
    double? totalAmount,
  }) {
    return CategoryState(
      mainCategoryStatus: mainCategoryStatus ?? this.mainCategoryStatus,
      subCategoryStatus: subCategoryStatus ?? this.subCategoryStatus,
      orderStatus: orderStatus ?? this.orderStatus,
      productStatus: productStatus ?? this.productStatus,
      categories: categories ?? this.categories,
      products: products ?? this.products,
      productColor: productColor ?? this.productColor,
      favouriteProducts: favouriteProducts ?? this.favouriteProducts,
      subCategories: subCategories ?? this.subCategories,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      hasCategoryReachedMax:
          hasCategoryReachedMax ?? this.hasCategoryReachedMax,
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
    orderStatus,
        categories,
    productColor,
        products,
    favouriteProducts,
        subCategories,
        hasCategoryReachedMax,
        categoryCurrentPage,
    selectedIndex,
        productCurrentPage,
        errorMessage,
        cartItems,
        selectedCategoryId,
        totalAmount,
      ];
}
