import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:maintenance_app/src/core/network/global_token.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/product/product_model.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/error/handle_http_error.dart';
import '../../../../../core/network/api_controller.dart';
import '../../../../../core/network/base_response.dart';
import '../../../../../core/network/api_setting.dart';
import '../../../../../core/pagination/paginated_response.dart';
import '../../../../../core/pagination/pagination_params.dart';
import '../../model/category/category_model.dart';

class ProductRemoteDataSource {
  final ApiController apiController;
  final InternetConnectionChecker internetConnectionChecker;

  ProductRemoteDataSource(
      {required this.apiController, required this.internetConnectionChecker});

  Future<PaginatedResponse<ProductModel>> getProductByCategory(
      PaginationParams paginationParams) async {
    String? token = await TokenManager.getToken();
    debugPrint(Uri.parse(
            '${ApiSetting.getProductByCategory}?categoryId=${paginationParams.mainCategoryId}&page=${paginationParams.page}&perPage=${paginationParams.perPage}')
        .toString());
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getProductByCategory}?categoryId=${paginationParams.mainCategoryId}&page=${paginationParams.page}&perPage=${paginationParams.perPage}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );
        debugPrint(response.statusCode.toString());
        print(response.body.toString());
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        debugPrint(responseBody.toString());
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        final productResponse =
            BaseResponse<PaginatedResponse<ProductModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<ProductModel>.fromJson(
              json,
              (p0) {
                return ProductModel.fromJson(p0);
              },
            );
          },
        );
        return productResponse.data!;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<void> createFavorite(PaginationParams paginationParams) async {
    String? token = await TokenManager.getToken();
    debugPrint(Uri.parse(
            '${ApiSetting.createFavorite}?productId=${paginationParams.productId}')
        .toString());

    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.post(
          Uri.parse(
              '${ApiSetting.createFavorite}?productId=${paginationParams.productId}'),
          headers: {
            // 'Content-Type': 'application/json',
            'accept': '*/*',
            'Authorization': 'Bearer $token'
          },
        );
        debugPrint(response.statusCode.toString());
        print(response.body.toString());
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        debugPrint(responseBody.toString());
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<void> deleteFavorite(PaginationParams paginationParams) async {
    String? token = await TokenManager.getToken();
    debugPrint(Uri.parse(
            '${ApiSetting.deleteFavorite}?productId=${paginationParams.productId}')
        .toString());
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.post(
          Uri.parse(
              '${ApiSetting.deleteFavorite}?productId=${paginationParams.productId}'),
          headers: {
            // 'Content-Type': 'application/json',
            'accept': '*/*',
            'Authorization': 'Bearer $token'
          },
        );
        debugPrint(response.statusCode.toString());
        print(response.body.toString());
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        debugPrint(responseBody.toString());
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<void> deleteAllFavorite() async {
    String? token = await TokenManager.getToken();

    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.post(
          Uri.parse('${ApiSetting.deleteAllFavorite}'),
          headers: {
            // 'Content-Type': 'application/json',
            'accept': '*/*',
            'Authorization': 'Bearer $token'
          },
        );
        debugPrint(response.statusCode.toString());
        print(response.body.toString());
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        debugPrint(responseBody.toString());
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }
}
