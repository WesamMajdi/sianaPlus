import 'package:url_launcher/url_launcher.dart';

void launchTelrPayment(String paymentUrl) async {
  if (await canLaunch(paymentUrl)) {
    await launch(paymentUrl);
  } else {
    throw 'Could not launch $paymentUrl';
  }
}
