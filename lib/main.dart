// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maintenance_app/src/core/di/dependency_injection.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/network/connectivity_cubit.dart';
import 'package:maintenance_app/src/core/services/notification_service.dart';
import 'package:maintenance_app/src/features/authentication/login/application.dart';
import 'package:maintenance_app/src/features/authentication/login/data.dart';
import 'package:maintenance_app/src/features/authentication/sign%20up/application.dart';
import 'package:maintenance_app/src/features/authentication/sign%20up/data.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/category_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/notification_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/order_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/profile_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/concat%20info%20page/application.dart';
import 'package:maintenance_app/src/features/client%20app/concat%20info%20page/data.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/controller/maintenance_parts/maintenance_parts_cubit.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/screens/home_maintenance/home_maintenance_screen.dart';
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
  String? token = prefs.getString('token');

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
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(ApiLoginService()),
        ),
        BlocProvider<SignUpCubit>(
          create: (context) => SignUpCubit(ApiSignUpService()),
        ),
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
        BlocProvider<NotificationCubit>(
          create: (context) => getIt<NotificationCubit>()..getNotifications(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => getIt<ProfileCubit>()..getUserProfile(),
        ),
      ],
      child:
          MyApp(themeChangerBloc: themeChangerBloc, isLoggedIn: token != null),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.themeChangerBloc,
    required this.isLoggedIn,
  }) : super(key: key);
  final ThemeChangerBloc themeChangerBloc;
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LocalizationBloc>(
            create: (context) => LocalizationBloc(),
          ),
          BlocProvider<ThemeChangerBloc>(
            create: (context) => themeChangerBloc,
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
                  ], child: const HomeMaintenanceScreen());
                  // return ;
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const CustomStyledText(
              text: 'تم الاتصال بالانترنت', textColor: Colors.white),
          backgroundColor: Colors.green.shade800,
        ));

        break;
      case ConnectivityStatus.disconnected:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const CustomStyledText(
                text: 'لا يوجد اتصال بالإنترنت', textColor: Colors.white),
            backgroundColor: Colors.red.shade800));
        break;
    }
  }

  // context
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
