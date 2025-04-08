import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:maintenance_app/src/core/error/exception.dart';
import 'package:maintenance_app/src/core/error/handle_http_error.dart';
import 'package:maintenance_app/src/core/network/api_controller.dart';
import 'package:maintenance_app/src/core/network/api_setting.dart';
import 'package:maintenance_app/src/core/network/base_response.dart';
import 'package:maintenance_app/src/core/network/global_token.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/profile/profile_model.dart';

class ProfileRemoteDataSource {
  final ApiController apiController;
  final InternetConnectionChecker internetConnectionChecker;

  ProfileRemoteDataSource({
    required this.apiController,
    required this.internetConnectionChecker,
  });

  Future<ProfileModel> getUserProfile() async {
    String? token = await TokenManager.getToken();

    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(ApiSetting.getUserProfile),
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

        final profileResponse = BaseResponse<ProfileModel>.fromJson(
          responseBody,
          (json) => ProfileModel.fromJson(json),
        );

        return profileResponse.data!;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<void> createProblem(String text) async {
    String? token = await TokenManager.getToken();

    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.post(
          Uri.parse(ApiSetting.createProblem),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: {'text': text},
        );

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
