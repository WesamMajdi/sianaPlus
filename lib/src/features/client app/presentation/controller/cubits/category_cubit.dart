import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintenance_app/main.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/region/region_model.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product/discount_entity.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product/product_color.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product/product_entity.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product/search_product_entity.dart';
import 'package:maintenance_app/src/features/client%20app/domain/usecases/product/fetch_product_useCase.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/order_cubit.dart';

import '../../../../../core/pagination/pagination_params.dart';
import '../../../domain/usecases/category/fetch_categories_useCase.dart';
import '../states/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoriesUseCase categoriesUseCase;
  final ProductsUseCase productsUseCase;

  List<Product> cart = [];

  CategoryCubit(this.categoriesUseCase, this.productsUseCase)
      : super(CategoryState(
          cartItems: {},
        ));

  Future<void> fetchCategories({bool refresh = false}) async {
    emit(state.copyWith(mainCategoryStatus: MainCategoryStatus.loading));
    final page = refresh ? 1 : state.categoryCurrentPage;
    final result =
        await categoriesUseCase.getMainCategory(PaginationParams(page: page));
    result.fold(
        (failure) => emit(state.copyWith(
            mainCategoryStatus: MainCategoryStatus.failure,
            errorMessage: failure.message)), (categories) {
      if (categories.items.isEmpty) {
        selectCategory(categoryId: categories.items.first.id);
        fetchSubCategories(mainCategoryId: categories.items.first.id);
      }

      emit(state.copyWith(
          mainCategoryStatus: MainCategoryStatus.success,
          categories: categories.items));
    });
  }

  void selectProductColor({
    required int index,
    required ProductColorEntity productColor,
    required int productId,
  }) async {
    final updatedProducts = List<Product>.from(state.products);
    final updatedUsedProducts = List<Product>.from(state.usedProductList);
    final updatedSpareParts = List<Product>.from(state.sparePartsList);

    Product? currentProduct;

    final indexInProducts =
        updatedProducts.indexWhere((p) => p.id == productId);
    if (indexInProducts != -1) {
      updatedProducts[indexInProducts].selectedColor = productColor;
      currentProduct = updatedProducts[indexInProducts];
    }

    final indexInUsed =
        updatedUsedProducts.indexWhere((p) => p.id == productId);
    if (indexInUsed != -1) {
      updatedUsedProducts[indexInUsed].selectedColor = productColor;
      currentProduct ??= updatedUsedProducts[indexInUsed];
    }

    final indexInSpare = updatedSpareParts.indexWhere((p) => p.id == productId);
    if (indexInSpare != -1) {
      updatedSpareParts[indexInSpare].selectedColor = productColor;
      currentProduct ??= updatedSpareParts[indexInSpare];
    }

    emit(state.copyWith(
      selectedIndex: index,
      productColor: productColor,
      products: updatedProducts,
      usedProductList: updatedUsedProducts,
      sparePartsList: updatedSpareParts,
      currentProduct: currentProduct,
    ));
  }

  void resetSelectedIndex() {
    emit(state.copyWith(selectedIndex: -1));
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

  Future<int?> getNewOrderId() async {
    emit(state.copyWith(orderStatus: OrderStatus.loading));

    try {
      final result = await categoriesUseCase.getNewOrderId();
      return result.fold(
        (failure) {
          emit(state.copyWith(orderStatus: OrderStatus.failure));
          return null;
        },
        (orderId) {
          print("OrderId from API: $orderId");
          emit(state.copyWith(
            orderStatus: OrderStatus.success,
            newOrderId: orderId,
          ));
          return orderId;
        },
      );
    } catch (e) {
      emit(state.copyWith(orderStatus: OrderStatus.failure));
      print('Error: $e');
      return null;
    }
  }

  void resetOrderStatus() {
    emit(state.copyWith(orderStatus: OrderStatus.initial));
  }

  Future<void> createOrder(double? totalAmount) async {
    emit(state.copyWith(orderStatus: OrderStatus.loading));
    final regionId = state.regionId;
    final cityId = state.cityId;
    final villageId = state.villageId;
    Map<String, Product> cartItems = state.cartItems;
    final addressLine1 = state.addressLine1 ?? '';
    final addressLine2 = state.addressLine2 ?? '';
    int? orderId = state.newOrderId;
    if (orderId == null || orderId == 0) {
      orderId = await getNewOrderId();
    }

    if (orderId == null) {
      emit(state.copyWith(orderStatus: OrderStatus.failure));
      return;
    }
    final result = await productsUseCase.createOrder(cartItems,
        region: regionId,
        city: cityId,
        village: villageId,
        addressLine1: addressLine1,
        addressLine2: addressLine2,
        orderId: orderId,
        totalAmount: totalAmount!);

    result.fold(
        (failure) => emit(state.copyWith(
            orderStatus: OrderStatus.failure,
            errorMessage: failure.message)), (order) async {
      emit(state.copyWith(
        orderStatus: OrderStatus.success,
        cartItems: {},
        totalAmount: 0,
        subTotalAmount: 0,
      ));
      await Future.delayed(Duration.zero);
      resetOrderStatus();
    });
  }

  void updateCheckoutData({
    required int? region,
    required int? city,
    required int? village,
    required String addressLine1,
    required String addressLine2,
  }) {
    emit(CategoryState(
      listofRegion: state.listofRegion,
      listOfCity: state.listOfCity,
      listOfVillage: state.listOfVillage,
      regionId: region,
      cityId: city,
      villageId: village,
      addressLine1: addressLine1,
      addressLine2: addressLine2,
      cartItems: state.cartItems,
    ));
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

  Future<void> getDiscount() async {
    emit(state.copyWith(discountStatus: DiscountStatus.loading));
    const page = 1;
    final result = await productsUseCase
        .getDiscounts(const PaginationParams(page: page, perPage: 10));
    result.fold(
      (failure) => emit(state.copyWith(
          discountStatus: DiscountStatus.failure,
          errorMessage: failure.message)),
      (discounts) {
        return emit(state.copyWith(
            discountStatus: DiscountStatus.success, discounts: discounts));
      },
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
    print(productItem.basePrice);
    if (updatedItems.containsKey(productItem.id.toString())) {
      updatedItems.update(
        productItem.id.toString(),
        (existingItem) {
          existingItem.userCount =
              existingItem.userCount! + productItem.userCount!;
          return existingItem;
        },
      );
    } else {
      updatedItems.putIfAbsent(
        productItem.id.toString(),
        () => productItem,
      );
    }
    final subTotalAmount = updatedItems.values.fold(0.0, (sum, item) {
      return sum + (item.basePrice! * item.userCount!);
    });

    emit(state.copyWith(
      cartItems: updatedItems,
      subTotalAmount: subTotalAmount,
    ));
  }

  void increaseQuantity(String productId) {
    final updatedItems = Map<String, Product>.from(state.cartItems);

    if (updatedItems.containsKey(productId)) {
      updatedItems[productId]!.userCount =
          updatedItems[productId]!.userCount! + 1;

      final subTotalAmount = updatedItems.values.fold(0.0, (sum, item) {
        return sum + (item.basePrice! * item.userCount!);
      });

      // تحديث الحالة
      emit(state.copyWith(
        cartItems: updatedItems,
        subTotalAmount: subTotalAmount,
      ));
    }
  }

  void decreaseQuantity(String productId) {
    final updatedItems = Map<String, Product>.from(state.cartItems);

    if (updatedItems.containsKey(productId)) {
      if (updatedItems[productId]!.userCount! > 1) {
        // تقليل الكمية
        updatedItems[productId]!.userCount =
            updatedItems[productId]!.userCount! - 1;

        // حساب المجموع الفرعي لجميع العناصر في السلة
        final subTotalAmount = updatedItems.values.fold(0.0, (sum, item) {
          return sum + (item.basePrice! * item.userCount!);
        });

        // تحديث الحالة
        emit(state.copyWith(
          cartItems: updatedItems,
          subTotalAmount: subTotalAmount,
        ));
      }
    }
  }

  void removeItem(String productId) {
    final updatedCart = Map<String, Product>.from(state.cartItems);
    print(productId);

    updatedCart.remove(productId);

    if (updatedCart.isEmpty) {
      emit(state.copyWith(
        cartItems: updatedCart,
        subTotalAmount: 0,
        totalAmount: 0,
        discounts: [],
      ));
    } else {
      final newSubTotal = updatedCart.values.fold(
        0.0,
        (total, product) => total + product.price,
      );
      print(newSubTotal);

      emit(state.copyWith(
        cartItems: updatedCart,
        subTotalAmount: newSubTotal,
        discounts: state.discounts,
      ));
    }
    print(state.subTotalAmount);
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
        if (!favouriteList.contains(updatedItems[productIndex])) {
          favouriteList.add(updatedItems[productIndex]);
        }
      } else {
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
    emit(state.copyWith(
        cartItems: {}, subTotalAmount: 0, totalAmount: 0, discounts: []));
  }

  Future<void> fetchAllRegion() async {
    emit(state.copyWith(regionStatus: RegionStatus.loading));
    final result = await categoriesUseCase.getRegion();
    result.fold(
      (failure) => emit(state.copyWith(regionStatus: RegionStatus.failure)),
      (region) => emit(state.copyWith(
          regionStatus: RegionStatus.success, listofRegion: region.data!)),
    );
  }

  void selectItem(BaseViewModel selected) {
    emit(state.copyWith(
      selectedItem: selected,
      selectedItemCity: null,
      selectedItemVillage: null,
      listOfCity: null,
      listOfVillage: null,
    ));
    fetchAllCity(selected.id);
  }

  Future<void> fetchAllCity(int regionId) async {
    emit(state.copyWith(regionStatus: RegionStatus.loading));
    final result = await categoriesUseCase.getCity(regionId);
    result.fold(
      (failure) => emit(state.copyWith(regionStatus: RegionStatus.failure)),
      (city) => emit(state.copyWith(
          regionStatus: RegionStatus.success, listOfCity: city.data!)),
    );
  }

  void selectItemCity(BaseViewModel selected) {
    emit(state.copyWith(
      selectedItemCity: selected,
      selectedItemVillage: null,
      listOfVillage: null,
    ));
    fetchAllVillage(selected.id);
  }

  Future<void> fetchAllVillage(int cityId) async {
    emit(state.copyWith(regionStatus: RegionStatus.loading));
    final result = await categoriesUseCase.getVillage(cityId);
    result.fold(
      (failure) => emit(state.copyWith(regionStatus: RegionStatus.failure)),
      (village) => emit(state.copyWith(
          regionStatus: RegionStatus.success, listOfVillage: village.data!)),
    );
  }

  selectItemVillage(BaseViewModel item) {
    emit(state.copyWith(
      selectedItemVillage: item,
      regionStatus: RegionStatus.initial,
    ));
  }

  Future<void> getSearchProduct({bool refresh = false}) async {
    emit(state.copyWith(searchProductStatus: SearchProductStatus.loading));
    final result = await productsUseCase
        .getSearchProduct(const PaginationParams(page: 1, perPage: 5));
    result.fold(
      (failure) => emit(state.copyWith(
          searchProductStatus: SearchProductStatus.failure,
          errorMessage: failure.message)),
      (p) => emit(state.copyWith(
          searchProductStatus: SearchProductStatus.success,
          listOfSearch: p.items)),
    );
  }

  Future<void> getSubCategory({bool refresh = false}) async {
    emit(state.copyWith(searchProductStatus: SearchProductStatus.loading));
    final result = await productsUseCase
        .getSubCategory(const PaginationParams(page: 1, perPage: 5));
    result.fold(
      (failure) => emit(state.copyWith(
          searchProductStatus: SearchProductStatus.failure,
          errorMessage: failure.message)),
      (p) => emit(state.copyWith(
          searchProductStatus: SearchProductStatus.success,
          listOfSearchCategory: p.items)),
    );
  }

  Future<void> createSearch(BuildContext context, String searchText) async {
    emit(state.copyWith(searchProductStatus: SearchProductStatus.loading));

    final result = await productsUseCase.createSearch(searchText);

    result.fold(
      (failure) => emit(
          state.copyWith(searchProductStatus: SearchProductStatus.failure)),
      (_) {
        context.read<CategoryCubit>().getSearchProduct(refresh: true);
        emit(state.copyWith(
          searchProductStatus: SearchProductStatus.success,
          listOfSearch: [],
        ));
      },
    );
  }

  void deleteSearchProduct(SearchProductEntity product) {
    List<SearchProductEntity> updatedList = List.from(state.listOfSearch)
      ..removeWhere((item) => item.id == product.id);

    emit(state.copyWith(listOfSearch: updatedList));
  }

  Future<void> fetchHomePage({
    bool refresh = false,
    String searchQuery = '',
    String barcode = '',
  }) async {
    emit(state.copyWith(homePageStatus: HomePageStatus.loading));

    try {
      final result = await productsUseCase.getHomePage();

      result.fold(
        (failure) => emit(state.copyWith(
          homePageStatus: HomePageStatus.failure,
          errorMessage: failure.message,
        )),
        (homeModel) {
          emit(state.copyWith(
            homePageStatus: HomePageStatus.success,
            imageList: homeModel.images.items,
            usedProductList: homeModel.usedProduct,
            sparePartsList: homeModel.spareParts,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        homePageStatus: HomePageStatus.failure,
        errorMessage: 'Unexpected error: $e',
      ));
    }
  }
}
