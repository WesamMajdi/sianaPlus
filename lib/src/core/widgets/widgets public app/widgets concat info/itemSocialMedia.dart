// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:url_launcher/url_launcher.dart';

class ConcatInfoFromSocialMedia extends StatelessWidget {
  const ConcatInfoFromSocialMedia({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        BuildButtonSocialMedia(
          icon: FontAwesomeIcons.tiktok,
          text: 'تيك توك',
          iconColor: Colors.black,
          ontap: () async {
            final Uri url = Uri.parse(
                'https://www.tiktok.com/@sianaplus?_t=ZS-8wry9XEg0tE&_r=1');
            try {
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              }
            } catch (e) {
              print("Error launching WhatsApp: $e");
            }
          },
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
          ontap: () async {
            final Uri url =
                Uri.parse('https://api.whatsapp.com/send/?phone=966564935425');
            try {
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              }
            } catch (e) {
              print("Error launching WhatsApp: $e");
            }
          },
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
          ontap: () async {
            final Uri url = Uri.parse(
                'https://www.instagram.com/sianaplus?igsh=ejVqYjNreXNmcmlh');
            try {
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              }
            } catch (e) {
              print("Error launching WhatsApp: $e");
            }
          },
        ),
        const SizedBox(
          height: 50,
          child: VerticalDivider(
            color: Colors.black26,
          ),
        ),
        BuildButtonSocialMedia(
          icon: FontAwesomeIcons.snapchat,
          text: 'سناب شات',
          iconColor: Colors.amber,
          ontap: () async {
            final Uri url = Uri.parse(
                'https://www.snapchat.com/add/sianaplus?share_id=Q2NRqRVo-VI&locale=ar-PS');
            try {
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              }
            } catch (e) {
              print("Error launching WhatsApp: $e");
            }
          },
        ),
      ],
    );
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
            size: 20,
          ),
          AppSizedBox.kVSpace10,
          CustomStyledText(
            text: text,
            fontSize: 14,
          ),
        ],
      ),
    );
  }
}
