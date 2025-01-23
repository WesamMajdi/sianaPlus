// ignore_for_file: use_build_context_synchronously
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/network/api_setting.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/home/home_screen.dart';
import 'domain.dart';

class ApiLoginService {
  final String baseUrl = "${ApiSetting.baseUrl}/account/login";

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

      final role = data['data']['role'];
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('role', role);

      if (data['data'] != null) {
        return LoginResponse.fromJson(data);
      } else {
        throw Exception('Login failed: data is null');
      }
    } else {
      throw Exception('Failed to login');
    }
  }
}

Future<void> logout(BuildContext context) async {
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
