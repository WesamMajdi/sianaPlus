import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class FloatingButtonInBottomBar extends StatelessWidget {
  const FloatingButtonInBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    return Visibility(
      visible: !isKeyboardVisible,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: (Theme.of(context).brightness == Brightness.dark
            ? AppColors.lightGrayColor
            : AppColors.primaryColor),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SearchProductPage()),
          );
        },
        child: Icon(
          FontAwesomeIcons.magnifyingGlass,
          size: 20,
          color: (Theme.of(context).brightness == Brightness.dark
              ? AppColors.primaryColor
              : AppColors.lightGrayColor),
        ),
      ),
    );
  }
}
