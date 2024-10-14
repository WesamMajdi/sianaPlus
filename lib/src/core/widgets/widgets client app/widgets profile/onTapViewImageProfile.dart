import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class OnTapViewImageProfile extends StatelessWidget {
  const OnTapViewImageProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Hero(
          tag: 'userImage',
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Image.asset(
              "assets/images/user.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
