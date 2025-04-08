import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:maintenance_app/src/core/error/exception.dart';
import 'package:maintenance_app/src/core/error/handle_http_error.dart';
import 'package:maintenance_app/src/core/network/api_controller.dart';
import 'package:maintenance_app/src/core/network/api_setting.dart';
import 'package:maintenance_app/src/core/network/base_response.dart';
import 'package:maintenance_app/src/core/network/global_token.dart';
import 'package:maintenance_app/src/core/pagination/paginated_response.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/model/recovered_maintenance_parts/recovered_maintenance_parts_model.dart';

class ReturnHandReceiptRemoteDataSource {
  final ApiController apiController;
  final InternetConnectionChecker internetConnectionChecker;

  ReturnHandReceiptRemoteDataSource({
    required this.apiController,
    required this.internetConnectionChecker,
  });
  Future<PaginatedResponse<ReturnHandReceiptModel>>
      getAllReturnHandReceiptItems(PaginationParams paginationParams,
          String? searchQuery, String? barcode) async {
    String? token = await TokenManager.getToken();
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getAllReturnHandReceiptItems}?page=${paginationParams.page}&perPage=${paginationParams.perPage}&generalSearch=$searchQuery&barcode=$barcode'),
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
        final handReceiptResponse =
            BaseResponse<PaginatedResponse<ReturnHandReceiptModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<ReturnHandReceiptModel>.fromJson(
              json,
              (p0) => ReturnHandReceiptModel.fromJson(p0),
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

  Future<ReturnHandReceiptModel> getReturnHandReceiptItem(int id) async {
    String? token = await TokenManager.getToken();
    print(id);
    if (!await internetConnectionChecker.hasConnection) {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }

    try {
      final response = await apiController.get(
        Uri.parse('${ApiSetting.getReturnHandReceiptItem}?Id=$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (response.statusCode >= 400) {
        HandleHttpError.handleHttpError(responseBody);
      }
      print(responseBody);

      return ReturnHandReceiptModel.fromJson(responseBody['data']);
    } on TimeoutException catch (_) {
      throw TimeoutException('Request timed out');
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }

  Future<Map<String, dynamic>> updateStatusForReturnHandReceiptItem(
      int receiptItemId, int? status) async {
    String? token = await TokenManager.getToken();

    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.post(
          Uri.parse(
              '${ApiSetting.updateStatusForReturnHandReceiptItem}?receiptItemId=$receiptItemId&status=$status'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        return responseBody;
      } on TimeoutException catch (_) {
        throw TimeoutException('Request timed out');
      } catch (e) {
        throw Exception('Unexpected error occurred');
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<Map<String, dynamic>> defineMalfunctionForReturnHandReceiptItem(
      int receiptItemId, String? description) async {
    String? token = await TokenManager.getToken();
    if (token == null) {
      throw Exception('Authorization token is missing or expired');
    }

    if (description == null || description.isEmpty) {
      throw Exception('Description is required');
    }

    if (!await internetConnectionChecker.hasConnection) {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }

    try {
      final requestBody = {
        "receiptItemId": receiptItemId,
        "description": description,
      };

      final response = await apiController.post(
        Uri.parse(ApiSetting.defineMalfunctionForReturnHandReceiptItem),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: requestBody,
      );

      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode >= 400) {
        HandleHttpError.handleHttpError(responseBody);
      }

      return responseBody;
    } on TimeoutException catch (_) {
      throw TimeoutException('Request timed out');
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }

  Future<Map<String, dynamic>> enterMaintenanceCostForReturnHandReceiptItem({
    required int receiptItemId,
    required double costNotifiedToTheCustomer,
    required int warrantyDaysNumber,
  }) async {
    String? token = await TokenManager.getToken();
    if (token == null) {
      throw Exception('Authorization token is missing or expired');
    }

    if (await internetConnectionChecker.hasConnection) {
      try {
        final requestBody = {
          "receiptItemId": receiptItemId,
          "costNotifiedToTheCustomer": costNotifiedToTheCustomer,
          "warrantyDaysNumber": warrantyDaysNumber,
        };

        final response = await apiController.post(
          Uri.parse(ApiSetting.enterMaintenanceCostForReturnHandReceiptItem),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: requestBody,
        );

        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }
        return responseBody;
      } on TimeoutException catch (_) {
        throw TimeoutException('Request timed out');
      } catch (e) {
        throw Exception('Unexpected error occurred: $e');
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<Map<String, dynamic>> suspenseMaintenanceForReturnHandReceiptItem({
    required int receiptItemId,
    required String? maintenanceSuspensionReason,
  }) async {
    String? token = await TokenManager.getToken();
    if (token == null) {
      throw Exception('Authorization token is missing or expired');
    }

    if (!await internetConnectionChecker.hasConnection) {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }

    try {
      final requestBody = {
        "receiptItemId": receiptItemId,
        "maintenanceSuspensionReason": maintenanceSuspensionReason,
      };

      final response = await apiController.post(
        Uri.parse(ApiSetting.suspenseMaintenanceForReturnHandReceiptItem),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: requestBody,
      );

      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode >= 400) {
        HandleHttpError.handleHttpError(responseBody);
      }

      return responseBody;
    } on TimeoutException catch (_) {
      throw TimeoutException('Request timed out');
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }

  Future<Map<String, dynamic>> reOpenMaintenanceForReturnHandReceiptItem({
    required int receiptItemId,
  }) async {
    String? token = await TokenManager.getToken();

    if (!await internetConnectionChecker.hasConnection) {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }

    try {
      final response = await apiController.post(
        Uri.parse(
            '${ApiSetting.reOpenMaintenanceForReturnHandReceiptItem}?receiptItemId=$receiptItemId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode >= 400) {
        HandleHttpError.handleHttpError(responseBody);
      }

      return responseBody;
    } on TimeoutException catch (_) {
      throw TimeoutException('Request timed out');
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }
}
