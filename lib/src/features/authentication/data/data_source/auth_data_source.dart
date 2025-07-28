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
import 'package:maintenance_app/src/features/authentication/domain/entities/user_entity.dart';
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
        String email = responseBody['data']['email'];
        // String phone = responseBody['data']['phone'];

        await TokenManager.saveToken(token);
        await TokenManager.saveName(name);
        await TokenManager.saveRole(role);
        await TokenManager.saveEmail(email);
        // await TokenManager.savePhone(phone);
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
    if (!await internetConnectionChecker.hasConnection) {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }

    if (createSignupRequest.password != createSignupRequest.confirmPassword) {
      throw Exception('Password and Confirm Password do not match.');
    }

    try {
      final response = await apiController
          .post(
            Uri.parse(ApiSetting.signup),
            headers: {
              'Content-Type': 'application/json',
            },
            body: createSignupRequest.toJson(),
          )
          .timeout(const Duration(seconds: 30));

      final responseBody = jsonDecode(response.body);

      if (response.statusCode >= 400) {
        HandleHttpError.handleHttpError(responseBody);
      }
      String token = responseBody['data']['token'];
      String name = responseBody['data']['username'];
      String role = responseBody['data']['role'];
      String email = responseBody['data']['email'];
      String phone = responseBody['data']['phone'];

      await TokenManager.saveToken(token);
      await TokenManager.saveName(name);
      await TokenManager.saveRole(role);
      await TokenManager.saveEmail(email);
      await TokenManager.savePhone(phone);

      final isDeviceRegistered = await registerDevice();
      if (isDeviceRegistered) {
        print("Device registered successfully after signup.");
      } else {
        print("Device registration failed after signup.");
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
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<BaseResponse<SignupResponseData>> signupWithPhone(
      SignupModel createSignupRequest) async {
    if (!await internetConnectionChecker.hasConnection) {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }

    if (createSignupRequest.password != createSignupRequest.confirmPassword) {
      throw Exception('Password and Confirm Password do not match.');
    }

    try {
      final response = await apiController
          .post(
            Uri.parse(ApiSetting.signupWithPhone),
            headers: {
              'Content-Type': 'application/json',
            },
            body: createSignupRequest.toJson(),
          )
          .timeout(const Duration(seconds: 30));

      final responseBody = jsonDecode(response.body);

      if (response.statusCode >= 400) {
        HandleHttpError.handleHttpError(responseBody);
      }

      final isDeviceRegistered = await registerDevice();
      if (isDeviceRegistered) {
        print("Device registered successfully after signup.");
      } else {
        print("Device registration failed after signup.");
      }

      return BaseResponse<SignupResponseData>.fromJson(
        responseBody,
        (data) => SignupResponseData.fromJson(data),
      );
    } on TimeoutException catch (e) {
      debugPrint('Timeout Exception: $e');
      throw TimeoutException('Request timed out, please try again.');
    } catch (e) {
      debugPrint('Unexpected Error: $e');
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<BaseResponse<UserModel>> sendVerificationCode(
      String code, SignupModel user) async {
    final Map<String, dynamic> requestBody = {
      "code": code,
      "user": user.toJson(),
    };
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response =
            await apiController.post(Uri.parse(ApiSetting.sendVerificationCode),
                headers: {
                  'Content-Type': 'application/json',
                },
                body: requestBody);

        final responseBody = jsonDecode(response.body);

        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        String token = responseBody['data']['token'];
        String name = responseBody['data']['username'];
        String role = responseBody['data']['role'];
        String phone = responseBody['data']['phone'];

        await TokenManager.saveToken(token);
        await TokenManager.saveName(name);
        await TokenManager.saveRole(role);
        await TokenManager.savePhone(phone);

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
        final response = await apiController.post(
          Uri.parse(
              '${ApiSetting.updateEmail}?newEmail=${updateEmailRequest.newEmail}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        final responseBody = jsonDecode(response.body);
        print(response.statusCode);
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

  Future<BaseResponse<String>> forgotPassword(
      ForgotPasswordModel forgotPasswordRequest) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.post(
          Uri.parse(ApiSetting.forgotPassword),
          headers: {
            'Content-Type': 'application/json',
          },
          body: forgotPasswordRequest.toJson(),
        );

        final responseBody = jsonDecode(response.body);

        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        return BaseResponse<String>.fromJson(
          responseBody,
          (data) => data.toString(),
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

  Future<BaseResponse<UserModel>> resetPassword(
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

        if (response.body.isEmpty) {
          throw Exception("Empty response from server");
        }
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        String token = responseBody['data']['token'];
        String name = responseBody['data']['username'];
        String role = responseBody['data']['role'];
        await TokenManager.saveToken(token);
        await TokenManager.saveName(name);
        await TokenManager.saveRole(role);

        print(token);
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

  Future<BaseResponse<void>> verifyResetCode(
      ResetVerifyResetCodeModel resetVerifyResetCodeModelRequest) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response =
            await apiController.post(Uri.parse(ApiSetting.verifyResetCode),
                headers: {
                  'Content-Type': 'application/json',
                },
                body: resetVerifyResetCodeModelRequest.toJson());

        final responseBody = jsonDecode(response.body);
        print(responseBody);
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

  Future<BaseResponse<void>> updatePhone(String phone) async {
    if (await internetConnectionChecker.hasConnection) {
      String? token = await TokenManager.getToken();

      try {
        final url =
            Uri.parse('${ApiSetting.updatePhoneNumber}?newPhoneNumber=$phone');
        debugPrint('Request URL: $url');

        final response = await apiController.post(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        debugPrint('Status Code: ${response.statusCode}');
        debugPrint('Response Body: "${response.body}"');

        if (response.body.isEmpty) {
          throw Exception('Response body is empty');
        }

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
        debugPrint('Unexpected Error in updatePhoneNumber: $e');
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
      print("lllllllllllllllllllllllllllllllllllllllllllll");
      print(token);
      print(fcmToken);
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

  Future<BaseResponse<PhoneNumberVerifyModel>> phoneNumberVerify(
      String countryCode, String phoneNumber) async {
    String? token = await TokenManager.getToken();

    if (await internetConnectionChecker.hasConnection) {
      try {
        final uri = Uri.parse(
            '${ApiSetting.phoneNumberVerify}?CountryCode=$countryCode&PhoneNumber=$phoneNumber');

        final response = await apiController.post(
          uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        final responseBody = jsonDecode(response.body);

        print(responseBody);
        print(response.statusCode);

        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        return BaseResponse<PhoneNumberVerifyModel>.fromJson(
          responseBody,
          (data) => PhoneNumberVerifyModel.fromJson(data),
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

  Future<BaseResponse<UserModel>> sendVerificationCode2(
      String phoneNumber, String code) async {
    if (await internetConnectionChecker.hasConnection) {
      String? token = await TokenManager.getToken();

      try {
        final response = await apiController.post(
          Uri.parse(
            '${ApiSetting.sendVerificationCode2}?phone=$phoneNumber&code=$code',
          ),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.body.isEmpty) {
          throw Exception('Empty response from server.');
        }

        final responseBody = jsonDecode(response.body);

        if (response.statusCode >= 400) {
          throw Exception(responseBody['message'] ?? 'Verification failed');
        }
        String phone = responseBody['data']['phone'];
        await TokenManager.savePhone(phone);

        return BaseResponse<UserModel>.fromJson(
          responseBody,
          (data) => UserModel.fromJson(data),
        );
      } on TimeoutException catch (e) {
        debugPrint('Timeout Exception: $e');
        throw TimeoutException('Request timed out, please try again.');
      } catch (e) {
        debugPrint('Unexpected Error: $e');
        throw Exception(e.toString());
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }
}
