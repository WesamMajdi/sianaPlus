import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class ItemsNotifications extends StatelessWidget {
  const ItemsNotifications({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: notifications.length,
      itemBuilder: (BuildContext context, int index) {
        final notification = notifications[index];
        return Column(
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3)),
              leading: CircleAvatar(
                backgroundColor: AppColors.secondaryColor,
                child: Image.asset(
                  notification.imagePath,
                  width: 100,
                  height: 100,
                ),
              ),
              title: CustomStyledText(text: notification.title, fontSize: 18),
              subtitle: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: AppPadding.smallPadding),
                        child: CustomStyledText(
                          text:
                              "${notification.dateTime.month.toString()}/${notification.dateTime.day.toString()}/${notification.dateTime.year.toString()}",
                          textColor: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: AppPadding.smallPadding),
                        child: CustomStyledText(
                          text:
                              '0${notification.dateTime.hour.toString()}:00 Pm',
                          textColor: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              onTap: () {},
            ),
            const Divider()
          ],
        );
      },
    );
  }
}
