import 'package:maintenance_app/src/core/network/global_token.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/orders_model.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/orders/orders_entity.dart';

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
        print(token);
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
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(ApiSetting.getCompaniesList),
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjU5MzdmMWZlLTg0OGQtNDY3ZC05YmMzLWUzZWJmMjZhZmY0YyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJodXNzZW5AZ21haWwuY29tIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoiaHVzc2VuQGdtYWlsLmNvbSIsImV4cCI6MTczNjQxOTY3MSwiaXNzIjoiRGV2ZWxvcGVyc0F1dGgiLCJhdWQiOiJEZXZlbG9wZXJzQXV0aCJ9.Ve1L0udmkLwjfGj59tqKnFH9aVTYUOIN0z6Sq562nL4'
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
    debugPrint(jsonEncode(createOrderRequest.toJson()).toString());
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.post(
            Uri.parse(ApiSetting.createOrderMaintenance),
            headers: {
              'Content-Type': 'application/json',
              'accept': '*/*',
              'Authorization':
                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjU5MzdmMWZlLTg0OGQtNDY3ZC05YmMzLWUzZWJmMjZhZmY0YyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJodXNzZW5AZ21haWwuY29tIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoiaHVzc2VuQGdtYWlsLmNvbSIsImV4cCI6MTczNjQxOTY3MSwiaXNzIjoiRGV2ZWxvcGVyc0F1dGgiLCJhdWQiOiJEZXZlbG9wZXJzQXV0aCJ9.Ve1L0udmkLwjfGj59tqKnFH9aVTYUOIN0z6Sq562nL4'
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

  Future<PaginatedResponse<OrderModel>> getOrderMaintenanceByUser(
      PaginationParams paginationParams) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getOrderMaintenanceItem}?handReceiptId=${paginationParams.handReceiptId}&page=${paginationParams.page}&perPage=${paginationParams.perPage}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjU5MzdmMWZlLTg0OGQtNDY3ZC05YmMzLWUzZWJmMjZhZmY0YyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJodXNzZW5AZ21haWwuY29tIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoiaHVzc2VuQGdtYWlsLmNvbSIsImV4cCI6MTczNjQxOTY3MSwiaXNzIjoiRGV2ZWxvcGVyc0F1dGgiLCJhdWQiOiJEZXZlbG9wZXJzQXV0aCJ9.Ve1L0udmkLwjfGj59tqKnFH9aVTYUOIN0z6Sq562nL4'
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
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjU5MzdmMWZlLTg0OGQtNDY3ZC05YmMzLWUzZWJmMjZhZmY0YyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJodXNzZW5AZ21haWwuY29tIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoiaHVzc2VuQGdtYWlsLmNvbSIsImV4cCI6MTczNjQxOTY3MSwiaXNzIjoiRGV2ZWxvcGVyc0F1dGgiLCJhdWQiOiJEZXZlbG9wZXJzQXV0aCJ9.Ve1L0udmkLwjfGj59tqKnFH9aVTYUOIN0z6Sq562nL4'
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
}
