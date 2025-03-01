// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/cupertino.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/profile/update_user_profile_screen.dart';

class UserProfileMaintenancePage extends StatefulWidget {
  const UserProfileMaintenancePage({super.key});

  @override
  _UserProfileMaintenancePageState createState() =>
      _UserProfileMaintenancePageState();
}

class _UserProfileMaintenancePageState
    extends State<UserProfileMaintenancePage> {
  bool? isDropdownVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarApplicationArrow(
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
              text: "فني الصيانة",
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
                  text: "technician@test.com",
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
              text: "الحماية والأمان",
              fontWeight: FontWeight.bold,
              textColor: AppColors.secondaryColor,
              fontSize: 16,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Table(
              border: TableBorder(
                borderRadius: BorderRadius.circular(15),
                horizontalInside: const BorderSide(
                  color: Colors.grey,
                ),
                verticalInside: const BorderSide(
                  color: Colors.grey,
                ),
                top: const BorderSide(
                  color: Colors.grey,
                ),
                bottom: const BorderSide(
                  color: Colors.grey,
                ),
                left: const BorderSide(
                  color: Colors.grey,
                ),
                right: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                TableRow(
                  decoration:
                      BoxDecoration(color: Colors.grey.withOpacity(0.1)),
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CustomStyledText(
                            text: 'وقت الدخول', fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CustomStyledText(
                            text: 'الجهاز', fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CustomStyledText(
                            text: 'عنوان IP', fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: CustomStyledText(
                          text:
                              '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CustomStyledText(
                          text: "Mobile",
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CustomStyledText(
                          text: "1::",
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: CustomStyledText(
                          text:
                              '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CustomStyledText(
                          text: "Mobile",
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CustomStyledText(
                          text: "1::",
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
