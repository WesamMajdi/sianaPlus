import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:maintenance_app/src/core/error/exception.dart';
import 'package:maintenance_app/src/core/error/handle_http_error.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
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
import 'package:package_info_plus/package_info_plus.dart';
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
        String role = responseBody['data']['role'];
        await TokenManager.saveToken(token);
        await TokenManager.saveName(name);
        await TokenManager.saveRole(role);

        final isDeviceRegistered = await registerDevice();
        if (isDeviceRegistered) {
          print("Device registered successfully after login.");
        } else {
          print("Device registration failed after login.");
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
        String role = responseBody['data']['role'];
        await TokenManager.saveToken(token);
        await TokenManager.saveName(name);
        await TokenManager.saveRole(role);
        final isDeviceRegistered = await registerDevice();
        if (isDeviceRegistered) {
          print("Device registered successfully after login.");
        } else {
          print("Device registration failed after login.");
        }
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

  Future<bool> registerDevice() async {
    try {
      // Get Package Info
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final String appVersion =
          '${packageInfo.version}+${packageInfo.buildNumber}';

      // Get Tokens
      String? token = await TokenManager.getToken();
      String? fcmToken = await TokenManager.getFcmToken();

      if (token == null || fcmToken == null) {
        print('Token or FCM Token is null');
        return false;
      }

      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

      // Get Device Info
      late final String deviceId;
      late final String deviceType;
      late final String osVersion;

      try {
        if (Platform.isAndroid) {
          final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          deviceId = androidInfo.id;
          deviceType = '${androidInfo.brand} ${androidInfo.model}';
          osVersion = 'Android ${androidInfo.version.release}';
        } else if (Platform.isIOS) {
          final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
          deviceId = iosInfo.identifierForVendor ?? 'Unknown';
          deviceType = iosInfo.model;
          osVersion = '${iosInfo.systemName} ${iosInfo.systemVersion}';
        } else {
          throw PlatformException(
            code: 'UNSUPPORTED_PLATFORM',
            message: 'This platform is not supported',
          );
        }
      } catch (deviceError) {
        print('Error getting device info: $deviceError');
        return false;
      }

      final Map<String, dynamic> requestBody = {
        'tokenText': fcmToken,
        'deviceId': deviceId,
        'deviceType': deviceType,
        'osVersion': osVersion,
        'appVersion': appVersion,
      };

      final response = await apiController.post(
        Uri.parse(ApiSetting.creatToken),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: requestBody,
      );

      if (response.statusCode == 200) {
        print('Device token registered successfully');
        return true;
      } else {
        print(' Failed to register device token: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error registering device token: $e');
      return false;
    }
  }

  Future<void> resetFirstTimeStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(FIRST_TIME_KEY, true);
  }
}
