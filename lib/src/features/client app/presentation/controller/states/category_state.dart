import 'package:equatable/equatable.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/region/region_model.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product/discount_entity.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product/product_color.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product/product_entity.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product/search_product_entity.dart';

import '../../../domain/entities/category/category_entity.dart';

enum MainCategoryStatus { initial, loading, success, failure }

enum OrderStatus { initial, loading, success, failure }

enum SubCategoryStatus { initial, loading, success, failure }

enum ProductStatus { initial, loading, success, failure }

enum DiscountStatus { initial, loading, success, failure }

enum RegionStatus { initial, loading, success, failure }

enum SearchProductStatus { initial, loading, success, failure }

class CategoryState extends Equatable {
  final MainCategoryStatus mainCategoryStatus;
  final SearchProductStatus searchProductStatus;
  final RegionStatus regionStatus;
  final BaseViewModel? selectedItem;
  final SubCategoryStatus subCategoryStatus;
  final OrderStatus orderStatus;
  final ProductStatus productStatus;
  final DiscountStatus discountStatus;
  final ProductColorEntity? productColor;
  final List<Category> categories;
  final List<Product> favouriteProducts;
  final List<BaseViewModel> listofRegion;
  final List<BaseViewModel> listOfCity;
  final List<BaseViewModel> listOfVillage;
  final List<SearchProductEntity> listOfSearch;
  final List<Category> subCategories;
  final List<Product> products;
  final List<DiscountEntity> discounts;
  final bool hasCategoryReachedMax;
  int categoryCurrentPage;
  int selectedCategoryId;
  int productCurrentPage;
  int? selectedIndex = 0;
  final String? errorMessage;
  Map<String, Product> cartItems;
  dynamic subTotalAmount = 0;
  double? totalAmount = 0;
  int? cityId = 0;
  int? regionId = 0;
  int? villageId = 0;
  int? newOrderId = 0;
  String? addressLine1;
  String? addressLine2;
  int quantity = 0;
  final BaseViewModel? selectedItemCity;
  final BaseViewModel? selectedItemVillage;
  List<SearchCategoryEntity>? listOfSearchCategory;

  // bool isColorSelected;

  CategoryState(
      {this.mainCategoryStatus = MainCategoryStatus.initial,
      this.productStatus = ProductStatus.initial,
      this.orderStatus = OrderStatus.initial,
      this.subCategoryStatus = SubCategoryStatus.initial,
      this.regionStatus = RegionStatus.initial,
      this.searchProductStatus = SearchProductStatus.initial,
      this.discountStatus = DiscountStatus.initial,
      this.categories = const <Category>[],
      this.products = const <Product>[],
      this.listofRegion = const <BaseViewModel>[],
      this.listOfCity = const <BaseViewModel>[],
      this.listOfVillage = const <BaseViewModel>[],
      this.discounts = const <DiscountEntity>[],
      this.listOfSearch = const <SearchProductEntity>[],
      this.favouriteProducts = const <Product>[],
      this.subCategories = const <Category>[],
      this.listOfSearchCategory = const <SearchCategoryEntity>[],
      this.hasCategoryReachedMax = false,
      this.productColor,
      this.quantity = 0,
      this.selectedIndex = 0,
      this.categoryCurrentPage = 1,
      this.newOrderId = 0,
      this.productCurrentPage = 1,
      this.selectedCategoryId = 0,
      this.errorMessage,
      required this.cartItems,
      this.subTotalAmount = 0,
      this.totalAmount = 0,
      this.selectedItem,
      this.selectedItemCity,
      this.selectedItemVillage,
      this.cityId,
      this.regionId,
      this.villageId,
      this.addressLine1,
      this.addressLine2});
  factory CategoryState.initial({required Map<String, Product> cartItems}) {
    return CategoryState(
      mainCategoryStatus: MainCategoryStatus.initial,
      productStatus: ProductStatus.initial,
      orderStatus: OrderStatus.initial,
      subCategoryStatus: SubCategoryStatus.initial,
      regionStatus: RegionStatus.initial,
      searchProductStatus: SearchProductStatus.initial,
      discountStatus: DiscountStatus.initial,
      categories: const <Category>[],
      products: const <Product>[],
      listofRegion: const <BaseViewModel>[],
      listOfCity: const <BaseViewModel>[],
      listOfSearchCategory: const <SearchCategoryEntity>[],
      listOfVillage: const <BaseViewModel>[],
      discounts: const <DiscountEntity>[],
      listOfSearch: const <SearchProductEntity>[],
      favouriteProducts: const <Product>[],
      subCategories: const <Category>[],
      hasCategoryReachedMax: false,
      productColor: null,
      quantity: 0,
      selectedIndex: 0,
      categoryCurrentPage: 1,
      productCurrentPage: 1,
      selectedCategoryId: 0,
      errorMessage: null,
      cartItems: {},
      subTotalAmount: 0,
      totalAmount: 0,
      newOrderId: 0,
      selectedItem: null,
      selectedItemCity: null,
      selectedItemVillage: null,
      cityId: null,
      regionId: null,
      villageId: null,
      addressLine1: null,
      addressLine2: null,
    );
  }

  CategoryState copyWith(
      {MainCategoryStatus? mainCategoryStatus,
      SubCategoryStatus? subCategoryStatus,
      SearchProductStatus? searchProductStatus,
      OrderStatus? orderStatus,
      ProductStatus? productStatus,
      RegionStatus? regionStatus,
      ProductColorEntity? productColor,
      DiscountStatus? discountStatus,
      List<Category>? categories,
      List<Category>? subCategories,
      List<SearchProductEntity>? listOfSearch,
      List<SearchCategoryEntity>? listOfSearchCategory,
      List<Product>? products,
      List<Product>? favouriteProducts,
      List<BaseViewModel>? listofRegion,
      List<BaseViewModel>? listOfCity,
      List<BaseViewModel>? listOfVillage,
      List<DiscountEntity>? discounts,
      bool? hasCategoryReachedMax,
      int? selectedIndex,
      int? categoryCurrentPage,
      int? productCurrentPage,
      int? quantity,
      int? newOrderId,
      int? selectedCategoryId,
      String? errorMessage,
      Map<String, Product>? cartItems,
      dynamic? subTotalAmount = 0,
      double? totalAmount,
      BaseViewModel? selectedItem,
      BaseViewModel? selectedItemCity,
      BaseViewModel? selectedItemVillage,
      String? cityHint,
      String? villageHint,
      int? cityId,
      int? regionId,
      int? villageId,
      String? addressLine1,
      String? addressLine2}) {
    return CategoryState(
        mainCategoryStatus: mainCategoryStatus ?? this.mainCategoryStatus,
        subCategoryStatus: subCategoryStatus ?? this.subCategoryStatus,
        regionStatus: regionStatus ?? this.regionStatus,
        orderStatus: orderStatus ?? this.orderStatus,
        productStatus: productStatus ?? this.productStatus,
        discountStatus: discountStatus ?? this.discountStatus,
        categories: categories ?? this.categories,
        products: products ?? this.products,
        discounts: discounts ?? this.discounts,
        productColor: productColor ?? this.productColor,
        favouriteProducts: favouriteProducts ?? this.favouriteProducts,
        subCategories: subCategories ?? this.subCategories,
        quantity: quantity ?? this.quantity,
        selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
        selectedIndex: selectedIndex ?? this.selectedIndex,
        hasCategoryReachedMax:
            hasCategoryReachedMax ?? this.hasCategoryReachedMax,
        categoryCurrentPage: categoryCurrentPage ?? this.categoryCurrentPage,
        productCurrentPage: productCurrentPage ?? this.productCurrentPage,
        errorMessage: errorMessage ?? this.errorMessage,
        cartItems: cartItems ?? this.cartItems,
        subTotalAmount: subTotalAmount ?? this.subTotalAmount,
        totalAmount: totalAmount ?? this.totalAmount,
        listofRegion: listofRegion ?? this.listofRegion,
        selectedItem: selectedItem ?? this.selectedItem,
        listOfCity: listOfCity ?? this.listOfCity,
        selectedItemCity: selectedItemCity ?? this.selectedItemCity,
        listOfVillage: listOfVillage ?? this.listOfVillage,
        selectedItemVillage: selectedItemVillage ?? this.selectedItemVillage,
        cityId: cityId ?? this.cityId,
        regionId: regionId ?? this.regionId,
        villageId: villageId ?? this.villageId,
        addressLine1: addressLine1 ?? this.addressLine1,
        addressLine2: addressLine2 ?? this.addressLine2,
        searchProductStatus: searchProductStatus ?? this.searchProductStatus,
        listOfSearchCategory: listOfSearchCategory ?? this.listOfSearchCategory,
        listOfSearch: listOfSearch ?? this.listOfSearch,
        newOrderId: newOrderId ?? this.newOrderId);
  }

  @override
  List<Object?> get props => [
        mainCategoryStatus,
        subCategoryStatus,
        productStatus,
        productStatus,
        discountStatus,
        categories,
        productColor,
        products,
        discounts,
        favouriteProducts,
        subCategories,
        hasCategoryReachedMax,
        categoryCurrentPage,
        selectedIndex,
        productCurrentPage,
        errorMessage,
        cartItems,
        selectedCategoryId,
        subTotalAmount,
        totalAmount,
        regionStatus,
        listofRegion,
        selectedItem,
        listOfCity,
        selectedItemCity,
        listOfVillage,
        selectedItemVillage,
        cityId,
        regionId,
        villageId,
        addressLine1,
        addressLine2,
        listOfSearchCategory,
        listOfSearch,
        newOrderId
      ];
}
