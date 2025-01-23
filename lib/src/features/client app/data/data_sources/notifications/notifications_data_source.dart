import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:maintenance_app/src/core/network/global_token.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/product/product_model.dart';

import '../../../../../core/error/exception.dart';
import '../../../../../core/error/handle_http_error.dart';
import '../../../../../core/network/api_controller.dart';
import '../../../../../core/network/base_response.dart';
import '../../../../../core/network/api_setting.dart';
import '../../../../../core/pagination/paginated_response.dart';
import '../../../../../core/pagination/pagination_params.dart';
import '../../model/category/category_model.dart';
import '../../model/notifications/notification_model.dart';

class NotificationsDataSource {
  final ApiController apiController;
  final InternetConnectionChecker internetConnectionChecker;

  NotificationsDataSource(
      {required this.apiController, required this.internetConnectionChecker});

  Future<PaginatedResponse<NotificationModel>> getNotifications(
      PaginationParams paginationParams) async {
    String? token = await TokenManager.getToken();
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getNotifications}?page=${paginationParams.page}&perPage=${paginationParams.perPage}'),
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

        final notificationResponse =
        BaseResponse<PaginatedResponse<NotificationModel>>.fromJson(
          responseBody,
              (json) {
            return PaginatedResponse<NotificationModel>.fromJson(
              json,
                  (p0) {
                return NotificationModel.fromJson(p0);
              },
            );
          },
        );
        return notificationResponse.data!;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

}