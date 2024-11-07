// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/authentication/login/application.dart';
import 'package:maintenance_app/src/features/authentication/login/data.dart';
import 'package:maintenance_app/src/features/authentication/sign%20up/application.dart';
import 'package:maintenance_app/src/features/authentication/sign%20up/data.dart';
import 'package:maintenance_app/src/features/client%20app/privacy%20and%20settings/support%20&%20about%20us%20pages/concat%20info%20page/application.dart';
import 'package:maintenance_app/src/features/client%20app/privacy%20and%20settings/support%20&%20about%20us%20pages/concat%20info%20page/data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localizationBloc = LocalizationBloc();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final themeChangerBloc = ThemeChangerBloc(prefs);
  String? token = prefs.getString('token');

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeChangerBloc>.value(value: themeChangerBloc),
        BlocProvider<LocalizationBloc>.value(value: localizationBloc),
        BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(ApiLoginService())),
        BlocProvider<SignUpCubit>(
            create: (context) => SignUpCubit(ApiSignUpService())),
        BlocProvider<ContactUsCubit>(
            create: (context) => ContactUsCubit(ApiContactUsService())),
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
              initialRoute: "/",
              title: kAppName,
              theme: themeState.themeType == ThemeType.light
                  ? ThemeData.light()
                  : ThemeData.dark(),
              themeMode: ThemeMode.system,
              // theme: ThemeData(
              //   popupMenuTheme: PopupMenuThemeData(
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //   ),
              // ),
              debugShowCheckedModeBanner: false,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: const Locale('ar'),
              home: ScreenUtilInit(
                designSize: const Size(360, 640),
                splitScreenMode: true,
                builder: (context, state) {
                  return isLoggedIn ? const HomePage() : const SplashPage();
                },
              ),
            );
          },
        ));
  }
}
