import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class FloatingButtonInBottomBar extends StatelessWidget {
  const FloatingButtonInBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: AppColors.secondaryColor,
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SearchProductPage()),
        );
      },
      child: const Icon(
        FontAwesomeIcons.magnifyingGlass,
        size: 20,
        color: Colors.white,
      ),
    );
  }
}
