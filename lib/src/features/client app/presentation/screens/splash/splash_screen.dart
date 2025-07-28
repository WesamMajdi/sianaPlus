import 'package:flutter/material.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/onboardingPage/onboardin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:maintenance_app/src/features/authentication/presentation/screens/login_screen.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/home/home_screen.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/home_delivery_maintenance/home_delivery_maintenance_screen.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/screens/home_delivery/home_delivery_shop_screen.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/screens/home_maintenance/home_maintenance_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  void _initializeApp() async {
    await Future.delayed(const Duration(seconds: 3));
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    print(prefs.getBool('isFirstTime'));
    print("ssssssssssssssssssssssssssssssssssssssssss");

    if (isFirstTime) {
      _goTo(OnboardingScreen(onFinish: () async {
        await prefs.setBool('isFirstTime', false);
        _initializeApp();
      }));
    }

    String? token = prefs.getString('token');
    String? role = prefs.getString('role');

    if (token == null || role == null) {
      _goTo(const LoginScreen());
      return;
    }

    switch (role) {
      case 'MaintenanceTechnician':
        _goTo(const HomeMaintenanceScreen());
        break;
      case 'Customer':
        _goTo(const HomePage());
        break;
      case 'DeliveryShop':
        _goTo(const HomeDeliveryScreen());
        break;
      case 'DeliveryMaintenance':
        _goTo(const HomeDeliveryMaintenanceScreen());
        break;
      default:
        _goTo(const LoginScreen());
    }
  }

  void _goTo(Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Image(
            image: AssetImage('assets/images/logoSplash.gif'),
            width: 1000,
            height: 1000,
          ),
        ),
      ),
    );
  }
}
