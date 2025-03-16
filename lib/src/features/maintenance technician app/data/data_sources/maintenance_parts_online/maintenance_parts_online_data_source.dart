import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:maintenance_app/src/core/network/api_controller.dart';
import 'package:maintenance_app/src/core/network/global_token.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:maintenance_app/src/core/pagination/paginated_response.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/model/online_maintenance_parts/online_maintenance_parts.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/error/handle_http_error.dart';
import '../../../../../core/network/base_response.dart';
import '../../../../../core/network/api_setting.dart';

class OnlineRemoteDataSource {
  final ApiController apiController;
  final InternetConnectionChecker internetConnectionChecker;

  OnlineRemoteDataSource({
    required this.apiController,
    required this.internetConnectionChecker,
  });
  Future<PaginatedResponse<OnlineModel>> getAllOnlineItems(
      PaginationParams paginationParams,
      String? searchQuery,
      String? barcode) async {
    String? token = await TokenManager.getToken();
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getAllOnlineItems}?page=${paginationParams.page}&perPage=${paginationParams.perPage}&generalSearch=$searchQuery&barcode=$barcode'),
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
        final onlineResponse =
            BaseResponse<PaginatedResponse<OnlineModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<OnlineModel>.fromJson(
              json,
              (p0) => OnlineModel.fromJson(p0),
            );
          },
        );

        return onlineResponse.data!;
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

  Future<OnlineModel> getOnlineItem(int id) async {
    String? token = await TokenManager.getToken();

    if (!await internetConnectionChecker.hasConnection) {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }

    try {
      final response = await apiController.get(
        Uri.parse('${ApiSetting.getHandReceiptItem}?Id=$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode >= 400) {
        HandleHttpError.handleHttpError(responseBody);
      }

      return OnlineModel.fromJson(responseBody['data']);
    } on TimeoutException catch (_) {
      throw TimeoutException('Request timed out');
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }

  Future<Map<String, dynamic>> updateStatusOnlineItem(
      int receiptItemId, int? status) async {
    String? token = await TokenManager.getToken();

    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.post(
          Uri.parse(
              '${ApiSetting.updateStatusForOnlineItem}?receiptItemId=$receiptItemId&status=$status'),
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

  Future<Map<String, dynamic>> defineMalfunctionOnlineItem(
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
        Uri.parse(ApiSetting.defineMalfunctionForOnlineItem),
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

  Future<Map<String, dynamic>> enterMaintenanceCostForOnlineItem({
    required int receiptItemId,
    required String costNotifiedToTheCustomer,
    int warrantyDaysNumber = 0,
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
          Uri.parse(ApiSetting.enterMaintenanceCostForOnlineItem),
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

  Future<Map<String, dynamic>> suspendMaintenanceForOnlineItem({
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
        Uri.parse(ApiSetting.suspendMaintenanceForHandReceiptItem),
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

  Future<Map<String, dynamic>> reopenMaintenanceForOnlineItem({
    required int receiptItemId,
  }) async {
    String? token = await TokenManager.getToken();

    if (!await internetConnectionChecker.hasConnection) {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }

    try {
      final response = await apiController.post(
        Uri.parse(
            '${ApiSetting.reOpenMaintenanceForHandReceiptItem}?receiptItemId=$receiptItemId'),
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
