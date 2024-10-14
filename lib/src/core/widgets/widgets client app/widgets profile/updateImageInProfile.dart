import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class UpdateImageInUserProfile extends StatelessWidget {
  const UpdateImageInUserProfile({super.key, required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: buildCircle(
        color: AppColors.secondaryColor,
        all: 4,
        child: buildCircle(
          color: color,
          all: 6,
          child: const Icon(
            Icons.camera_alt,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}

Widget buildCircle({
  required Widget child,
  required double all,
  required Color color,
}) =>
    ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
