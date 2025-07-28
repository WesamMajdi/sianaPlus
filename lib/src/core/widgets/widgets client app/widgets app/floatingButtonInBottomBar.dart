import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/category/category_screen.dart';

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
        backgroundColor: AppColors.secondaryColor,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const CategoryPage()),
          );
        },
        child: Icon(
          FontAwesomeIcons.store,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
