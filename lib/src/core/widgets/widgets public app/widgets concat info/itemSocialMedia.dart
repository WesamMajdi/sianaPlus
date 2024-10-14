// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class ConcatInfoFromSocialMedia extends StatelessWidget {
  const ConcatInfoFromSocialMedia({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BuildButtonSocialMedia(
              icon: FontAwesomeIcons.youtube,
              text: 'يوتيوب',
              iconColor: Colors.red,
              ontap: () {},
            ),
            const SizedBox(
              height: 50,
              child: VerticalDivider(
                color: Colors.black26,
              ),
            ),
            BuildButtonSocialMedia(
              icon: FontAwesomeIcons.whatsapp,
              text: 'واتساب',
              iconColor: const Color.fromARGB(255, 15, 131, 19),
              ontap: () {},
            ),
            const SizedBox(
              height: 50,
              child: VerticalDivider(
                color: Colors.black26,
              ),
            ),
            BuildButtonSocialMedia(
              icon: FontAwesomeIcons.instagram,
              text: 'انستقرام',
              iconColor: const Color.fromARGB(255, 193, 53, 132),
              ontap: () {},
            ),
          ],
        ));
  }
}

class BuildButtonSocialMedia extends StatelessWidget {
  const BuildButtonSocialMedia({
    Key? key,
    required this.icon,
    required this.text,
    required this.iconColor,
    required this.ontap,
  }) : super(key: key);
  final IconData icon;
  final String text;
  final Color iconColor;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(vertical: 4),
      onPressed: ontap,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          FaIcon(
            icon,
            color: iconColor,
          ),
          AppSizedBox.kVSpace10,
          CustomStyledText(
            text: text,
            fontSize: 16,
          ),
        ],
      ),
    );
  }
}
