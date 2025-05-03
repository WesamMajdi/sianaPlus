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
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/data/model/branch_model.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/data/model/order_maintenances_details_model.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/data/model/receipt_item_convert_model.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/data/model/receive_order_maintenance_model.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/data/model/hand_receip_maintenance_parts/hand_receipt_model.dart';

class DeliveryMaintenanceRemoteDataSource {
  final ApiController apiController;
  final InternetConnectionChecker internetConnectionChecker;

  DeliveryMaintenanceRemoteDataSource({
    required this.apiController,
    required this.internetConnectionChecker,
  });
  Future<PaginatedResponse<ReceiveMaintenanceOrderModel>> getAllForAllDelivery(
    PaginationParams paginationParams,
  ) async {
    String? token = await TokenManager.getToken();
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getAllForAllDeliveryMaintenance}?page=${paginationParams.page}&perPage=${paginationParams.perPage}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );

        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }
        final handReceiptResponse = BaseResponse<
            PaginatedResponse<ReceiveMaintenanceOrderModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<ReceiveMaintenanceOrderModel>.fromJson(
              json,
              (p0) => ReceiveMaintenanceOrderModel.fromJson(p0),
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

  Future<PaginatedResponse<ReceiveMaintenanceOrderModel>> getAllTakeDelivery(
    PaginationParams paginationParams,
  ) async {
    String? token = await TokenManager.getToken();
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getAllTakeDeliveryMaintenance}?page=${paginationParams.page}&perPage=${paginationParams.perPage}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );

        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }
        final handReceiptResponse = BaseResponse<
            PaginatedResponse<ReceiveMaintenanceOrderModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<ReceiveMaintenanceOrderModel>.fromJson(
              json,
              (p0) => ReceiveMaintenanceOrderModel.fromJson(p0),
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

  Future<PaginatedResponse<ReceiveMaintenanceOrderModel>>
      getAllTakePerviousOrder(
    PaginationParams paginationParams,
  ) async {
    String? token = await TokenManager.getToken();
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getAllTakePerviousMaintenanceOrder}?page=${1}&perPage=${1000000}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );

        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }
        final handReceiptResponse = BaseResponse<
            PaginatedResponse<ReceiveMaintenanceOrderModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<ReceiveMaintenanceOrderModel>.fromJson(
              json,
              (p0) => ReceiveMaintenanceOrderModel.fromJson(p0),
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

  Future<Map<String, dynamic>> takeOrderMaintenance(
      int orderMaintenancId) async {
    String? token = await TokenManager.getToken();

    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.post(
          Uri.parse(
              '${ApiSetting.takeOrderMaintenance}?OrderMaintenancId=$orderMaintenancId'),
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

  Future<Map<String, dynamic>> updateOrderMaintenance(
      int orderMaintenanceId, int? status) async {
    String? token = await TokenManager.getToken();

    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.post(
          Uri.parse(
              '${ApiSetting.updateOrderMaintenance}?orderMaintenanceId=$orderMaintenanceId&status=$status'),
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

  Future<OrderMaintenancesDetielsModel> getAllItemByOrderDetiles(
      int handReceiptId, int orderMaintenancId) async {
    String? token = await TokenManager.getToken();

    if (await internetConnectionChecker.hasConnection) {
      try {
        final Uri url = Uri.parse(
            '${ApiSetting.getOrderMaintenanceItem}?OrderMaintenancId=$orderMaintenancId&handReceiptId=$handReceiptId');

        final response = await apiController.get(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );
        print(response.body);
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
              OrderMaintenancesDetielsModel.fromJson(responseBody['data']);
          debugPrint("Returned Data: $orderResponse");
          print(orderResponse);

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

  Future<List<Branch>> getBranches() async {
    String? token = await TokenManager.getToken();

    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(ApiSetting.getBranchList),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        final List<dynamic> data = responseBody['data'];
        final List<Branch> branches =
            data.map((e) => Branch.fromJson(e)).toList();

        print(branches);
        return branches;
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

  Future<Map<String, dynamic>> selectBranch(
      int orderMaintenancId, int? branchId) async {
    String? token = await TokenManager.getToken();

    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.post(
          Uri.parse(
              '${ApiSetting.updateBranch}?OrderMaintenancId=$orderMaintenancId&branchId=$branchId'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );
        print(response.statusCode);
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

  Future<PaginatedResponse<HandReceiptModel>> getAllForAllDeliveryTransfer(
    PaginationParams paginationParams,
  ) async {
    String? token = await TokenManager.getToken();
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getAllForAllDeliveryTransfer}?page=${paginationParams.page}&perPage=${paginationParams.perPage}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );

        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }
        final transferResponse =
            BaseResponse<PaginatedResponse<HandReceiptModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<HandReceiptModel>.fromJson(
              json,
              (p0) => HandReceiptModel.fromJson(p0),
            );
          },
        );
        return transferResponse.data!;
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

  Future<Map<String, dynamic>> updateOrderTransfer(
      int itemId, int? status) async {
    String? token = await TokenManager.getToken();

    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.post(
          Uri.parse(
              '${ApiSetting.updateOrderTransfer}?itemId=$itemId&status=$status'),
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

  Future<Map<String, dynamic>> takeOrderTransfer(int orderMaintenancId) async {
    String? token = await TokenManager.getToken();

    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.post(
          Uri.parse(
              '${ApiSetting.takeOrderMaintenance}?OrderMaintenancId=$orderMaintenancId'),
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

  Future<void> payWithCard(int orderMaintenancId) async {
    String? token = await TokenManager.getToken();
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.post(
          Uri.parse(
              '${ApiSetting.payWithCard}?OrderMaintenancId=$orderMaintenancId'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: orderMaintenancId,
        );

        debugPrint(response.statusCode.toString());
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        debugPrint(responseBody.toString());

        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        if (responseBody['status'] == 1) {
          debugPrint("تمت العملية بنجاح");
        }
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<void> payWithCash(int orderMaintenancId) async {
    String? token = await TokenManager.getToken();
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.post(
          Uri.parse(
              '${ApiSetting.payWithCash}?OrderMaintenancId=$orderMaintenancId'),
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

        if (responseBody['status'] == 1) {
          debugPrint("تمت العملية بنجاح");
        }
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<PaginatedResponse<ReceiptItemConvertModel>>
      getAllForAllDeliveryConvert(
    PaginationParams paginationParams,
  ) async {
    String? token = await TokenManager.getToken();
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getAllForAllDeliveryConvert}?page=${paginationParams.page}&perPage=${paginationParams.perPage}'),
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
            BaseResponse<PaginatedResponse<ReceiptItemConvertModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<ReceiptItemConvertModel>.fromJson(
              json,
              (p0) => ReceiptItemConvertModel.fromJson(p0),
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

  Future<PaginatedResponse<ReceiptItemConvertModel>> getAllTakeDeliveryConvert(
    PaginationParams paginationParams,
  ) async {
    String? token = await TokenManager.getToken();
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getAllTakeDeliveryConvert}?page=${paginationParams.page}&perPage=${paginationParams.perPage}'),
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
            BaseResponse<PaginatedResponse<ReceiptItemConvertModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<ReceiptItemConvertModel>.fromJson(
              json,
              (p0) => ReceiptItemConvertModel.fromJson(p0),
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

  Future<PaginatedResponse<ReceiptItemConvertModel>> getAllForDeliveryConvert(
    PaginationParams paginationParams,
  ) async {
    String? token = await TokenManager.getToken();
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getAllForAllDeliveryConvert}?page=${paginationParams.page}&perPage=${paginationParams.perPage}'),
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
            BaseResponse<PaginatedResponse<ReceiptItemConvertModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<ReceiptItemConvertModel>.fromJson(
              json,
              (p0) => ReceiptItemConvertModel.fromJson(p0),
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

  Future<Map<String, dynamic>> takeOrderMaintenanceConvert(
      int orderMaintenancId) async {
    String? token = await TokenManager.getToken();

    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.post(
          Uri.parse(
              '${ApiSetting.takeOrderMaintenanceConvert}?OrderMaintenancId=$orderMaintenancId'),
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

  Future<Map<String, dynamic>> updateOrderMaintenanceConvert(
      int orderMaintenanceId, int? status) async {
    String? token = await TokenManager.getToken();

    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.post(
          Uri.parse(
              '${ApiSetting.updateOrderMaintenanceConvert}?itemId=$orderMaintenanceId&status=$status'),
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

  Future<PaginatedResponse<ReceiptItemConvertModel>>
      getAllForAllDeliveryOutSide(
    PaginationParams paginationParams,
  ) async {
    String? token = await TokenManager.getToken();
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getAllForAllDeliveryOutSide}?page=${paginationParams.page}&perPage=${paginationParams.perPage}'),
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
            BaseResponse<PaginatedResponse<ReceiptItemConvertModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<ReceiptItemConvertModel>.fromJson(
              json,
              (p0) => ReceiptItemConvertModel.fromJson(p0),
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

  Future<PaginatedResponse<ReceiptItemConvertModel>> getAllTakeDeliveryOutSide(
    PaginationParams paginationParams,
  ) async {
    String? token = await TokenManager.getToken();
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getAllTakeDeliveryOutSide}?page=${paginationParams.page}&perPage=${paginationParams.perPage}'),
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
            BaseResponse<PaginatedResponse<ReceiptItemConvertModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<ReceiptItemConvertModel>.fromJson(
              json,
              (p0) => ReceiptItemConvertModel.fromJson(p0),
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

  Future<PaginatedResponse<ReceiptItemConvertModel>> getAllForDeliveryOutSide(
    PaginationParams paginationParams,
  ) async {
    String? token = await TokenManager.getToken();
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getAllForDeliveryOutSide}?page=${paginationParams.page}&perPage=${paginationParams.perPage}'),
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
            BaseResponse<PaginatedResponse<ReceiptItemConvertModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<ReceiptItemConvertModel>.fromJson(
              json,
              (p0) => ReceiptItemConvertModel.fromJson(p0),
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

  Future<Map<String, dynamic>> takeOrderMaintenanceOutSide(
      int orderMaintenancId) async {
    String? token = await TokenManager.getToken();

    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.post(
          Uri.parse(
              '${ApiSetting.takeOrderMaintenanceConvert}?OrderMaintenancId=$orderMaintenancId'),
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

  Future<Map<String, dynamic>> updateOrderMaintenanceOutSide(
      int orderMaintenanceId, int? status) async {
    String? token = await TokenManager.getToken();

    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.post(
          Uri.parse(
              '${ApiSetting.updateOrderMaintenanceOutSide}?itemId=$orderMaintenanceId&status=$status'),
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
