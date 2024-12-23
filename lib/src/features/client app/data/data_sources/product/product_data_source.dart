import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjNhMTViMTIwLTZhYzktNDk1My1iY2M4LTY0YzA1NWEzMDZlOCIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJodXNzZW5AZ21haWwuY29tIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoiaHVzc2VuQGdtYWlsLmNvbSIsImV4cCI6MTczNTcyNTE0MiwiaXNzIjoiRGV2ZWxvcGVyc0F1dGgiLCJhdWQiOiJEZXZlbG9wZXJzQXV0aCJ9.AGC8wR6KR42gya208w5BMgsSLrdZOp0ZcrO7ufZAsDU'
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
}
