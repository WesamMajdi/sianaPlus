import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:maintenance_app/src/core/network/global_token.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/region/region_model.dart';
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

  CategoryRemoteDataSource(
      {required this.apiController, required this.internetConnectionChecker});

  Future<PaginatedResponse<CategoryModel>> getMainCategory(
      PaginationParams paginationParams) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getMainCategory}?page=${paginationParams.page}&perPage=${paginationParams.perPage}'),
          headers: {
            'Content-Type': 'application/json',
          },
        );
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        final categoryResponse =
            BaseResponse<PaginatedResponse<CategoryModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<CategoryModel>.fromJson(
              json,
              (p0) {
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
      throw OfflineException(errorMessage: 'لا يوجد انترنت');
    }
  }

  Future<PaginatedResponse<CategoryModel>> getSubCategories(
      PaginationParams paginationParams) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getSubCategory}?mainCategoryId=${paginationParams.mainCategoryId}&page=${paginationParams.page}&perPage=${paginationParams.perPage}'),
          headers: {
            'Content-Type': 'application/json',
          },
        );
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        debugPrint(responseBody.toString());
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        final categoryResponse =
            BaseResponse<PaginatedResponse<CategoryModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<CategoryModel>.fromJson(
              json,
              (p0) {
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
      throw OfflineException(errorMessage: 'لا يوجد انترنت');
    }
  }

  Future<BaseResponse<List<BaseViewModel>>> getRegion() async {
    String? token = await TokenManager.getToken();
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(ApiSetting.getRegion),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );
        debugPrint(response.statusCode.toString());
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        debugPrint(responseBody.toString());
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        final regionResponse = BaseResponse<List<BaseViewModel>>.fromJson(
          responseBody,
          (json) {
            return (json as List)
                .map((item) =>
                    BaseViewModel.fromJson(item as Map<String, dynamic>))
                .toList();
          },
        );
        return regionResponse;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'لا يوجد انترنت');
    }
  }

  Future<BaseResponse<List<BaseViewModel>>> getCity(int regionId) async {
    String? token = await TokenManager.getToken();
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse('${ApiSetting.getCity}?regionId=$regionId'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );
        debugPrint(response.statusCode.toString());
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        debugPrint(responseBody.toString());
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        final cityResponse = BaseResponse<List<BaseViewModel>>.fromJson(
          responseBody,
          (json) {
            return (json as List)
                .map((item) =>
                    BaseViewModel.fromJson(item as Map<String, dynamic>))
                .toList();
          },
        );
        return cityResponse;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'لا يوجد انترنت');
    }
  }

  Future<BaseResponse<List<BaseViewModel>>> getVillage(int cityId) async {
    String? token = await TokenManager.getToken();
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse('${ApiSetting.getVillage}?cityId=$cityId'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );
        debugPrint(response.statusCode.toString());
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        debugPrint(responseBody.toString());
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        final cityResponse = BaseResponse<List<BaseViewModel>>.fromJson(
          responseBody,
          (json) {
            return (json as List)
                .map((item) =>
                    BaseViewModel.fromJson(item as Map<String, dynamic>))
                .toList();
          },
        );
        return cityResponse;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'لا يوجد انترنت');
    }
  }

  Future<int> getNewOrderId() async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        String? token = await TokenManager.getToken();
        final response = await apiController.get(
          Uri.parse(ApiSetting.getNewOrderId),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );

        debugPrint('Response Status Code: ${response.statusCode}');
        debugPrint('Response Body: ${response.body}');

        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
          throw Exception('HTTP Error');
        }
        return responseBody['data'] as int;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'لا يوجد انترنت');
    }
  }
}
