import '../../../../features/client app/presentation/controller/cubits/notification_cubit.dart';
import '../../../../features/client app/presentation/controller/states/notification_state.dart';
import '../../../export file/exportfiles.dart';

class ItemsNotifications extends StatefulWidget {
  const ItemsNotifications({super.key});

  @override
  State<ItemsNotifications> createState() => _ItemsNotificationsState();
}

class _ItemsNotificationsState extends State<ItemsNotifications> {
  @override
  void initState() {
    super.initState(); // Move super.initState() to the top
    context.read<NotificationCubit>().getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        switch (state.notificationStatus) {
          case NotificationStatus.initial:
          case NotificationStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case NotificationStatus.failure:
            return Center(child: CustomStyledText(text: state.errorMessage));
          case NotificationStatus.success:
            if (state.notifications.isNotEmpty) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: state.notifications.length,
                itemBuilder: (BuildContext context, int index) {
                  final notification =
                      state.notifications[index]; // Use the notification object
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            'assets/images/ic_launcher.png' ?? '',
                            width: 100,
                          ),
                        ),
                        title: CustomStyledText(
                            text: notification.title ?? '', fontSize: 16),
                        subtitle: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: CustomStyledText(
                                    text: notification.message!,
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
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          color: Colors.grey.shade300,
                        ),
                      )
                    ],
                  );
                },
              );
            } else {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [CustomStyledText(text: 'لا توجد اشعارات')],
                ),
              );
            }
        }
      },
    );
  }
}
