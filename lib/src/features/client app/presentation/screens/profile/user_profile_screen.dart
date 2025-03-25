// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/cupertino.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/profile_state.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/profile/update_user_profile_screen.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/profile_cubit.dart';

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
      drawer: const MyDrawer(),
      appBar: const AppBarApplication(
        text: 'صفحتي الشخصية',
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.profileStatus == ProfileStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.profileStatus == ProfileStatus.failure) {
            return Center(child: Text(state.errorMessage!));
          }
          if (state.profileStatus == ProfileStatus.success) {
            final profile = state;
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: const UserImageProfile()),
                AppSizedBox.kVSpace10,
                // Container(
                //   alignment: Alignment.center,
                //   child: CustomStyledText(
                //     text: profile.role ?? "مستخدم",
                //     fontSize: 20,
                //     fontWeight: FontWeight.bold,
                //     textColor: (Theme.of(context).brightness == Brightness.dark
                //         ? AppColors.lightGrayColor
                //         : AppColors.primaryColor),
                //   ),
                // ),
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
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: CustomStyledText(
                    text: "المعلومات الشخصية",
                    fontWeight: FontWeight.bold,
                    textColor: (Theme.of(context).brightness == Brightness.dark
                        ? AppColors.lightGrayColor
                        : AppColors.primaryColor),
                    fontSize: 16,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserInfoProfile(
                        icon: CupertinoIcons.mail_solid,
                        text: truncateTextEmail(profile.email!) ??
                            "لا يوجد بريد إلكتروني",
                      ),
                      const Divider(),
                      UserInfoProfile(
                        icon: CupertinoIcons.phone_solid,
                        text: profile.phone ?? "لا يوجد رقم هاتف",
                      ),
                      const Divider(),
                      const UserInfoProfile(
                        icon: CupertinoIcons.location_solid,
                        text: "السعودية",
                      ),
                    ],
                  ),
                ),

                AppSizedBox.kVSpace10,
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: CustomStyledText(
                    text: "الاحصائيات",
                    textColor: (Theme.of(context).brightness == Brightness.dark
                        ? AppColors.lightGrayColor
                        : AppColors.primaryColor),
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
                    children: [
                      StatisticsCard(
                          title: 'الطلبات الحالية',
                          value: profile.orderShopCount?.toString() ?? "0"),
                      StatisticsCard(
                          title: 'الطلبات السابقة',
                          value: profile.orderMaintenancesCount?.toString() ??
                              "0"),
                      StatisticsCard(
                          title: 'المنتجات المفضلة',
                          value: profile.orderShopNewCount?.toString() ?? "0"),
                      StatisticsCard(
                          title: 'مشتريات الشهر الحالي',
                          value:
                              profile.orderMaintenancesNewCount?.toString() ??
                                  "0"),
                    ],
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text('حدث خطأ غير متوقع'));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FloatingButtonInBottomBar(),
      bottomNavigationBar: const BottomAppBarApplication(currentIndex: 3),
    );
  }
}
