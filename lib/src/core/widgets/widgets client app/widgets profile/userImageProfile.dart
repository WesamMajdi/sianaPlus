import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class UserImageProfile extends StatelessWidget {
  const UserImageProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          ClipOval(
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const OnTapViewImageProfile();
                    },
                  );
                },
                child: Ink.image(
                  image: const AssetImage("assets/images/user.png"),
                  fit: BoxFit.cover,
                  width: 110,
                  height: 110,
                  child: InkWell(onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangeUserProfile(),
                        ));
                  }),
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            child: UpdateImageInUserProfile(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
