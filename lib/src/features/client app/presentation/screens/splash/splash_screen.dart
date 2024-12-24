import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    });
    //_checkInternetConnection();
  }

  Future<void> _checkInternetConnection() async {
    bool isConnected = await hasInternetConnection();

    if (isConnected) {
      Timer(const Duration(seconds: 5), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      });
    } else {
      _showNoInternetDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            color: AppColors.secondaryColor,
          ),
          Image.asset(
            'assets/images/siana_plus_logo.png',
            height: ScreenUtil().setWidth(300),
            width: ScreenUtil().setHeight(300),
          ),
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.only(bottom: AppPadding.mediumPadding),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  child: Lottie.asset(
                    'assets/animations/loading_tool.json',
                    fit: BoxFit.fill,
                    width: ScreenUtil().setWidth(100),
                    height: ScreenUtil().setHeight(100),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
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
