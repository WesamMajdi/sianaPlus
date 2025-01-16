// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/category/category_screen.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/ordered_product/ordered_product_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const AppBarApplication(
        text: "الرئيسية",
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(child: Image.asset('assets/images/poster.png')),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MaintenanceRequestPage(),
                  ),
                );
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                            builder: (context) => const OrderedProductPage(),
                          ),
                        );
                      },
                      url: 'assets/images/checklist_17570946.png',
                      title: 'طلبات الصيانة',
                      color: AppColors.darkGrayColor),
                  ServiceCard(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrderedProductPage(),
                          ),
                        );
                      },
                      url: 'assets/images/features_4059923.png',
                      title: 'طلبات المتجر',
                      color: AppColors.lightGrayColor),
                  ServiceCard(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ReportProblemPage(),
                          ),
                        );
                      },
                      url: 'assets/images/chat_3959680.png',
                      title: 'شكاوي',
                      color: Colors.grey),
                ],
              ),
            ),
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
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FloatingButtonInBottomBar(),
      bottomNavigationBar: const BottomAppBarApplication(currentIndex: 0),
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
