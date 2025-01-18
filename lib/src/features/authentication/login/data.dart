// ignore_for_file: use_build_context_synchronously
import 'dart:convert' as convert;
import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../core/constants/url.dart';
import '../../../core/network/global_token.dart';
import 'domain.dart';

class ApiLoginService {
  final String baseUrl = "${Url.baseUrl}/api/account/login";


  Future<LoginResponse> login(String email, String password) async {
    final url = Uri.parse(baseUrl);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode(
          {'email': email, 'password': password, 'fcmToken': 'string'}),
    );

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);

      if (data['data'] != null) {
        return LoginResponse.fromJson(data);
      } else {
        throw Exception('Login failed: data is null');
      }
    } else {
      throw Exception('Failed to login');
    }
  }
  Future<void> registerDevice() async {

    try {
      // Get Package Info
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final String appVersion = '${packageInfo.version}+${packageInfo.buildNumber}';
      String? token = await TokenManager.getToken();
      String? fcmToken = await TokenManager.getFcmToken();
      final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

      // Get Device Info
      late final String deviceId;
      late final String deviceType;
      late final String osVersion;

      if (Platform.isAndroid) {
        final AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
        deviceId = androidInfo.id;
        deviceType = '${androidInfo.brand} ${androidInfo.model}';
        osVersion = 'Android ${androidInfo.version.release}';
      } else if (Platform.isIOS) {
        final IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? 'Unknown';
        deviceType = iosInfo.model ?? 'iOS Device';
        osVersion = '${iosInfo.systemName} ${iosInfo.systemVersion}';
      } else {
        throw PlatformException(
          code: 'UNSUPPORTED_PLATFORM',
          message: 'This platform is not supported',
        );
      }

      print(json.encode({
        'tokenText': fcmToken,
        'deviceId': deviceId,
        'deviceType': deviceType,
        'osVersion': osVersion,
        'appVersion': appVersion,
      }));

      final response = await http.post(
        Uri.parse('http://ebrahim995-001-site3.ktempurl.com/api/account/CreateToken'),
        headers: {
          'Authorization':'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'tokenText': fcmToken,
          'deviceId': deviceId,
          'deviceType': deviceType,
          'osVersion': osVersion,
          'appVersion': appVersion,
        }),
      );

      if (response.statusCode == 200) {
        print('Device token registered successfully');
      } else {
        print('Failed to register device token: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to register device: ${response.statusCode}');
      }
    } catch (e) {
      print('Error registering device token: $e');
    }
  }



}
Future<void> resetFirstTimeStatus() async {

  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(FIRST_TIME_KEY, true);
}
Future<void> logout(BuildContext context,{bool resetFirstTime = false}) async {
  final bool? confirmLogout = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      title: const Row(
        children: [
          Icon(FontAwesomeIcons.rightFromBracket,
              color: AppColors.secondaryColor, size: 24.0),
          AppSizedBox.kWSpace10,
          Center(
            child: CustomStyledText(
              text: 'تأكيد تسجيل الخروج',
              textColor: AppColors.secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: const CustomStyledText(
        text: 'هل أنت متأكد أنك تريد تسجيل الخروج؟',
        fontSize: 14,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(
            backgroundColor: AppColors.secondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const CustomStyledText(
              text: "تسجيل الخروج",
              textColor: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const CustomStyledText(
              text: "إلغاء",
              fontSize: 12,
              textColor: AppColors.darkGrayColor,
              fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );

  if (confirmLogout == true) {

    try {
      await TokenManager.removeToken();
      if (resetFirstTime) {
        await resetFirstTimeStatus();
      }
    } catch (e) {
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
          (Route<dynamic> route) => false,
    );
  }
}


