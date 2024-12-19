

import 'package:equatable/equatable.dart';

import '../../../domain/entities/category/category_entity.dart';

enum MainCategoryStatus { initial, loading, success, failure }
enum SubCategoryStatus { initial, loading, success, failure }

class CategoryState extends Equatable {
  final MainCategoryStatus mainCategoryStatus;
  final SubCategoryStatus subCategoryStatus;
  final List<Category> categories;
  final List<Category> subCategories;
  final bool hasCategoryReachedMax;
  int categoryCurrentPage;
  final String? errorMessage;

  CategoryState({

    this.mainCategoryStatus = MainCategoryStatus.initial,
    this.subCategoryStatus = SubCategoryStatus.initial,
    this.categories = const <Category>[],
    this.subCategories = const <Category>[],
    this.hasCategoryReachedMax = false,
    this.categoryCurrentPage = 1,
    this.errorMessage,
  });

  CategoryState copyWith({
    MainCategoryStatus? mainCategoryStatus,
    SubCategoryStatus? subCategoryStatus,
    List<Category>? categories,
    List<Category>? subCategories,
    bool? hasCategoryReachedMax,
    int? categoryCurrentPage,
    String? errorMessage,
  }) {
    return CategoryState(
      mainCategoryStatus: mainCategoryStatus ?? this.mainCategoryStatus,
      subCategoryStatus: subCategoryStatus ?? this.subCategoryStatus,

      categories: categories ?? this.categories,
      subCategories: subCategories ?? this.subCategories,
      hasCategoryReachedMax: hasCategoryReachedMax ?? this.hasCategoryReachedMax,
      categoryCurrentPage: categoryCurrentPage ?? this.categoryCurrentPage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    mainCategoryStatus,
    subCategoryStatus,
    categories,
    subCategories,
    hasCategoryReachedMax,
    categoryCurrentPage,
    errorMessage,
  ];
}