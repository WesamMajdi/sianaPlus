import '../../../../../core/export file/exportfiles.dart';

class DisplayPage extends StatefulWidget {
  const DisplayPage({super.key});

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      appBar: const AppBarApplicationArrow(text: "العرض"),
      body: BlocBuilder<ThemeChangerBloc, ThemeChangerState>(
          builder: (context, themeState) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 3, horizontal: AppPadding.smallPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'assets/images/light mode.png',
                        ),
                        Image.asset('assets/images/dark mode.png')
                      ],
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomStyledText(text: "فاتح"),
                      CustomStyledText(text: "داكن"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Radio(
                        fillColor:
                            MaterialStateProperty.all(AppColors.secondaryColor),
                        mouseCursor: MouseCursor.defer,
                        activeColor: Colors.black,
                        value: ThemeType.light,
                        groupValue: themeState.themeType,
                        onChanged: (value) {
                          if (value == ThemeType.light) {
                            context
                                .read<ThemeChangerBloc>()
                                .add(ToggleThemeEvent());
                          }
                        },
                      ),
                      Radio(
                        mouseCursor: MouseCursor.defer,
                        activeColor: Colors.white,
                        fillColor:
                            MaterialStateProperty.all(AppColors.secondaryColor),
                        value: ThemeType.dark,
                        groupValue: themeState.themeType,
                        onChanged: (value) {
                          if (value == ThemeType.dark) {
                            context
                                .read<ThemeChangerBloc>()
                                .add(ToggleThemeEvent());
                          }
                        },
                      ),
                    ],
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppPadding.smallPadding,
                        horizontal: AppPadding.smallPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomStyledText(
                              text: 'استخدام اعدادت الجهاز',
                              fontSize: 15,
                            ),
                            AppSizedBox.kVSpace5,
                            CustomStyledText(
                                fontSize: 12,
                                textColor: Colors.grey,
                                text:
                                    'طابق المظهر مع شاشة جهازك واعدادات السطوع'),
                          ],
                        ),
                        Switch(
                          value: _isSwitched,
                          onChanged: (value) {
                            setState(() {
                              _isSwitched = value;
                            });
                          },
                          activeColor: isDarkMode
                              ? AppColors.secondaryColor
                              : Colors.blue,
                          inactiveTrackColor:
                              isDarkMode ? Colors.grey[800] : Colors.grey[400],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
