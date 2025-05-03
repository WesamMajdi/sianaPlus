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

    String? token = prefs.getString('token');
    String? role = prefs.getString('role');

    if (!mounted) return;

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
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }

  Future<void> _checkInternetConnection() async {
    bool isConnected = await hasInternetConnection();
    if (isConnected) {
      _initializeApp();
    } else {
      // _showNoInternetDialog();
    }
  }

  void _showNoInternetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.signal_wifi_off, color: Colors.red, size: 24.0),
            SizedBox(width: 10),
            Text("لا يوجد اتصال بالإنترنت",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.black)),
          ],
        ),
        content: const Text(
            "يرجى التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى.",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _checkInternetConnection();
            },
            style: TextButton.styleFrom(backgroundColor: Colors.blue),
            child: const Text("إعادة المحاولة",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(backgroundColor: Colors.grey[200]),
            child: const Text("إغلاق",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/logoSplash.gif'),
          ],
        ),
      ),
    );
  }
}
