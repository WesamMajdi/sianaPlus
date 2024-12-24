import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product/product_entity.dart';
import 'package:maintenance_app/src/features/client%20app/domain/usecases/product/fetch_product_useCase.dart';

import '../../../../../core/pagination/pagination_params.dart';
import '../../../domain/usecases/category/fetch_categories_useCase.dart';
import '../states/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoriesUseCase categoriesUseCase;
  final ProductsUseCase productsUseCase;
  List<Product> cart = [];

  CategoryCubit(this.categoriesUseCase, this.productsUseCase)
      : super(CategoryState(cartItems: {}));

  Future<void> fetchCategories({bool refresh = false}) async {
    emit(state.copyWith(mainCategoryStatus: MainCategoryStatus.loading));
    final page = refresh ? 1 : state.categoryCurrentPage;
    final result =
        await categoriesUseCase.getMainCategory(PaginationParams(page: page));
    result.fold(
      (failure) => emit(state.copyWith(
          mainCategoryStatus: MainCategoryStatus.failure,
          errorMessage: failure.message)),
      (categories) => emit(state.copyWith(
          mainCategoryStatus: MainCategoryStatus.success,
          categories: categories.items)),
    );
  }

  Future<void> fetchSubCategories(
      {bool refresh = false, int mainCategoryId = 0}) async {
    emit(state.copyWith(subCategoryStatus: SubCategoryStatus.loading));
    final page = refresh ? 1 : state.categoryCurrentPage;
    final result = await categoriesUseCase.getSubCategories(
        PaginationParams(page: page, mainCategoryId: mainCategoryId));
    result.fold(
      (failure) => emit(state.copyWith(
          subCategoryStatus: SubCategoryStatus.failure,
          errorMessage: failure.message)),
      (categories) => emit(state.copyWith(
          subCategoryStatus: SubCategoryStatus.success,
          subCategories: categories.items)),
    );
  }

  Future<void> getProductByCategory(
      {bool refresh = false, int mainCategoryId = 0}) async {
    emit(state.copyWith(productStatus: ProductStatus.loading));
    final page = refresh ? 1 : state.productCurrentPage;
    final result = await productsUseCase.getProductsByCategory(
        PaginationParams(page: page, mainCategoryId: mainCategoryId));
    result.fold(
      (failure) => emit(state.copyWith(
          productStatus: ProductStatus.failure, errorMessage: failure.message)),
      (products) => emit(state.copyWith(
          productStatus: ProductStatus.success, products: products.items)),
    );
  }

  selectCategory({required int categoryId}){
    emit(state.copyWith(selectedCategoryId:categoryId));
  }

  void addProductToCart(Product productItem) {
    final updatedItems = Map<String, Product>.from(state.cartItems);

    if (updatedItems.containsKey(productItem.id.toString())) {
      updatedItems.update(
        productItem.id.toString(),
        (existingItem) => productItem,
      );
    } else {
      updatedItems.putIfAbsent(
        productItem.id.toString(),
        () => productItem,
      );
    }

    final totalAmount = updatedItems.values.fold(0.0, (sum, item) {
      print(item.count);
      return sum + (item.price! * item.count!);
    });
    emit(state.copyWith(cartItems: updatedItems, totalAmount: totalAmount));
  }

  void increaseQuantity(String productId) {
    final updatedItems = List<Product>.from(state.products);

    int productIndex = updatedItems
        .indexWhere((element) => element.id.toString() == productId);

    if (productIndex != -1) {
      updatedItems[productIndex].count = updatedItems[productIndex].count! + 1;
    }

    final totalAmount = updatedItems.fold(0.0, (sum, item) {
      return sum + (item.price! * item.count!);
    });
    print(totalAmount);
    emit(state.copyWith(products: updatedItems, totalAmount: totalAmount));
  }

  void decreaseQuantity(String productId) {
    final updatedItems = List<Product>.from(state.products);

    int productIndex = updatedItems
        .indexWhere((element) => element.id.toString() == productId);

    if (productIndex != -1) {
      if (updatedItems[productIndex].count! != 0) {
        updatedItems[productIndex].count =
            updatedItems[productIndex].count! - 1;
      }
    }

    final totalAmount = updatedItems.fold(0.0, (sum, item) {
      return sum + (item.price! * item.count!);
    });
    print(totalAmount);
    emit(state.copyWith(products: updatedItems, totalAmount: totalAmount));
  }

  void removeItem(String productId) {
    final updatedItems = Map<String, Product>.from(state.cartItems!);
    updatedItems.remove(productId);

    final totalAmount = updatedItems.values
        .fold(0.0, (sum, item) => sum + (item.price! * item.count!));

    emit(state.copyWith(cartItems: updatedItems, totalAmount: totalAmount));
  }

  void clearCart() {
    emit(state.copyWith(cartItems: {}, totalAmount: 0.0));
  }
}
