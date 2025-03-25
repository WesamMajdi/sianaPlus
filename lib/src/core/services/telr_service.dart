import 'dart:convert';
import 'package:http/http.dart' as http;

class TelrService {
  static Future<String?> createPayment(double totalAmount) async {
    print(totalAmount);
    final url = Uri.parse("https://secure.telr.com/gateway/order.json");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "method": "create",
        "store": "32217",
        "authkey": "kpDGr^vFDj@VXFJ6",
        "order": {
          "cartid": "123456",
          "test": 1,
          "amount": totalAmount.toString(),
          "currency": "SAR",
          "description": "شراء منتج"
        },
        "return": {
          "authorised":
              "http://ebrahim995-001-site3.ktempurl.com/api/Orders/Success",
          "declined":
              "http://ebrahim995-001-site3.ktempurl.com/api/Orders/Failed",
          "cancelled":
              "http://ebrahim995-001-site3.ktempurl.com/api/Orders/Cancelled"
        }
      }),
    );
    print(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String? paymentUrl = data['order']['url'];
      return paymentUrl;
    } else {
      print("Error: ${response.body}");
      return null;
    }
  }
}
