import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/error/handle_http_error.dart';
import '../../../../../core/network/api_controller.dart';
import '../../../../../core/network/base_response.dart';
import '../../../../../core/network/api_setting.dart';
import '../../../../../core/pagination/paginated_response.dart';
import '../../../../../core/pagination/pagination_params.dart';
import '../../model/category/category_model.dart';


class CategoryRemoteDataSource {
  final ApiController apiController;
  final InternetConnectionChecker internetConnectionChecker;


  CategoryRemoteDataSource({required this.apiController,required this.internetConnectionChecker});


  Future<PaginatedResponse<CategoryModel>> getMainCategory(PaginationParams paginationParams) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse('${ApiSetting.getMainCategory}?page=${paginationParams.page}&perPage=${paginationParams.perPage}'),
          headers: {
            'Content-Type': 'application/json',
          },
        );
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if(response.statusCode>=400){
          HandleHttpError.handleHttpError(responseBody);
        }

        final categoryResponse = BaseResponse<PaginatedResponse<CategoryModel>>.fromJson(
          responseBody,
              (json) {
            return  PaginatedResponse<CategoryModel>.fromJson(
              json,(p0) {
              return CategoryModel.fromJson(p0);
            },
            );
          },
        );
        return categoryResponse.data!;


      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }


  Future<PaginatedResponse<CategoryModel>> getSubCategories(PaginationParams paginationParams) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse('${ApiSetting.getSubCategory}?mainCategoryId=${paginationParams.mainCategoryId}&page=${paginationParams.page}&perPage=${paginationParams.perPage}'),
          headers: {
            'Content-Type': 'application/json',
          },
        );
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        debugPrint(responseBody.toString());
        if(response.statusCode>=400){
          HandleHttpError.handleHttpError(responseBody);
        }

        final categoryResponse = BaseResponse<PaginatedResponse<CategoryModel>>.fromJson(
          responseBody,
              (json) {
            return  PaginatedResponse<CategoryModel>.fromJson(
              json,(p0) {
              return CategoryModel.fromJson(p0);
            },
            );
          },
        );
        return categoryResponse.data!;


      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }


}