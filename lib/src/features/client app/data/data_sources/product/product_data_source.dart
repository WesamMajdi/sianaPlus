import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:maintenance_app/main.dart';
import 'package:maintenance_app/src/core/network/global_token.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/product/product_model.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/category_cubit.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/error/handle_http_error.dart';
import '../../../../../core/network/api_controller.dart';
import '../../../../../core/network/base_response.dart';
import '../../../../../core/network/api_setting.dart';
import '../../../../../core/pagination/paginated_response.dart';
import '../../../../../core/pagination/pagination_params.dart';
import '../../../domain/entities/product/product_entity.dart';
import '../../model/category/category_model.dart';
import '../../model/product/discount_model.dart';

class ProductRemoteDataSource {
  final ApiController apiController;
  final InternetConnectionChecker internetConnectionChecker;

  ProductRemoteDataSource(
      {required this.apiController, required this.internetConnectionChecker});

  Future<List<ProductModel>> getProductByCategory(
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
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        final productResponse =
            BaseResponse<List<ProductModel>>.fromJson(
          responseBody,
          (json) {
            if (kDebugMode) {
              print('hussen $json');
            }
            return (json as List)
                .map((item) => ProductModel.fromJson(item))
                .toList();
            //  ProductModel.fromJson(json);
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

  Future<List<DiscountModel>> getDiscounts(PaginationParams paginationParams) async {
    String? token = await TokenManager.getToken();

    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse('${ApiSetting.getDiscount}?page=${paginationParams.page}&perPage=${paginationParams.perPage}'),
          headers: {
            // 'Content-Type': 'application/json',
            'accept': '*/*',
            'Authorization': 'Bearer $token'
          },
        );
        print( Uri.parse('${ApiSetting.getDiscount}?page=${paginationParams.page}&perPage=${paginationParams.perPage}').toString());
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }
        final productResponse =
        BaseResponse<List<DiscountModel>>.fromJson(
          responseBody,
              (json) {


            return (json['data'] as List)
                .map((item) => DiscountModel.fromJson(item))
                .toList();
            //  ProductModel.fromJson(json);
          },
        );
        if (kDebugMode) {
          print(productResponse.data!);
        }
        return productResponse.data!;


      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<void> createOrder(Map<String, Product> cartItems) async {
    String? token = await TokenManager.getToken();

    if (await internetConnectionChecker.hasConnection) {
      try {
/*

{
  "total": 0,
  "discount": 0,
  "orders": [
    {
      "count": 0,
      "discount": 0,
      "price": 0,
      "productColorId": 0
    }
  ]
}
 */
        // if (kDebugMode) {
        //
        //   print(

        //   );
        //
        //
        // }
        final response = await apiController.post(
          Uri.parse(ApiSetting.createOrder),
          headers: {
            'accept': '*/*',
            'Authorization': 'Bearer $token'
          },
          body:{
            'total': NavigationService.navigatorKey.currentContext!.read<CategoryCubit>().state.totalAmount,
            'discount': 0,
            'orders': cartItems.values
                .map(
                  (e) => {
                'count': e.count,
                'discount': e.discount,
                'price': e.price,
                'productColorId': e.selectedColor?.id
              },
            )
                .toList()
          }
        );
        // print( jsonEncode());
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
