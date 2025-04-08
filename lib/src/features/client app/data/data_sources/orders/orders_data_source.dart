import 'package:maintenance_app/src/core/network/global_token.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/basket_Model.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/order_maintenance%20_model.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/order_product.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/order_product_model.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/orders_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/data/model/create_Order_request.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/error/handle_http_error.dart';
import '../../../../../core/network/api_controller.dart';
import '../../../../../core/network/base_response.dart';
import '../../../../../core/network/api_setting.dart';
import '../../../../../core/pagination/paginated_response.dart';
import '../../../../../core/pagination/pagination_params.dart';
import '../../model/orders/color_entery.dart';
import '../../model/orders/orders_model_request.dart';

final List<OrderModel> allOrders = [
  // Order(
  //   id: 2568,
  //   imageUrl: 'assets/images/afan.jpeg',
  //   serviceName: 'إصلاح مروحة',
  //   price: 150.0,
  //   status: 'نشطة',
  // ),
  // Order(
  //   id: 6935,
  //   imageUrl: 'assets/images/washing machine.jpeg',
  //   serviceName: 'إصلاح غسالة',
  //   price: 200.0,
  //   status: 'تحت المراجعة',
  // ),
  // Order(
  //   id: 1111,
  //   imageUrl: 'assets/images/Air conditioner.jpeg',
  //   serviceName: 'إصلاح المكيف',
  //   price: 250.0,
  //   deliveryTime: '2023-08-01',
  // ),
  // Order(
  //   id: 2565,
  //   imageUrl: 'assets/images/refrigerator.jpeg',
  //   serviceName: 'إصلاح الثلاجة',
  //   price: 300.0,
  //   deliveryTime: '2023-07-20',
  // ),
];
final List<OrderModel> previousOrders = [
  // Order(
  //   id: 1111,
  //   imageUrl: 'assets/images/Air conditioner.jpeg',
  //   serviceName: 'إصلاح المكيف',
  //   price: 250.0,
  //   deliveryTime: '2023-08-01',
  // ),
  // Order(
  //   id: 2565,
  //   imageUrl: 'assets/images/refrigerator.jpeg',
  //   serviceName: 'إصلاح الثلاجة',
  //   price: 300.0,
  //   deliveryTime: '2023-07-20',
  // ),
];

final List<OrderModel> currentOrders = [
  // Order(
  //   id: 2568,
  //   imageUrl: 'assets/images/afan.jpeg',
  //   serviceName: 'إصلاح مروحة',
  //   price: 150.0,
  //   status: 'نشطة',
  // ),
  // Order(
  //   id: 6935,
  //   imageUrl: 'assets/images/washing machine.jpeg',
  //   serviceName: 'إصلاح غسالة',
  //   price: 200.0,
  //   status: 'تحت المراجعة',
  // ),
];

class OrderRemoteDataSource {
  final ApiController apiController;
  final InternetConnectionChecker internetConnectionChecker;

  OrderRemoteDataSource(
      {required this.apiController, required this.internetConnectionChecker});

  Future<BaseResponse<List<OrderEntery>>> getColorList() async {
    // debugPrint(Uri.parse(
    //     '${ApiSetting.getProductByCategory}?categoryId=${paginationParams.mainCategoryId}&page=${paginationParams.page}&perPage=${paginationParams.perPage}')
    //     .toString());
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(ApiSetting.getColorList),
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjU5MzdmMWZlLTg0OGQtNDY3ZC05YmMzLWUzZWJmMjZhZmY0YyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJodXNzZW5AZ21haWwuY29tIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoiaHVzc2VuQGdtYWlsLmNvbSIsImV4cCI6MTczNjQxOTY3MSwiaXNzIjoiRGV2ZWxvcGVyc0F1dGgiLCJhdWQiOiJEZXZlbG9wZXJzQXV0aCJ9.Ve1L0udmkLwjfGj59tqKnFH9aVTYUOIN0z6Sq562nL4'
          },
        );
        debugPrint(response.statusCode.toString());
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        debugPrint(responseBody.toString());
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        final productResponse = BaseResponse<List<OrderEntery>>.fromJson(
          responseBody,
          (json) {
            return (json as List)
                .map((item) =>
                    OrderEntery.fromJson(item as Map<String, dynamic>))
                .toList();
          },
        );
        return productResponse;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<BaseResponse<List<OrderEntery>>> getItemsList() async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        String? token = await TokenManager.getToken();
        final response = await apiController.get(
          Uri.parse(ApiSetting.getItemList),
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

        final productResponse = BaseResponse<List<OrderEntery>>.fromJson(
          responseBody,
          (json) {
            return (json as List)
                .map((item) =>
                    OrderEntery.fromJson(item as Map<String, dynamic>))
                .toList();
          },
        );
        return productResponse;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<BaseResponse<List<OrderEntery>>> getCompaniesList() async {
    String? token = await TokenManager.getToken();
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(ApiSetting.getCompaniesList),
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

        final productResponse = BaseResponse<List<OrderEntery>>.fromJson(
          responseBody,
          (json) {
            return (json as List)
                .map((item) =>
                    OrderEntery.fromJson(item as Map<String, dynamic>))
                .toList();
          },
        );
        return productResponse;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<void> createOrderMaintenance(
      CreateOrderRequest createOrderRequest) async {
    String? token = await TokenManager.getToken();
    debugPrint(jsonEncode(createOrderRequest.toJson()).toString());
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.post(
            Uri.parse(ApiSetting.createOrderMaintenance),
            headers: {
              'Content-Type': 'application/json',
              'accept': '*/*',
              'Authorization': 'Bearer $token'
            },
            body: createOrderRequest.toJson());
        debugPrint(response.statusCode.toString());
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        debugPrint(responseBody.toString());
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }
        //
        // return productResponse;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<PaginatedResponse<OrderModel>> getOrderMaintenanceItem(
      PaginationParams paginationParams) async {
    String? token = await TokenManager.getToken();
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getOrderMaintenanceItem}?handReceiptId=${paginationParams.handReceiptId}&page=${paginationParams.page}&perPage=${paginationParams.perPage}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        debugPrint(responseBody.toString());
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        final ordersResponse =
            BaseResponse<PaginatedResponse<OrderModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<OrderModel>.fromJson(
              json,
              (p0) {
                return OrderModel.fromJson(p0);
              },
            );
          },
        );
        return ordersResponse.data!;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<PaginatedResponse<OrderModel>> getOrderMaintenanceByUserNew(
      PaginationParams paginationParams) async {
    String? token = await TokenManager.getToken();
    debugPrint(Uri.parse(
            '${ApiSetting.getOrderMaintenanceByUserNew}?page=${paginationParams.page}&perPage=${paginationParams.perPage}')
        .toString());
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getOrderMaintenanceByUserNew}?page=${paginationParams.page}&perPage=${paginationParams.perPage}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        debugPrint(responseBody.toString());
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        final ordersResponse =
            BaseResponse<PaginatedResponse<OrderModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<OrderModel>.fromJson(
              json,
              (p0) {
                return OrderModel.fromJson(p0);
              },
            );
          },
        );
        return ordersResponse.data!;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<PaginatedResponse<OrderModel>> getOrderMaintenanceByUserOld(
      PaginationParams paginationParams) async {
    String? token = await TokenManager.getToken();
    debugPrint(Uri.parse(
            '${ApiSetting.getOrderMaintenanceByUserOld}?page=${paginationParams.page}&perPage=${paginationParams.perPage}')
        .toString());
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getOrderMaintenanceByUserOld}?page=${paginationParams.page}&perPage=${paginationParams.perPage}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        debugPrint(responseBody.toString());
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        final ordersResponse =
            BaseResponse<PaginatedResponse<OrderModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<OrderModel>.fromJson(
              json,
              (p0) {
                return OrderModel.fromJson(p0);
              },
            );
          },
        );
        return ordersResponse.data!;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<void> createOrderProduct(CreateOrderRequest createOrderRequest) async {
    String? token = await TokenManager.getToken();
    debugPrint(jsonEncode(createOrderRequest.toJson()).toString());

    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.post(
          Uri.parse(ApiSetting.createOrder),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(createOrderRequest.toJson()),
        );

        debugPrint(response.statusCode.toString());

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
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<OrderMaintenanceRequest> getNewOrderMaintenance() async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        String? token = await TokenManager.getToken();
        final response = await apiController.get(
          Uri.parse(ApiSetting.getBeforeOrder),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );

        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
          throw Exception('HTTP Error');
        }
        print(response.body);
        return OrderMaintenanceRequest.fromJson(responseBody);
      } on TimeoutException {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<PaginatedResponse<OrderModel>> getOrderMaintenanceRequestsForApproval(
      PaginationParams paginationParams) async {
    String? token = await TokenManager.getToken();

    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getCostNotifiedToTheCustomer}?page=${paginationParams.page}&perPage=${paginationParams.perPage}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        debugPrint(responseBody.toString());
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }
        print(response.statusCode);
        final ordersResponse =
            BaseResponse<PaginatedResponse<OrderModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<OrderModel>.fromJson(
              json,
              (p0) {
                return OrderModel.fromJson(p0);
              },
            );
          },
        );
        return ordersResponse.data!;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<Map<String, dynamic>> responseFromTheCustomer(int receiptItemId,
      bool? customerApproved, String reasonForRefusingMaintenance) async {
    print(receiptItemId);
    print(customerApproved);

    String? token = await TokenManager.getToken();
    if (token == null) {
      throw Exception('Authorization token is missing or expired');
    }

    if (reasonForRefusingMaintenance.isEmpty) {
      throw Exception('reasonForRefusingMaintenance is required');
    }

    if (!await internetConnectionChecker.hasConnection) {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }

    try {
      final requestBody = {
        'receiptItemId': receiptItemId,
        'customerApproved': customerApproved,
        'reasonForRefusingMaintenance': reasonForRefusingMaintenance,
      };

      final response = await apiController.post(
        Uri.parse(ApiSetting.defineMalfunctionForHandReceiptItem),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: requestBody,
      );

      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      print(requestBody);
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

  Future<void> addHandReceiptItemsByDm(
      int handReceiptId, CreateOrderDeliveryRequest createOrderRequest) async {
    print(handReceiptId);
    print(createOrderRequest.description);
    String? token = await TokenManager.getToken();
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.post(
            Uri.parse(
                '${ApiSetting.addHandReceiptItemsByDm}?handReceiptId=$handReceiptId'),
            headers: {
              'Content-Type': 'application/json',
              'accept': '*/*',
              'Authorization': 'Bearer $token'
            },
            body: createOrderRequest.toJson());

        print(response.statusCode);
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

  Future<PaginatedResponse<OrderProductModel>> getOrderProductByUserNew(
      PaginationParams paginationParams) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        String? token = await TokenManager.getToken();
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getOrderByUserNew}?page=${paginationParams.page}&perPage=${paginationParams.perPage}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );

        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
          throw Exception('HTTP Error');
        }
        final ordersResponse =
            BaseResponse<PaginatedResponse<OrderProductModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<OrderProductModel>.fromJson(
              json,
              (p0) {
                return OrderProductModel.fromJson(p0);
              },
            );
          },
        );
        return ordersResponse.data!;
      } on TimeoutException {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<PaginatedResponse<OrderProductModel>> getOrderProductByUserOld(
      PaginationParams paginationParams) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        String? token = await TokenManager.getToken();
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getOrderByUserOld}?page=${paginationParams.page}&perPage=${paginationParams.perPage}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );

        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
          throw Exception('HTTP Error');
        }

        final ordersResponse =
            BaseResponse<PaginatedResponse<OrderProductModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<OrderProductModel>.fromJson(
              json,
              (p0) {
                return OrderProductModel.fromJson(p0);
              },
            );
          },
        );
        return ordersResponse.data!;
      } on TimeoutException {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<List<BasketModel>> getAllItemByOrder(int? basketId) async {
    String? token = await TokenManager.getToken();

    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse('${ApiSetting.getAllItemByOrder}?basketId=$basketId'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode >= 400) {
          final Map<String, dynamic> responseBody = jsonDecode(response.body);
          HandleHttpError.handleHttpError(responseBody);
          throw Exception(
              'Error: ${responseBody['message'] ?? 'Unknown error'}');
        }

        // تحليل الـ JSON من الاستجابة
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final data = responseBody['data'];

        if (data == null || data['orders'] == null) {
          return [];
        }

        final List<dynamic> ordersJson = data['orders'];
        List<BasketModel> baskets = ordersJson.map((json) {
          return BasketModel.fromJson(json);
        }).toList();

        return baskets;
      } catch (e) {
        throw Exception("An error occurred: $e");
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }
}
