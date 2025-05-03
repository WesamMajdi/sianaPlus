import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/home/home_screen.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/home_delivery_maintenance/home_delivery_maintenance_screen.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/screens/home_delivery/home_delivery_shop_screen.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/screens/home_maintenance/home_maintenance_screen.dart';

class FailedScreen extends StatelessWidget {
  final String message;

  const FailedScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/failure.json',
              width: 300,
              height: 300,
              repeat: false,
              delegates: LottieDelegates(
                values: [
                  ValueDelegate.color(
                    const ['**'],
                    value: Colors.red,
                  ),
                ],
              ),
            ),
            AppSizedBox.kVSpace20,
            AppSizedBox.kVSpace20,
            Text(
              " $message!!",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                fontFamily: "Tajawal",
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            CustomButton(
                text: "العودة لصفحة الرئيسية",
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  String? token = prefs.getString('token');
                  String? role = prefs.getString('role');

                  if (token != null && role != null) {
                    if (role == 'MaintenanceTechnician') {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeMaintenanceScreen(),
                        ),
                      );
                    } else if (role == 'Customer') {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    } else if (role == 'DeliveryShop') {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeDeliveryScreen(),
                        ),
                      );
                    } else if (role == 'DeliveryMaintenance') {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const HomeDeliveryMaintenanceScreen(),
                        ),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    }
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
