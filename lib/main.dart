// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maintenance_app/src/core/di/dependency_injection.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/network/connectivity_cubit.dart';
import 'package:maintenance_app/src/core/services/notification_service.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20public%20app/widgets%20style/showTopSnackBar.dart';
import 'package:maintenance_app/src/features/authentication/presentation/controller/cubit/auth_cubit.dart';
import 'package:maintenance_app/src/features/authentication/presentation/screens/login_screen.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/category_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/notification_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/order_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/profile_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/concat%20info%20page/application.dart';
import 'package:maintenance_app/src/features/client%20app/concat%20info%20page/data.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/category/category_screen.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/home/home_screen.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/controller/cubit/delivery_maintenance_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/controller/Cubit/delivery_shop_cubit.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/controller/cubit/hand_receipt_maintenance_parts/maintenance_parts_cubit.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/controller/cubit/online_maintenance_parts/online_maintenance_parts_cubit.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/controller/cubit/recovered_maintenance_parts/recovered_maintenance_parts_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'maintance-app',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService().initialize();

  await init();
  final localizationBloc = LocalizationBloc();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final themeChangerBloc = ThemeChangerBloc(prefs);
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
      .then((Position position) async {
    debugPrint(position.latitude.toString());
    debugPrint(position.longitude.toString());

    await prefs.setDouble('latitude', position.latitude);
    await prefs.setDouble('longitude', position.longitude);
  }).catchError((e) {});

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeChangerBloc>.value(value: themeChangerBloc),
        BlocProvider<LocalizationBloc>.value(value: localizationBloc),
        BlocProvider<ConnectivityCubit>(
          create: (context) => ConnectivityCubit(),
        ),
        BlocProvider<ContactUsCubit>(
          create: (context) => ContactUsCubit(ApiContactUsService()),
        ),
        BlocProvider<CategoryCubit>(
          create: (context) => getIt<CategoryCubit>()
            ..fetchCategories()
            ..getProductFavorite(),
        ),
        BlocProvider<OrderCubit>(
          create: (context) => getIt<OrderCubit>()..initOrdersRequirements(),
        ),
        BlocProvider<HandReceiptCubit>(
          create: (context) => getIt<HandReceiptCubit>()..fetchHandReceipts(),
        ),
        BlocProvider<ReturnHandReceiptCubit>(
          create: (context) =>
              getIt<ReturnHandReceiptCubit>()..getAllReturnHandReceiptItems(),
        ),
        BlocProvider<NotificationCubit>(
          create: (context) => getIt<NotificationCubit>()..getNotifications(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => getIt<ProfileCubit>()..getUserProfile(),
        ),
        BlocProvider<DeliveryShopCubit>(
          create: (context) => getIt<DeliveryShopCubit>()
            ..fetchReceiveOrder()
            ..deliveryShopUseCase,
        ),
        BlocProvider<DeliveryMaintenanceCubit>(
          create: (context) => getIt<DeliveryMaintenanceCubit>()
            ..fetchReceiveMaintenanceOrder()
            ..deliveryMaintenanceUseCase,
        ),
        BlocProvider<AuthCubit>(
          create: (context) => getIt<AuthCubit>()..authUseCase,
        ),
        BlocProvider<OnlineCubit>(
          create: (context) => getIt<OnlineCubit>()
            ..fetchOnline()
            ..onlineUseCase,
        ),
      ],
      child: MyApp(themeChangerBloc: themeChangerBloc),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
    required this.themeChangerBloc,
  }) : super(key: key);
  final ThemeChangerBloc themeChangerBloc;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data.containsKey('page_id')) {
        String pageId = message.data['page_id']!;
        int id = int.tryParse(pageId) ?? 0;
        // ignore: use_build_context_synchronously
        navigateToPageById(context, id);
      }
    });
    checkInitialMessage();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        if (!mounted) return;

        showTopSnackBar(
          context,
          message.notification!.title ?? "إشعار جديد",
          Colors.green,
        );
      }
    });
  }

  void checkInitialMessage() async {
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();
    if (message != null && message.data.containsKey('page_id')) {
      String pageId = message.data['page_id']!;
      int id = int.tryParse(pageId) ?? 0;
      // ignore: use_build_context_synchronously
      navigateToPageById(context, id);
    }
  }

  void navigateToPageById(BuildContext context, int pageId) {
    switch (pageId) {
      case 1:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
        break;
      case 2:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const CategoryPage()),
        );
        break;
      case 3:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MaintenanceRequestPage()),
        );
        break;
      default:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LocalizationBloc>(
            create: (context) => LocalizationBloc(),
          ),
          BlocProvider<ThemeChangerBloc>(
            create: (context) => widget.themeChangerBloc,
          ),
        ],
        child: BlocBuilder<ThemeChangerBloc, ThemeChangerState>(
          builder: (context, themeState) {
            return MaterialApp(
              navigatorKey: NavigationService.navigatorKey,
              initialRoute: "/",
              title: kAppName,
              theme: themeState.themeType == ThemeType.light
                  ? ThemeData.light()
                  : ThemeData.dark(),
              themeMode: ThemeMode.system,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: const Locale('ar'),
              home: ScreenUtilInit(
                designSize: const Size(360, 640),
                splitScreenMode: true,
                builder: (context, state) {
                  return MultiBlocListener(listeners: [
                    BlocListener<ConnectivityCubit, ConnectivityStatus>(
                      listener: (context, status) async {
                        if (status == ConnectivityStatus.disconnected) {
                          _showNoConnectionBanner(
                              context, ConnectivityStatus.disconnected);
                        }

                        if (status == ConnectivityStatus.connected) {
                          _showNoConnectionBanner(
                              context, ConnectivityStatus.connected);
                        }
                      },
                    ),
                  ], child: const SplashPage());
                },
              ),
            );
          },
        ));
  }

  void _showNoConnectionBanner(
      BuildContext context, ConnectivityStatus disconnected) {
    switch (disconnected) {
      case ConnectivityStatus.connected:
        // showTopSnackBar(context, 'تم الاتصال بالانترنت', Colors.green.shade800);
        break;
      case ConnectivityStatus.disconnected:
        showTopSnackBar(context, 'لا يوجد اتصال بالإنترنت', Colors.red);

        break;
    }
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
