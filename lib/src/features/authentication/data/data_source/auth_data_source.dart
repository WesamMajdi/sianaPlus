import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:maintenance_app/src/core/error/exception.dart';
import 'package:maintenance_app/src/core/error/handle_http_error.dart';
import 'package:maintenance_app/src/core/network/api_controller.dart';
import 'package:maintenance_app/src/core/network/api_setting.dart';
import 'package:maintenance_app/src/core/network/global_token.dart';
import 'package:maintenance_app/src/features/authentication/data/model/forgot_password_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/login_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/reset_password_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/signup_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/update_email_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/update_password_model.dart';
import 'package:maintenance_app/src/features/authentication/data/model/user_model.dart';

import '../../../../core/network/base_response.dart';

class AuthRemoteDataSource {
  final ApiController apiController;
  final InternetConnectionChecker internetConnectionChecker;

  AuthRemoteDataSource({
    required this.apiController,
    required this.internetConnectionChecker,
  });

  Future<BaseResponse<UserModel>> login(LoginModel createLoginRequest) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.post(
          Uri.parse(ApiSetting.login),
          body: createLoginRequest.toJson(),
        );

        if (response.body.isEmpty) {
          throw Exception("Empty response from server");
        }
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }
        String token = responseBody['data']['token'];
        String name = responseBody['data']['username'];

        await TokenManager.saveToken(token);
        await TokenManager.saveName(name);

        return BaseResponse<UserModel>.fromJson(
          responseBody,
          (data) => UserModel.fromJson(data),
        );
      } on TimeoutException catch (e) {
        debugPrint('Timeout Exception: $e');
        throw TimeoutException('Request timed out, please try again.');
      } catch (e) {
        debugPrint('Unexpected Error: $e');
        throw Exception('An unexpected error occurred.');
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<BaseResponse<UserModel>> signup(
      SignupModel createSignupRequest) async {
    if (await internetConnectionChecker.hasConnection) {
      if (createSignupRequest.password != createSignupRequest.confirmPassword) {
        throw Exception('Password and Confirm Password do not match.');
      }

      try {
        final response = await apiController.post(Uri.parse(ApiSetting.signup),
            headers: {
              'Content-Type': 'application/json',
            },
            body: createSignupRequest.toJson());

        final responseBody = jsonDecode(response.body);

        String token = responseBody['data']['token'];
        String name = responseBody['data']['username'];
        await TokenManager.saveToken(token);
        await TokenManager.saveName(name);

        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        return BaseResponse<UserModel>.fromJson(
          responseBody,
          (data) => UserModel.fromJson(data),
        );
      } on TimeoutException catch (e) {
        debugPrint('Timeout Exception: $e');
        throw TimeoutException('Request timed out, please try again.');
      } catch (e) {
        debugPrint('Unexpected Error: $e');
        throw Exception('An unexpected error occurred.');
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<BaseResponse<void>> updatePassword(
      UpdtePasswordModel updatePasswordRequest) async {
    String? token = await TokenManager.getToken();

    if (token == null) {
      throw Exception('Token not found. Please login again.');
    }

    try {
      final response = await apiController.post(
        Uri.parse(ApiSetting.updatePassword),
        headers: {
          'Content-Type': 'application/json',
          'accept': '*/*',
          'Authorization': 'Bearer $token',
        },
        body: updatePasswordRequest.toJson(),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode >= 400) {
        HandleHttpError.handleHttpError(responseBody);
      }

      return BaseResponse<void>.fromJson(
        responseBody,
        (data) {},
      );
    } on TimeoutException catch (e) {
      debugPrint('Timeout Exception: $e');
      throw TimeoutException('Request timed out, please try again.');
    } catch (e) {
      debugPrint('Unexpected Error: $e');
      throw Exception('An unexpected error occurred.');
    }
  }

  Future<BaseResponse<void>> updateEmail(
      UpdateEmailModel updateEmailRequest) async {
    if (await internetConnectionChecker.hasConnection) {
      String? token = await TokenManager.getToken();

      try {
        final response =
            await apiController.post(Uri.parse(ApiSetting.updateEmail),
                headers: {
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer $token',
                },
                body: updateEmailRequest.toJson());

        final responseBody = jsonDecode(response.body);

        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        return BaseResponse<void>.fromJson(
          responseBody,
          (data) {},
        );
      } on TimeoutException catch (e) {
        debugPrint('Timeout Exception: $e');
        throw TimeoutException('Request timed out, please try again.');
      } catch (e) {
        debugPrint('Unexpected Error: $e');
        throw Exception('An unexpected error occurred.');
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<BaseResponse<void>> forgotPassword(
      ForgotPasswordModel forgotPasswordRequest) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response =
            await apiController.post(Uri.parse(ApiSetting.forgotPassword),
                headers: {
                  'Content-Type': 'application/json',
                },
                body: forgotPasswordRequest.toJson());

        final responseBody = jsonDecode(response.body);

        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        return BaseResponse<void>.fromJson(
          responseBody,
          (data) {},
        );
      } on TimeoutException catch (e) {
        debugPrint('Timeout Exception: $e');
        throw TimeoutException('Request timed out, please try again.');
      } catch (e) {
        debugPrint('Unexpected Error: $e');
        throw Exception('An unexpected error occurred.');
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<BaseResponse<void>> resetPassword(
      ResetPasswordModel resetPasswordRequest) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response =
            await apiController.post(Uri.parse(ApiSetting.resetPassword),
                headers: {
                  'Content-Type': 'application/json',
                },
                body: resetPasswordRequest.toJson());

        final responseBody = jsonDecode(response.body);

        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        return BaseResponse<void>.fromJson(
          responseBody,
          (data) {},
        );
      } on TimeoutException catch (e) {
        debugPrint('Timeout Exception: $e');
        throw TimeoutException('Request timed out, please try again.');
      } catch (e) {
        debugPrint('Unexpected Error: $e');
        throw Exception('An unexpected error occurred.');
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }
}
