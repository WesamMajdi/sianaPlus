import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
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
  void _initializeApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? role = prefs.getString('role');
    print(role);
    if (role == 'MaintenanceTechnician') {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
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
          builder: (context) => const HomeDeliveryMaintenanceScreen(),
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
  }

  @override
  void initState() {
    super.initState();

    _initializeApp();
  }

  Future<void> _checkInternetConnection() async {
    bool isConnected = await hasInternetConnection();
    if (isConnected) {
      _initializeApp();
    } else {
      _showNoInternetDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: AppColors.secondaryColor,
      child: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logoSplash.gif',
            ),
          ],
        ),
      ),
    ));
  }

  void _showNoInternetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.signal_wifi_off,
                color: AppColors.secondaryColor, size: 24.0),
            AppSizedBox.kWSpace10,
            CustomStyledText(
                text: "لا يوجد اتصال بالإنترنت",
                fontSize: 20,
                fontWeight: FontWeight.w900,
                textColor: AppColors.darkGrayColor),
          ],
        ),
        content: const CustomStyledText(
          text: "يرجى التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى.",
          fontSize: 14,
          fontWeight: FontWeight.w700,
          textColor: Colors.grey,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _checkInternetConnection();
            },
            style: TextButton.styleFrom(
              backgroundColor: AppColors.secondaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const CustomStyledText(
                text: "إعادة المحاولة",
                textColor: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const CustomStyledText(
                text: "إغلاق",
                textColor: AppColors.darkGrayColor,
                fontWeight: FontWeight.bold),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
