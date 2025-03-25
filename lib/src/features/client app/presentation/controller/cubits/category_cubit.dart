import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/region/region_model.dart';
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

    final regionId = state.regionId;
    final cityId = state.cityId;
    final villageId = state.villageId;
    final addressLine1 = state.addressLine1 ?? '';
    final addressLine2 = state.addressLine2 ?? '';

    print('Region: $regionId');
    print('City: $cityId');
    print('Village: $villageId');
    print('Address Line 1: $addressLine1');
    print('Address Line 2: $addressLine2');

    final result = await productsUseCase.createOrder(
      cartItems,
      region: regionId,
      city: cityId,
      village: villageId,
      addressLine1: addressLine1,
      addressLine2: addressLine2,
    );

    result.fold(
      (failure) => emit(state.copyWith(
          orderStatus: OrderStatus.failure, errorMessage: failure.message)),
      (order) =>
          emit(state.copyWith(orderStatus: OrderStatus.success, cartItems: {})),
    );
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
      cartItems: {},
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
    // state.

    final subTotalAmount = updatedItems.values.fold(0.0, (sum, item) {
      return sum + (item.basePrice! * item.userCount!);
    });

    // final totalAmount =
    emit(state.copyWith(
        cartItems: updatedItems, subTotalAmount: subTotalAmount));
  }

  void increaseQuantity(String productId) {
    final updatedItems = List<Product>.from(state.products);

    int productIndex = updatedItems
        .indexWhere((element) => element.id.toString() == productId);

    if (productIndex != -1) {
      updatedItems[productIndex].userCount =
          updatedItems[productIndex].userCount! + 1;
    }

    final subTotalAmount = updatedItems.fold(0.0, (sum, item) {
      return sum + (item.basePrice! * item.userCount!);
    });

    emit(
        state.copyWith(products: updatedItems, subTotalAmount: subTotalAmount));
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

    final subTotalAmount = updatedItems.fold(0.0, (sum, item) {
      return sum + (item.basePrice! * item.userCount!);
    });
    emit(
        state.copyWith(products: updatedItems, subTotalAmount: subTotalAmount));
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

  // Future<void> fetchAllRegion() async {
  //   emit(state.copyWith(regionStatus: RegionStatus.loading));
  //   try {
  //     final result = await categoriesUseCase.getRegion();

  //     result.fold(
  //       (failure) => emit(state.copyWith(
  //         regionStatus: RegionStatus.failure,
  //       )),
  //       (region) => emit(state.copyWith(
  //           regionStatus: RegionStatus.success, listofRegion: region.data)),
  //     );
  //   } catch (e) {
  //     emit(state.copyWith(
  //       orderStatus: OrderStatus.failure,
  //     ));
  //   }
  // }

  Future<void> fetchAllRegion() async {
    emit(state.copyWith(regionStatus: RegionStatus.loading));
    final result = await categoriesUseCase.getRegion();
    result.fold(
      (failure) => emit(state.copyWith(regionStatus: RegionStatus.failure)),
      (region) => emit(state.copyWith(
          regionStatus: RegionStatus.success, listofRegion: region.data!)),
    );
  }

  selectItem(BaseViewModel item) {
    emit(state.copyWith(
      selectedItem: item,
      selectedItemCity: null,
      selectedItemVillage: null,
      listOfCity: [],
      listOfVillage: [],
      regionStatus: RegionStatus.initial,
    ));
    fetchAllCity(item.id);
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

  selectItemCity(BaseViewModel item) {
    emit(state.copyWith(
      selectedItemCity: item,
      selectedItemVillage: null,
      listOfVillage: [],
      regionStatus: RegionStatus.initial,
    ));
    fetchAllVillage(item.id);
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
}
