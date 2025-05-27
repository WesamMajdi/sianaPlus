// ignore: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/network/global_token.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/convert_order_maintenance/convert_current_order_maintenance_screen.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/convert_order_maintenance/convert_order_maintenance.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/convert_order_maintenance/convert_pervious_order_maintenance_screen.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/current_order_maintenance/current_order_maintenance_screen.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/outSide_order_maintenance/outside_current_order_maintenance_screen.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/outSide_order_maintenance/outside_order_maintenance.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/outSide_order_maintenance/outside_pervious_order_maintenance_screen.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/pervious_order_maintenance/pervious_order_maintenance_screen.dart';
import 'package:maintenance_app/src/features/delivery%20maintenance%20app/presentation/screens/receive_maintenances_order/receive_order_maintenances_screen.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/screens/home_delivery/home_delivery_shop_screen.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/screens/profile_maintenance/profile_maintenance.dart';

class HomeDeliveryMaintenanceScreen extends StatefulWidget {
  const HomeDeliveryMaintenanceScreen({super.key});

  @override
  State<HomeDeliveryMaintenanceScreen> createState() =>
      _HomeDeliveryMaintenanceScreenState();
}

class _HomeDeliveryMaintenanceScreenState
    extends State<HomeDeliveryMaintenanceScreen> {
  String? username = '';
  String? email = '';

  Future<void> _loadUserData() async {
    String? storedName = await TokenManager.getName();
    // String? storedEmail = await TokenManager.getEmail();

    setState(() {
      username = storedName ?? 'User';
      // email = storedEmail ?? 'user@gmail.com';
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarApplicationArrow(
          text: "الرئيسية",
          isHome: true,
        ),
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
                            text: username!,
                            textColor: Colors.grey[400],
                            fontSize: 16,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              // Row(
              //   children: [
              //     Container(
              //       alignment: Alignment.centerRight,
              //       margin:
              //           const EdgeInsets.only(top: 10, right: 30, bottom: 15),
              //       child: const CustomStyledText(
              //         text: 'الاختصارات',
              //         fontSize: 20,
              //       ),
              //     ),
              //   ],
              // ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    margin:
                        const EdgeInsets.only(top: 10, right: 30, bottom: 15),
                    child: const CustomStyledText(
                      text: 'طلبات اونلاين',
                      fontSize: 18,
                      textColor: AppColors.secondaryColor,
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
                      crossAxisCount: 2, childAspectRatio: 1.4),
                  itemCount: shortcutsMaintenance.length,
                  itemBuilder: (context, index) {
                    return ShortcutHomeCard(
                      onTapAction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                shortcutsMaintenance[index]['page'] as Widget,
                          ),
                        );
                      },
                      icon: shortcutsMaintenance[index]['icon'] as IconData,
                      label: shortcutsMaintenance[index]['label'] as String,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  color: Colors.grey.shade300,
                ),
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    margin:
                        const EdgeInsets.only(top: 10, right: 30, bottom: 15),
                    child: const CustomStyledText(
                      text: 'طلبات التحويل',
                      fontSize: 18,
                      textColor: AppColors.secondaryColor,
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
                      crossAxisCount: 2, childAspectRatio: 1.4),
                  itemCount: convertOrderMaintenance.length,
                  itemBuilder: (context, index) {
                    return ShortcutHomeCard(
                      onTapAction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => convertOrderMaintenance[index]
                                ['page'] as Widget,
                          ),
                        );
                      },
                      icon: convertOrderMaintenance[index]['icon'] as IconData,
                      label: convertOrderMaintenance[index]['label'] as String,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  color: Colors.grey.shade300,
                ),
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    margin:
                        const EdgeInsets.only(top: 10, right: 30, bottom: 15),
                    child: const CustomStyledText(
                      text: 'طلبات التحويل خارج المؤسسة',
                      fontSize: 18,
                      textColor: AppColors.secondaryColor,
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
                      crossAxisCount: 2, childAspectRatio: 1.4),
                  itemCount: outSideOrderMaintenance.length,
                  itemBuilder: (context, index) {
                    return ShortcutHomeCard(
                      onTapAction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => outSideOrderMaintenance[index]
                                ['page'] as Widget,
                          ),
                        );
                      },
                      icon: outSideOrderMaintenance[index]['icon'] as IconData,
                      label: outSideOrderMaintenance[index]['label'] as String,
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

final List<Map<String, Object>> shortcutsMaintenance = [
  {
    'icon': FontAwesomeIcons.line,
    'label': 'الطلبات',
    'page': const ReceiveOrderMaintenancesScreen(),
  },
  {
    'icon': FontAwesomeIcons.fileLines,
    'label': 'الطلبات الحالية',
    'page': const CurrentTakeOrderMaintenanceScreen(),
  },
  {
    'icon': FontAwesomeIcons.clockRotateLeft,
    'label': 'الطلبات السابقة',
    'page': const PerviousOrderMaintenanceScreen(),
  },
];
final List<Map<String, Object>> convertOrderMaintenance = [
  {
    'icon': FontAwesomeIcons.rightLeft,
    'label': 'طلبات التحويل ',
    'page': const ConvertOrderMaintenancesScreen(),
  },
  {
    'icon': FontAwesomeIcons.rightLeft,
    'label': 'تحويل القطع الحالية',
    'page': const CurrentTakeOrderMaintenanceConvertScreen(),
  },
  {
    'icon': FontAwesomeIcons.rightLeft,
    'label': 'تحويل القطع السابقة',
    'page': const PerviousTakeOrderMaintenanceConvertScreen(),
  },
];

final List<Map<String, Object>> outSideOrderMaintenance = [
  {
    'icon': FontAwesomeIcons.doorOpen,
    'label': 'طلبات تحويل لخارج ',
    'page': const OutSideOrderMaintenancesScreen(),
  },
  {
    'icon': FontAwesomeIcons.doorOpen,
    'label': 'القطع الحالية لخارج',
    'page': const CurrentTakeOrderMaintenanceOutSideScreen(),
  },
  {
    'icon': FontAwesomeIcons.doorOpen,
    'label': 'القطع السابقة لخارج',
    'page': const PerviousTakeOrderMaintenanceOutSideScreen(),
  },
  {
    'icon': FontAwesomeIcons.gear,
    'label': 'الإعدادت',
    'page': const UserSettingProfile(),
  },
];
