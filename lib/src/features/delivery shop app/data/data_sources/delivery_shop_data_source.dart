import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:maintenance_app/src/core/error/exception.dart';
import 'package:maintenance_app/src/core/error/handle_http_error.dart';
import 'package:maintenance_app/src/core/network/api_controller.dart';
import 'package:maintenance_app/src/core/network/api_setting.dart';
import 'package:maintenance_app/src/core/network/base_response.dart';
import 'package:maintenance_app/src/core/network/global_token.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:maintenance_app/src/core/pagination/paginated_response.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/data/model/current_order_detiles_model.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/data/model/receive_order_detiels_model.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/data/model/receive_order_model.dart';

class DeliveryShopRemoteDataSource {
  final ApiController apiController;
  final InternetConnectionChecker internetConnectionChecker;

  DeliveryShopRemoteDataSource({
    required this.apiController,
    required this.internetConnectionChecker,
  });
  Future<PaginatedResponse<ReceiveOrderModel>> getAllForAllDelivery(
    PaginationParams paginationParams,
  ) async {
    String? token = await TokenManager.getToken();
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getAllForAllDelivery}?page=${paginationParams.page}&perPage=${paginationParams.perPage}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );

        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }
        final handReceiptResponse =
            BaseResponse<PaginatedResponse<ReceiveOrderModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<ReceiveOrderModel>.fromJson(
              json,
              (p0) => ReceiveOrderModel.fromJson(p0),
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

  Future<PaginatedResponse<ReceiveOrderDetielsModel>> getAllItemsByOrder(
      PaginationParams paginationParams, int basketId) async {
    String? token = await TokenManager.getToken();
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getAllItemByOrder}?page=${1}&perPage=${1000}&basketId=$basketId'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        final receiveOrderResponse =
            BaseResponse<PaginatedResponse<ReceiveOrderDetielsModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<ReceiveOrderDetielsModel>.fromJson(
              json,
              (p0) => ReceiveOrderDetielsModel.fromJson(p0),
            );
          },
        );

        return receiveOrderResponse.data!;
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

  Future<Map<String, dynamic>> takeOrder(int basketId) async {
    String? token = await TokenManager.getToken();

    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.post(
          Uri.parse('${ApiSetting.takeOrder}?basketId=$basketId'),
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

  Future<PaginatedResponse<ReceiveOrderModel>> getAllTakeDelivery(
    PaginationParams paginationParams,
  ) async {
    String? token = await TokenManager.getToken();
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getAllTakeDelivery}?page=${paginationParams.page}&perPage=${paginationParams.perPage}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );

        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }
        final handReceiptResponse =
            BaseResponse<PaginatedResponse<ReceiveOrderModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<ReceiveOrderModel>.fromJson(
              json,
              (p0) => ReceiveOrderModel.fromJson(p0),
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

  Future<PaginatedResponse<ReceiveOrderModel>> getAllTakePerviousOrder(
    PaginationParams paginationParams,
  ) async {
    String? token = await TokenManager.getToken();
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getAllTakePerviousOrder}?page=${1}&perPage=${10000}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );

        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }
        final handReceiptResponse =
            BaseResponse<PaginatedResponse<ReceiveOrderModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<ReceiveOrderModel>.fromJson(
              json,
              (p0) => ReceiveOrderModel.fromJson(p0),
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

  Future<OrderDetailsModel> getAllItemByOrderDetiles(int basketId) async {
    String? token = await TokenManager.getToken();

    if (await internetConnectionChecker.hasConnection) {
      try {
        final Uri url =
            Uri.parse('${ApiSetting.getAllItemByOrder}?basketId=$basketId');

        final response = await apiController.get(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        Map<String, dynamic> responseBody;
        try {
          responseBody = jsonDecode(response.body);
        } catch (e) {
          throw Exception("JSON: $e");
        }

        debugPrint("API Response: $responseBody");

        if (response.statusCode >= 400) {
          throw Exception("API: ${response.statusCode}");
        }

        if (responseBody.containsKey('data')) {
          final orderResponse =
              OrderDetailsModel.fromJson(responseBody['data']);
          debugPrint("Returned Data: $orderResponse");
          return orderResponse;
        } else {
          throw Exception('');
        }
      } on TimeoutException catch (e) {
        debugPrint('Timeout Exception: $e');
        rethrow;
      } catch (e) {
        debugPrint('Unexpected Error: $e');
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'لا يوجد اتصال بالإنترنت');
    }
  }

  Future<Map<String, dynamic>> updateStatusForOrder(
      int orderId, int? status) async {
    String? token = await TokenManager.getToken();

    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.post(
          Uri.parse(
              '${ApiSetting.updateStatusForOrder}?orderId=$orderId&status=$status'),
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
}
