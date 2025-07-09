import 'package:http/http.dart' as http;
import 'package:maintenance_app/src/core/network/global_token.dart';
import 'package:xml/xml.dart';

class TelrServiceXML {
  static Future<String?> createPayment(double totalAmount) async {
    print("📤 المبلغ المطلوب: $totalAmount");
    String firstName = 'Customer';
    String lastName = '';
    print("📤 المبلغ المطلوب: $totalAmount");
    String? fullName = await TokenManager.getName();
    if (fullName != null && fullName.trim().contains(' ')) {
      final parts = fullName.trim().split(' ');
      firstName = parts.first;
      lastName = parts.sublist(1).join(' ');
    } else if (fullName != null) {
      firstName = fullName.trim();
    }

    print(fullName);
    String? email = await TokenManager.getEmail();
    print(email);

    // String? phone = await TokenManager.getPhone();

    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0" encoding="UTF-8"');

    builder.element('mobile', nest: () {
      builder.element('store', nest: '32217');
      builder.element('key', nest: 'RCXvL-8XWT~xLNrm');

      builder.element('device', nest: () {
        builder.element('type', nest: 'Android');
        builder.element('id', nest: 'device-id-12345');
        builder.element('agent',
            nest: 'Mozilla/5.0 (Linux; Android 11; Mobile) AppleWebKit/537.36');
        builder.element('accept', nest: 'text/html,application/xhtml+xml');
      });
      builder.element('app', nest: () {
        builder.element('name', nest: 'MaintenancePlus');
        builder.element('version', nest: '1.0.0');
        builder.element('user', nest: 'user-12345');
        builder.element('id', nest: 'install-id-abc987');
      });
      builder.element('tran', nest: () {
        builder.element('test', nest: '0');
        builder.element('type', nest: 'paypage');
        builder.element('class', nest: 'ecom');
        builder.element('cartid', nest: '123456');
        builder.element('description', nest: 'Test Payment');
        builder.element('currency', nest: 'SAR');
        builder.element('amount', nest: totalAmount.toStringAsFixed(2));
        builder.element('ref', nest: 'ref');
      });
      builder.element('billing', nest: () {
        builder.element('name', nest: () {
          builder.element('title', nest: "Mr");
          builder.element('first', nest: firstName);
          builder.element('last', nest: lastName);
        });

        builder.element('address', nest: () {
          builder.element('line1', nest: 'Olaya Street');
          builder.element('line2', nest: 'Building 5');
          builder.element('line3', nest: 'Near Kingdom Tower');
          builder.element('city', nest: 'Riyadh');
          builder.element('region', nest: 'Central');
          builder.element('country', nest: 'SA');
          builder.element('zip', nest: '11564');
        });

        builder.element('phone', nest: '966501234567');
        builder.element('email', nest: email);
      });

      builder.element('return', nest: () {
        builder.element('success', nest: 'maintenanceplus://payment-success');
        builder.element('fail', nest: 'maintenanceplus://payment-failed');
        builder.element('cancel', nest: 'maintenanceplus://payment-cancelled');
      });
    });

    final xmlRequest = builder.buildDocument().toXmlString(pretty: true);
    print("🔧 XML Request:\n$xmlRequest");

    try {
      final response = await http.post(
        Uri.parse('https://secure.telr.com/gateway/mobile.xml'),
        headers: {'Content-Type': 'application/xml'},
        body: xmlRequest,
      );

      print('📥 Status code: ${response.statusCode}');
      print('📥 Response body: ${response.body}');

      if (response.statusCode == 200) {
        // final document = XmlDocument.parse();
        // final ref = document.findAllElements('ref').first.innerText;
        // final paymentUrl = document.findAllElements('url').first.innerText;
        final document = XmlDocument.parse(response.body);
        final startElement = document.findAllElements('start').firstOrNull;
        return startElement?.innerText;
      } else {
        print("❌ خطأ في الطلب: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("❗ فشل الاتصال بـ Telr: $e");
      return null;
    }
  }
}
