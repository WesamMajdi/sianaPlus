import 'dart:convert';
import 'package:http/http.dart' as http;

class TelrService {
  static Future<String?> createPayment() async {
    final url = Uri.parse("https://secure.telr.com/gateway/order.json");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "method": "create",
        "store": "YOUR_STORE_ID",
        "authkey": "YOUR_API_KEY",
        "order": {
          "cartid": "123456",
          "amount": "10.00",
          "currency": "AED",
          "description": "شراء منتج"
        },
        "customer": {"name": "John Doe", "email": "johndoe@example.com"},
        "return": {"url": "yourapp://payment-success"}
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final ref = data['order']['ref'];
      return "https://secure.telr.com/gateway/process.html?ref=$ref";
    } else {
      print("Error: ${response.body}");
      return null;
    }
  }
}
