import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localizationBloc = LocalizationBloc();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final themeChangerBloc = ThemeChangerBloc(prefs);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeChangerBloc>.value(value: themeChangerBloc),
        BlocProvider<LocalizationBloc>.value(value: localizationBloc),
      ],
      child: MyApp(themeChangerBloc: themeChangerBloc),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.themeChangerBloc,
  }) : super(key: key);
  final ThemeChangerBloc themeChangerBloc;

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
                  return const HomePage();
                },
              ),
            );
          },
        ));
  }
}
