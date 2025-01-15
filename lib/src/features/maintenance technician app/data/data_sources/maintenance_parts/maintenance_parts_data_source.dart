import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:maintenance_app/src/core/network/api_controller.dart';
import 'package:maintenance_app/src/core/network/global_token.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:maintenance_app/src/core/pagination/paginated_response.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/orders_model_request.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/model/maintenance_parts/maintenance_parts_model.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/domain/entities/maintenance_parts/maintenance_parts_entitie.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/error/handle_http_error.dart';
import '../../../../../core/network/base_response.dart';
import '../../../../../core/network/api_setting.dart';

class HandReceiptRemoteDataSource {
  final ApiController apiController;
  final InternetConnectionChecker internetConnectionChecker;

  HandReceiptRemoteDataSource({
    required this.apiController,
    required this.internetConnectionChecker,
  });
  Future<PaginatedResponse<HandReceiptModel>> getAllHandReceiptItems(
      PaginationParams paginationParams,
      String? searchQuery,
      String? barcode) async {
    String? token = await TokenManager.getToken();
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getAllHandReceiptItems}?page=${paginationParams.page}&perPage=${paginationParams.perPage}&generalSearch=$searchQuery&barcode=$barcode'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );

        debugPrint('Status Code: ${response.statusCode}');
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }
        print(responseBody);
        final handReceiptResponse =
            BaseResponse<PaginatedResponse<HandReceiptModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<HandReceiptModel>.fromJson(
              json,
              (p0) => HandReceiptModel.fromJson(p0),
            );
          },
        );

        return handReceiptResponse.data!;
      } on TimeOutExeption catch (e) {
        debugPrint('Timeout Exception: $e');
        rethrow;
      } catch (e) {
        debugPrint('Unexpected Error: $e');
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }
}
