// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/network/global_token.dart';
import 'package:maintenance_app/src/features/authentication/presentation/screens/login_screen.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/profile_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/profile_state.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/category/category_screen.dart';

// Add this import at the top of your file
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.currentIndex = 0});
  final int? currentIndex;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().fetchHomeImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const AppBarApplication(
        text: "الرئيسية",
      ),
      drawer: const MyDrawer(currentIndex: 0),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          // Show shimmer when loading
          if (state.homePageStatus == HomePageStatus.loading) {
            return _buildShimmerHomePage();
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // Carousel Slider
                if (state.homePageStatus == HomePageStatus.failure)
                  const SizedBox(
                    height: 180,
                    child: Center(child: Text('فشل في تحميل الصور')),
                  )
                else if (state.imageList.isEmpty)
                  const SizedBox(
                    height: 180,
                    child: Center(child: Text('لا توجد صور حالياً')),
                  )
                else
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 180.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.9,
                    ),
                    items: state.imageList.map((img) {
                      var imageUrl = IMAGE_URL + img.imagePath;
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error),
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        ),
                      );
                    }).toList(),
                  ),

                // New Request Button
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MaintenanceRequestPage(),
                        ));
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.secondaryColor,
                          AppColors.primaryColor,
                        ],
                        stops: [0.0, 1.0],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/delivery-date.png',
                              width: 40,
                            ),
                            AppSizedBox.kVSpace15,
                            const CustomStyledText(
                              text: 'طلب جديد',
                              textColor: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Services Grid
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.9,
                    children: [
                      ServiceCard(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const MaintenanceRequestPage(),
                              ),
                            );
                          },
                          url: 'assets/images/maintenance.png',
                          title: 'صيانة طارئة',
                          color: AppColors.secondaryColor),
                      ServiceCard(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const OrdersMaintenancePage(),
                              ),
                            );
                          },
                          url: 'assets/images/checklist_17570946.png',
                          title: 'طلبات الصيانة',
                          color: AppColors.darkGrayColor),
                      ServiceCard(
                          onTap: () async {
                            String? token = await TokenManager.getToken();
                            if (token == null) {
                              final bool? confirmLogin = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  title: const Row(
                                    children: [
                                      Icon(FontAwesomeIcons.circleExclamation,
                                          color:
                                              Color.fromARGB(255, 255, 173, 51),
                                          size: 24.0),
                                      AppSizedBox.kWSpace10,
                                      Center(
                                        child: CustomStyledText(
                                          text: 'يتطلب تسجيل الدخول',
                                          textColor: AppColors.secondaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  content: const CustomStyledText(
                                    text:
                                        'يرجى تسجيل الدخول لمشاهدة طلبات الصيانة الشخصية .',
                                    fontSize: 14,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor:
                                            AppColors.secondaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      child: const CustomStyledText(
                                        text: "تسجيل الدخول",
                                        textColor: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.grey[200],
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      child: const CustomStyledText(
                                        text: "إلغاء",
                                        fontSize: 12,
                                        textColor: AppColors.darkGrayColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              );

                              if (confirmLogin == true) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                  (Route<dynamic> route) => false,
                                );
                              }

                              return;
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CartShoppingPage(),
                              ),
                            );
                          },
                          url: 'assets/images/features_4059923.png',
                          title: 'سلة تسوق',
                          color: AppColors.lightGrayColor),
                      ServiceCard(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ConcatInfoPage(),
                              ),
                            );
                          },
                          url: 'assets/images/chat_3959680.png',
                          title: 'تواصل معنا',
                          color: Colors.grey),
                    ],
                  ),
                ),

                // Online Store Card
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryPage(),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    elevation: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/shopping-cart_11689764.png',
                                width: 45,
                                color: Colors.deepOrange,
                              ),
                              AppSizedBox.kVSpace20,
                              const CustomStyledText(
                                text: 'المتجر إلكتروني',
                                fontSize: 16,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                AppSizedBox.kVSpace20,
                AppSizedBox.kVSpace20
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FloatingButtonInBottomBar(),
      bottomNavigationBar: const BottomAppBarApplication(currentIndex: 0),
    );
  }

  Widget _buildShimmerHomePage() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Carousel placeholder
            Container(
              height: 180,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 20),

            // New Request Button placeholder
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            // Services Grid placeholder
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 16,
                childAspectRatio: 0.9,
                children: List.generate(
                    4,
                    (index) => Card(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 45,
                                  height: 45,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  width: 80,
                                  height: 16,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        )),
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String url;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const ServiceCard({
    Key? key,
    required this.url,
    required this.title,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              url,
              width: 45,
              color: color,
            ),
            AppSizedBox.kVSpace20,
            CustomStyledText(
              text: title,
            ),
          ],
        ),
      ),
    );
  }
}
