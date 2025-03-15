import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product/product_color.dart';
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

  void selectProductColor(
      {required int index,
      required ProductColorEntity productColor,
      required int productId}) async {
    final updatedItems = List<Product>.from(state.products);

    int productIndex =
        updatedItems.indexWhere((element) => element.id == productId);

    if (productIndex != -1) {
      updatedItems[productIndex].selectedColor = productColor;
    }
    emit(state.copyWith(selectedIndex: index, productColor: productColor));
  }

  Future<void> fetchSubCategories(
      {bool refresh = false, int mainCategoryId = 0}) async {
    emit(state.copyWith(
        subCategoryStatus: SubCategoryStatus.loading,
        selectedCategoryId: mainCategoryId));
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

  Future<void> createOrder(Map<String, Product> cartItems) async {
    emit(state.copyWith(orderStatus: OrderStatus.loading));
    final result = await productsUseCase.createOrder(cartItems);
    result.fold(
      (failure) => emit(state.copyWith(
          orderStatus: OrderStatus.failure, errorMessage: failure.message)),
      (order) =>
          emit(state.copyWith(orderStatus: OrderStatus.success, cartItems: {})),
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
          productStatus: ProductStatus.success, products: products)),
    );
  }

  Future<void> createFavorite({int productId = 0}) async {
    final updatedItems = List<Product>.from(state.products);
    final favouriteList = List<Product>.from(state.favouriteProducts);

    int productIndex =
        updatedItems.indexWhere((element) => element.id == productId);

    if (productIndex != -1) {
      updatedItems[productIndex].isFavorite =
          !updatedItems[productIndex].isFavorite!;
      if (updatedItems[productIndex].isFavorite!) {
        if (!favouriteList.any((item) => item.id == productId)) {
          favouriteList.add(updatedItems[productIndex]);

          emit(state.copyWith(
              products: updatedItems, favouriteProducts: favouriteList));

          await productsUseCase
              .createFavorite(PaginationParams(page: 0, productId: productId));
        }
      } else {
        favouriteList.removeWhere((item) => item.id == productId);
        emit(state.copyWith(
            products: updatedItems, favouriteProducts: favouriteList));

        await productsUseCase
            .deleteFavorite(PaginationParams(page: 0, productId: productId));
      }
    }
  }

  Future<void> deleteAllFavorite() async {
    emit(state.copyWith(favouriteProducts: []));
    await productsUseCase.deleteAllFavorite();
  }

  void getProductFavorite() async {
    final products = List<Product>.from(state.products);
    final favouriteProducts = List<Product>.from(state.favouriteProducts);

    products.map(
      (e) {
        if (e.isFavorite!) {
          favouriteProducts.add(e);
        }
      },
    );

    emit(state.copyWith(favouriteProducts: favouriteProducts));
  }

  selectCategory({required int categoryId}) {
    emit(state.copyWith(selectedCategoryId: categoryId));
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
      updatedItems[productIndex].userCount = updatedItems[productIndex].userCount! + 1;
    }

    final totalAmount = updatedItems.fold(0.0, (sum, item) {
      return sum + (item.price! * item.userCount!);
    });
    print(totalAmount);
    emit(state.copyWith(products: updatedItems, totalAmount: totalAmount));
  }

  void decreaseQuantity(String productId) {
    final updatedItems = List<Product>.from(state.products);

    int productIndex = updatedItems
        .indexWhere((element) => element.id.toString() == productId);

    if (productIndex != -1) {
      if (updatedItems[productIndex].userCount! != 0) {
        updatedItems[productIndex].userCount =
            updatedItems[productIndex].userCount! - 1;
      }
    }

    final totalAmount = updatedItems.fold(0.0, (sum, item) {
      return sum + (item.price! * item.userCount!);
    });
    emit(state.copyWith(products: updatedItems, totalAmount: totalAmount));
  }

  void removeItem(String productId) {
    final updatedItems = Map<String, Product>.from(state.cartItems!);
    updatedItems.remove(productId);

    final totalAmount = updatedItems.values
        .fold(0.0, (sum, item) => sum + (item.price! * item.count!));

    emit(state.copyWith(cartItems: updatedItems, totalAmount: totalAmount));
  }

  void toggleFavorite(int productId) {
    final updatedItems = List<Product>.from(state.products);
    final favouriteList = List<Product>.from(state.favouriteProducts);

    int productIndex =
        updatedItems.indexWhere((element) => element.id == productId);

    if (productIndex != -1) {
      updatedItems[productIndex].isFavorite =
          !updatedItems[productIndex].isFavorite!;
      if (updatedItems[productIndex].isFavorite!) {
        // Add only if it's marked as favorite
        if (!favouriteList.contains(updatedItems[productIndex])) {
          favouriteList.add(updatedItems[productIndex]);
        }
      } else {
        // Remove if it's unmarked as favorite
        favouriteList.removeWhere((item) => item.id == productId);
      }
    }

    emit(state.copyWith(
        products: updatedItems, favouriteProducts: favouriteList));
  }

  void deleteItemFromFavourite(int productId) async {
    final updatedItems = List<Product>.from(state.favouriteProducts);

    updatedItems.removeWhere((element) => element.id == productId);

    emit(state.copyWith(favouriteProducts: updatedItems));
    await createFavorite(productId: productId);
  }

  void clearCart() {
    emit(state.copyWith(cartItems: {}, totalAmount: 0.0));
  }
}
