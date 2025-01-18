import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/client app/presentation/controller/cubits/notification_cubit.dart';
import '../../../../features/client app/presentation/controller/states/notification_state.dart';
import '../../../constants/constants.dart';
import '../../../export file/exportfiles.dart';

class ItemsNotifications extends StatefulWidget {
  const ItemsNotifications({super.key});

  @override
  State<ItemsNotifications> createState() => _ItemsNotificationsState();
}

class _ItemsNotificationsState extends State<ItemsNotifications> {
  @override
  void initState() {
    super.initState();  // Move super.initState() to the top
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
            return Center(child: Text(state.errorMessage));
          case NotificationStatus.success:
            if (state.notifications.isNotEmpty) {
              return ListView.builder(  // Added return statement
                scrollDirection: Axis.vertical,
                itemCount: state.notifications.length,
                itemBuilder: (BuildContext context, int index) {
                  final notification = state.notifications[index];  // Use the notification object
                  return Column(
                    children: [
                      ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3)
                        ),
                        leading: CircleAvatar(
                          backgroundColor: AppColors.secondaryColor,
                          child: Image.asset(
                          'assets/images/logo.png' ?? '', // Use null safety
                            width: 100,
                            height: 100,
                          ),
                        ),
                        title: CustomStyledText(
                            text: notification.title ?? '',  // Use null safety
                            fontSize: 18
                        ),
                        subtitle: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: AppPadding.smallPadding),
                                  child: CustomStyledText(
                                    text: notification.message!,  // Fixed string interpolation
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
            } else {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,  // Added for better centering
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomStyledText(text: 'لا توجد اشعارات')
                  ],
                ),
              );
            }
        }
        return const Center(  // Changed to be more descriptive and consistent
          child: Text('Something went wrong'),
        );
      },
    );
  }
}