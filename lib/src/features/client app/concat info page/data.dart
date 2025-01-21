import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/network/api_setting.dart';
import 'domain.dart';

class ApiContactUsService {
  final String contactUsUrl =
      "${ApiSetting.baseUrl}/Communication/CreateContactUs";

  Future<ContactUsResponse> createContactUs(
      String fullName, String email, String phoneNumber, String message) async {
    final url = Uri.parse(contactUsUrl);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: convert.jsonEncode({
        'fullName': fullName,
        'email': email,
        'phoneNumber': phoneNumber,
        'message': message,
      }),
    );
    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      return ContactUsResponse.fromJson(data);
    } else {
      throw Exception('Failed to send message');
    }
  }
}
