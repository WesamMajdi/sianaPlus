// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/cupertino.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/profile/update_user_profile_screen.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool? isDropdownVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarApplication(
        text: 'صفحتي الشخصية',
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
              margin: const EdgeInsets.only(top: 5),
              child: const UserImageProfile()),
          AppSizedBox.kVSpace10,
          Container(
            alignment: Alignment.center,
            child: const CustomStyledText(
              text: "مدير تطبيق",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              textColor: AppColors.secondaryColor,
            ),
          ),
          AppSizedBox.kVSpace10,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButttonProfile(
                icon: FontAwesomeIcons.penToSquare,
                text: "تعديل الملف",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangeUserProfile(),
                      ));
                },
              ),
              AppSizedBox.kWSpace10,
              CustomButttonProfile(
                text: "الاعدادات",
                icon: FontAwesomeIcons.gear,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserSettingProfile(),
                      ));
                },
              ),
            ],
          ),
          AppSizedBox.kVSpace20,
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: const CustomStyledText(
              text: "المعلومات الشخصية",
              fontWeight: FontWeight.bold,
              textColor: AppColors.secondaryColor,
              fontSize: 16,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserInfoProfile(
                  icon: CupertinoIcons.mail_solid,
                  text: "admin@gmail.com",
                ),
                Divider(),
                UserInfoProfile(
                  icon: CupertinoIcons.phone_solid,
                  text: "0599924216",
                ),
                Divider(),
                UserInfoProfile(
                  icon: CupertinoIcons.location_solid,
                  text: "السعودية , حفر الباطن , شارع رقم 56",
                ),
              ],
            ),
          ),

          AppSizedBox.kVSpace10,
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: const CustomStyledText(
              text: "الاحصائيات",
              textColor: AppColors.secondaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 1.7,
              children: const [
                StatisticsCard(title: 'عدد الطلبات الحالية', value: "10"),
                StatisticsCard(title: 'عدد الطلبات السابقة', value: "20"),
                StatisticsCard(title: 'عدد المنتجات المفضلة', value: "15"),
                StatisticsCard(title: 'مشتريات الشهر الحالي', value: "40"),
              ],
            ),
          ),

          // The table is displayed in the case of the technician application.
          //   Table(
          //   border: TableBorder(
          //     borderRadius: BorderRadius.circular(15),
          //     horizontalInside: const BorderSide(
          //       color: Colors.grey,
          //     ),
          //     verticalInside: const BorderSide(
          //       color: Colors.grey,
          //     ),
          //     top: const BorderSide(
          //       color: Colors.grey,
          //     ),
          //     bottom: const BorderSide(
          //       color: Colors.grey,
          //     ),
          //     left: const BorderSide(
          //       color: Colors.grey,
          //     ),
          //     right: const BorderSide(
          //       color: Colors.grey,
          //     ),
          //   ),
          //   columnWidths: const <int, TableColumnWidth>{
          //     0: FlexColumnWidth(3),
          //     1: FlexColumnWidth(1),
          //     2: FlexColumnWidth(1),
          //   },
          //   defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          //   children: <TableRow>[
          //     TableRow(
          //       decoration:
          //           BoxDecoration(color: Colors.grey.withOpacity(0.1)),
          //       children: const <Widget>[
          //         Padding(
          //           padding: EdgeInsets.all(8.0),
          //           child: Center(
          //             child: CustomStyledText(
          //                 text: 'وقت الدخول', fontWeight: FontWeight.bold),
          //           ),
          //         ),
          //         Padding(
          //           padding: EdgeInsets.all(8.0),
          //           child: Center(
          //             child: CustomStyledText(
          //                 text: 'الجهاز', fontWeight: FontWeight.bold),
          //           ),
          //         ),
          //         Padding(
          //           padding: EdgeInsets.all(8.0),
          //           child: Center(
          //             child: CustomStyledText(
          //                 text: 'عنوان IP', fontWeight: FontWeight.bold),
          //           ),
          //         ),
          //       ],
          //     ),
          //     const TableRow(
          //       children: <Widget>[
          //         Padding(
          //           padding: EdgeInsets.all(8.0),
          //           child: Center(
          //             child: CustomStyledText(
          //               text: "2024-09-06 11:46:38.3768835",
          //               fontSize: 16,
          //               textColor: Colors.black,
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: EdgeInsets.all(8.0),
          //           child: Center(
          //             child: CustomStyledText(
          //               text: "Mobile",
          //               fontSize: 16,
          //               textColor: Colors.black,
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: EdgeInsets.all(8.0),
          //           child: Center(
          //             child: CustomStyledText(
          //               text: "1::",
          //               fontSize: 18,
          //               textColor: Colors.black,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //     const TableRow(
          //       children: <Widget>[
          //         Padding(
          //           padding: EdgeInsets.all(8.0),
          //           child: Center(
          //             child: CustomStyledText(
          //               text: "2024-09-08 11:46:38.3768835",
          //               fontSize: 16,
          //               textColor: Colors.black,
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: EdgeInsets.all(8.0),
          //           child: Center(
          //             child: CustomStyledText(
          //               text: "Mobile",
          //               fontSize: 16,
          //               textColor: Colors.black,
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: EdgeInsets.all(8.0),
          //           child: Center(
          //             child: CustomStyledText(
          //               text: "1::",
          //               fontSize: 18,
          //               textColor: Colors.black,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //     const TableRow(
          //       children: <Widget>[
          //         Padding(
          //           padding: EdgeInsets.all(8.0),
          //           child: Center(
          //             child: CustomStyledText(
          //               text: "2024-09-06 11:46:38.3768835",
          //               fontSize: 16,
          //               textColor: Colors.black,
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: EdgeInsets.all(8.0),
          //           child: Center(
          //             child: CustomStyledText(
          //               text: "Mobile",
          //               fontSize: 16,
          //               textColor: Colors.black,
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: EdgeInsets.all(8.0),
          //           child: Center(
          //             child: CustomStyledText(
          //               text: "1::",
          //               fontSize: 18,
          //               textColor: Colors.black,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FloatingButtonInBottomBar(),
      bottomNavigationBar: const BottomAppBarApplication(currentIndex: 3),
    );
  }
}
