import 'package:maintenance_app/src/core/network/api_setting.dart';

import 'domain.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ApiSignUpService {
  final String baseUrl = "${ApiSetting.baseUrl}/account/registerCustomer";

  Future<SignUpResponse> signUp(String fullName, String email, String password,
      String confirmPassword, String phoneNumber, String countryCode) async {
    final url = Uri.parse(baseUrl);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode({
        'fullName': fullName,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'phoneNumber': phoneNumber,
        'countryCode': countryCode,
      }),
    );

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return SignUpResponse.fromJson(data);
    } else {
      throw Exception('Failed to register');
    }
  }
}
