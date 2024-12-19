import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/pagination/pagination_params.dart';
import '../../../domain/usecases/category/fetch_categories_useCase.dart';
import '../states/category_state.dart';




class CategoryCubit extends Cubit<CategoryState> {
  final CategoriesUseCase categoriesUseCase;

  CategoryCubit(this.categoriesUseCase) : super(CategoryState());

  Future<void> fetchCategories({bool refresh = false}) async {
    emit(state.copyWith(mainCategoryStatus: MainCategoryStatus.loading));
    final page = refresh ? 1 : state.categoryCurrentPage;
    final result = await categoriesUseCase.getMainCategory(PaginationParams(page: page));
    result.fold(
          (failure) =>emit(state.copyWith(mainCategoryStatus: MainCategoryStatus.failure,errorMessage: failure.message)),
          (categories) =>emit(state.copyWith(mainCategoryStatus: MainCategoryStatus.success,categories:categories.items)),
    );
  }

  Future<void> fetchSubCategories({bool refresh = false,int mainCategoryId=0}) async {
    emit(state.copyWith(subCategoryStatus: SubCategoryStatus.loading));
    final page = refresh ? 1 : state.categoryCurrentPage;
    final result = await categoriesUseCase.getSubCategories(PaginationParams(page: page,mainCategoryId: mainCategoryId));
    result.fold(
          (failure) =>emit(state.copyWith(subCategoryStatus: SubCategoryStatus.failure,errorMessage: failure.message)),
          (categories) =>emit(state.copyWith(subCategoryStatus: SubCategoryStatus.success,subCategories:categories.items)),
    );
  }
}
