// ignore: use_key_in_widget_constructors
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/screens/current_order/current_order_screen.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/screens/pervious_order/pervious_order_screen.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/screens/receive_order/receive_order_screen.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/screens/profile_maintenance/profile_maintenance.dart';

class HomeDeliveryScreen extends StatefulWidget {
  const HomeDeliveryScreen({super.key});

  @override
  State<HomeDeliveryScreen> createState() => _HomeDeliveryScreenState();
}

class _HomeDeliveryScreenState extends State<HomeDeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarApplication(text: "الرئيسية"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserProfileMaintenancePage(),
                    ),
                  );
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.primaryColor,
                        AppColors.secondaryColor,
                      ],
                      stops: [
                        0.0,
                        1.0,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20),
                        child: Container(
                          width: 73,
                          height: 73,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x33000000),
                                blurRadius: 6.0,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/images/5162780.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomStyledText(
                            text: 'مرحبًا بِكَ عزيزيّ',
                            textColor: Colors.white,
                            fontSize: 20,
                          ),
                          AppSizedBox.kVSpace5,
                          CustomStyledText(
                            text: 'طارق التري',
                            textColor: Colors.grey[400],
                            fontSize: 16,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    margin:
                        const EdgeInsets.only(top: 10, right: 30, bottom: 15),
                    child: const CustomStyledText(
                      text: 'الاختصارات',
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1.1),
                  itemCount: shortcuts.length,
                  itemBuilder: (context, index) {
                    return ShortcutHomeCard(
                      onTapAction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                shortcuts[index]['page'] as Widget,
                          ),
                        );
                      },
                      icon: shortcuts[index]['icon'] as IconData,
                      label: shortcuts[index]['label'] as String,
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

final List<Map<String, Object>> shortcuts = [
  {
    'icon': FontAwesomeIcons.line,
    'label': 'الطلبات',
    'page': const ReceiveOrderScreen(),
  },
  {
    'icon': FontAwesomeIcons.fileLines,
    'label': 'الطلبات الحالية',
    'page': const CurrentTakeOrderScreen(),
  },
  {
    'icon': FontAwesomeIcons.clockRotateLeft,
    'label': 'الطلبات السابقة',
    'page': const PerviousOrderScreen(),
  },
  {
    'icon': FontAwesomeIcons.gear,
    'label': 'الإعدادت',
    'page': const UserSettingProfile(),
  },
];

class ShortcutHomeCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final GestureTapCallback onTapAction;

  const ShortcutHomeCard(
      {super.key,
      required this.icon,
      required this.label,
      required this.onTapAction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapAction,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            margin: const EdgeInsets.all(0),
            elevation: 6,
            shape: const CircleBorder(),
            color: Colors.transparent,
            child: CircleAvatar(
              backgroundColor: AppColors.secondaryColor,
              radius: 45,
              child: Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          AppSizedBox.kVSpace10,
          CustomStyledText(
            text: label,
            fontSize: 15,
          ),
        ],
      ),
    );
  }
}
