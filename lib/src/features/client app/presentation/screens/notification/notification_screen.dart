import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: MyDrawer(),
      appBar: AppBarApplication(
        text: 'الإشعارات',
      ),
      body: ItemsNotifications(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingButtonInBottomBar(),
      bottomNavigationBar: BottomAppBarApplication(currentIndex: 2),
    );
  }
}
