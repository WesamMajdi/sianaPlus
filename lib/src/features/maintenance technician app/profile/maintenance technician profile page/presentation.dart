import 'package:flutter/cupertino.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool? isDropdownVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: const AppBarApplication(
        text: 'صفحتي الشخصية',
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
              margin: const EdgeInsets.only(top: 5),
              child: Center(
                child: Stack(
                  children: [
                    ClipOval(
                      child: Material(
                        color: Colors.transparent,
                        child: GestureDetector(
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Hero(
                                      tag: 'userImage',
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 10,
                                            ),
                                          ],
                                        ),
                                        child: Image.asset(
                                          "assets/images/user.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Ink.image(
                            image: const AssetImage("assets/images/user.png"),
                            fit: BoxFit.cover,
                            width: 110,
                            height: 110,
                            child: InkWell(onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ChangeUserProfile(),
                                  ));
                            }),
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      bottom: 0,
                      left: 0,
                      child: UpdateImageInUserProfile(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              )),
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangeUserProfile(),
                      ));
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: const CustomStyledText(
                    text: "تعديل الملف",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              AppSizedBox.kWSpace10,
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => const UserSettingProfile(),
                  //     ));
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: const CustomStyledText(
                    text: "الاعدادات",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
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
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.mail_solid,
                      color: AppColors.secondaryColor,
                      size: 20,
                    ),
                    SizedBox(
                      height: 30,
                      width: 20,
                      child: VerticalDivider(),
                    ),
                    CustomStyledText(
                      text: "maintenance_technician@gmail.com",
                      fontSize: 18,
                    ),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.phone_solid,
                      color: AppColors.secondaryColor,
                      size: 20,
                    ),
                    SizedBox(
                      height: 30,
                      child: VerticalDivider(),
                    ),
                    CustomStyledText(
                      text: "0599924216",
                      fontSize: 18,
                    ),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.location_solid,
                      color: AppColors.secondaryColor,
                      size: 20,
                    ),
                    SizedBox(
                      height: 30,
                      child: VerticalDivider(),
                    ),
                    CustomStyledText(
                      text: "السعودية , حفر الباطن , شارع رقم 56",
                      fontSize: 17,
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppSizedBox.kVSpace10,
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: const CustomStyledText(
              text: "الأمن و الحماية",
              textColor: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.5),
                //     spreadRadius: 2,
                //     blurRadius: 5,
                //     offset: const Offset(0, 3),
                //   ),
                // ],
              ),
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
                  0: FlexColumnWidth(3),
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
                  const TableRow(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CustomStyledText(
                            text: "2024-09-06 11:46:38.3768835",
                            fontSize: 16,
                            textColor: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CustomStyledText(
                            text: "Mobile",
                            fontSize: 16,
                            textColor: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CustomStyledText(
                            text: "1::",
                            fontSize: 18,
                            textColor: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const TableRow(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CustomStyledText(
                            text: "2024-09-08 11:46:38.3768835",
                            fontSize: 16,
                            textColor: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CustomStyledText(
                            text: "Mobile",
                            fontSize: 16,
                            textColor: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CustomStyledText(
                            text: "1::",
                            fontSize: 18,
                            textColor: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const TableRow(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CustomStyledText(
                            text: "2024-09-06 11:46:38.3768835",
                            fontSize: 16,
                            textColor: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CustomStyledText(
                            text: "Mobile",
                            fontSize: 16,
                            textColor: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CustomStyledText(
                            text: "1::",
                            fontSize: 18,
                            textColor: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          AppSizedBox.kVSpace20,
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondaryColor,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SearchProductPage()),
          );
        },
        child: const Icon(
          FontAwesomeIcons.magnifyingGlass,
          size: 20,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: const BottomAppBarApplication(currentIndex: 3),
    );
  }
}

class UpdateImageInUserProfile extends StatelessWidget {
  const UpdateImageInUserProfile({super.key, required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: buildCircle(
        color: AppColors.secondaryColor,
        all: 4,
        child: buildCircle(
          color: color,
          all: 6,
          child: const Icon(
            Icons.camera_alt,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}

Widget buildCircle({
  required Widget child,
  required double all,
  required Color color,
}) =>
    ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
