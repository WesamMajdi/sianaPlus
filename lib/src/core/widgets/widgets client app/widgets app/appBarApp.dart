// ignore: file_names
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class AppBarApplication extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final List<Widget>? actions;

  const AppBarApplication({
    super.key,
    required this.text,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
            weight: 100,
            size: 32,
            color: (Theme.of(context).brightness == Brightness.dark
                ? AppColors.lightGrayColor
                : Colors.black)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Container(
          margin: const EdgeInsets.only(left: 20),
          child: Center(
            child: CustomStyledText(
              text: text,
              fontWeight: FontWeight.bold,
              textColor: AppColors.secondaryColor,
              fontSize: 22,
            ),
          ),
        ),
        actions: actions);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AppBarApplicationArrow extends StatelessWidget
    implements PreferredSizeWidget {
  final String text;
  final List<Widget>? actions;
  const AppBarApplicationArrow({
    super.key,
    required this.text,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.withOpacity(0.2)),
              child: const Icon(
                FontAwesomeIcons.arrowRight,
                size: 20,
              ),
            ),
          ),
        ),
        iconTheme: IconThemeData(
          color: (Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Container(
          margin: const EdgeInsets.only(left: 60),
          child: Center(
            child: CustomStyledText(
              text: text,
              textColor: AppColors.secondaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        actions: actions);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
