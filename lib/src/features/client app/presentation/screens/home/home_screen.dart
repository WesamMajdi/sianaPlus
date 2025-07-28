import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product/product_entity.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/category_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/profile_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/category_state.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/profile_state.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/category/category_screen.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/product/details_product_screen.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.currentIndex = 0});
  final int? currentIndex;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CarouselSliderController carouselController = CarouselSliderController();
  int _currentImageIndex = 0;
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().fetchHomePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).colorScheme.surface
          : Colors.white,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBarApplication(
        text: "الرئيسية",
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SearchProductPage()),
              );
            },
          ),
        ],
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state.homePageStatus == HomePageStatus.failure)
                  SizedBox(
                    height: 180,
                    child: Center(
                        child: SizedBox(
                      width: 35,
                      height: 35,
                      child: CircularProgressIndicator(
                          color: AppColors.secondaryColor, strokeWidth: 3),
                    )),
                  )
                else if (state.imageList.isEmpty)
                  const SizedBox(
                    height: 180,
                    child: Center(
                        child: CustomStyledText(text: 'لا توجد صور حالياً')),
                  )
                else
                  Stack(
                    children: [
                      CarouselSlider(
                        carouselController: carouselController,
                        options: CarouselOptions(
                          height: 180.0,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 0.9,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentImageIndex = index;
                            });
                          },
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
                      Positioned(
                        left: 30,
                        top: 75,
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: IconButton(
                            iconSize: 16,
                            icon: const Icon(Icons.arrow_forward_ios,
                                color: Colors.white),
                            onPressed: () => carouselController.nextPage(),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                                minWidth: 32, minHeight: 32),
                            splashRadius: 20,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 30,
                        top: 75,
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: IconButton(
                            iconSize: 16,
                            icon: const Icon(Icons.arrow_back_ios,
                                color: Colors.white),
                            onPressed: () => carouselController.previousPage(),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                                minWidth: 32, minHeight: 32),
                            splashRadius: 20,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              state.imageList.asMap().entries.map((entry) {
                            bool isActive = _currentImageIndex == entry.key;
                            return GestureDetector(
                              onTap: () =>
                                  carouselController.animateToPage(entry.key),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: isActive ? 25 : 12,
                                height: 12,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  color:
                                      isActive ? Colors.white : Colors.white70,
                                  border: Border.all(color: Colors.black26),
                                  borderRadius:
                                      BorderRadius.circular(isActive ? 20 : 50),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                const ServiceCategoriesWidget(),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomStyledText(
                            text: 'خدمات منزلية',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: CustomStyledText(
                                text: 'عرض الكل',
                                textColor: AppColors.secondaryColor,
                                fontSize: 13,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: const [
                          HouseholdServiceCard(
                            title: 'إصلاح مكيفات الهواء',
                            imageUrl: 'assets/images/image2.jpg',
                            price: 'تبداء من ٨٠ر.س',
                            description:
                                'خدمة التنظيف العميق والصيانة الاحترافية لمكيفات الهواء',
                            isPopular: true,
                          ),
                          SizedBox(height: 10),
                          HouseholdServiceCard(
                            title: 'خدمات الإصلاح السريع',
                            imageUrl:
                                'assets/images/صيانة-الاجهزة-المنزلية.jpeg',
                            price: 'تبداء من ٥٠  ر.س',
                            description: 'حلول إصلاح سريعة وموثوقة لأجهزتك',
                            isPopular: false,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomStyledText(
                        text: 'متجر قطع الغيار',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => CategoryPage()),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: CustomStyledText(
                            text: 'عرض الكل',
                            textColor: AppColors.secondaryColor,
                            fontSize: 13,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    switch (state.homePageStatus) {
                      case HomePageStatus.initial:
                      case HomePageStatus.loading:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case HomePageStatus.failure:
                        return Text(state.errorMessage!);
                      case HomePageStatus.success:
                        if (state.sparePartsList.isNotEmpty) {
                          return HomeProductGrid(
                              products: state.sparePartsList);
                        } else {
                          return const Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomStyledText(text: 'لا توجد منتجات')
                              ],
                            ),
                          );
                        }
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Icon(Icons.eco_outlined, size: 24, color: Colors.teal),
                      SizedBox(width: 8),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: CustomStyledText(
                          text: 'أجهزة مجددة',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: CustomStyledText(
                            text: 'عرض الكل',
                            textColor: AppColors.secondaryColor,
                            fontSize: 13,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    switch (state.homePageStatus) {
                      case HomePageStatus.initial:
                      case HomePageStatus.loading:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case HomePageStatus.failure:
                        return Text(state.errorMessage!);
                      case HomePageStatus.success:
                        if (state.sparePartsList.isNotEmpty) {
                          return RecycledDevicesWidget(
                              products: state.usedProductList);
                        } else {
                          return const Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomStyledText(text: 'لا توجد منتجات')
                              ],
                            ),
                          );
                        }
                    }
                  },
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

class HouseholdServiceCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String price;
  final String description;
  final bool isPopular;

  const HouseholdServiceCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.description,
    this.isPopular = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[900]
          : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                imageUrl,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              if (isPopular)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: const CustomStyledText(
                        text: 'قريباً جداً',
                        textColor: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomStyledText(
                      text: title,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    CustomStyledText(
                      text: price,
                      textColor: AppColors.secondaryColor,
                      fontSize: 12,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                CustomStyledText(
                  text: description,
                  fontSize: 12,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    onPressed: () {
                      if (!isPopular) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => MaintenanceRequestPage()),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            title: Column(
                              children: [
                                Center(
                                  child: Container(
                                    width: 50,
                                    height: 5,
                                    margin: const EdgeInsets.only(
                                        bottom: 15, top: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  alignment: Alignment.topRight,
                                  child: const CustomStyledText(
                                    text: 'قريباً',
                                    fontSize: 20,
                                    textColor: AppColors.secondaryColor,
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  color: Colors.grey,
                                  height: 0.5,
                                ),
                              ],
                            ),
                            content: SizedBox(
                              height: 35,
                              width: 250,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: const CustomStyledText(
                                      text: 'سوف نطلق هذه الخدمة قريباً جداً!',
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: AppColors.secondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: const CustomStyledText(
                                    text: "حسناً", textColor: Colors.white),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    text: 'طلب صيانة الان',
                    color: AppColors.secondaryColor,
                    padding: EdgeInsets.all(10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceCategoryItem {
  final String id;
  final String title;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final String description;

  ServiceCategoryItem({
    required this.id,
    required this.title,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    required this.description,
  });
}

final List<ServiceCategoryItem> serviceCategories = [
  ServiceCategoryItem(
    id: 'emergency',
    title: 'صيانة طارئة',
    icon: Icons.warning_amber_rounded,
    bgColor: Color(0xFFFFEBEE),
    iconColor: Colors.red,
    description: 'ياتيك مندوبنا فورا',
  ),
  ServiceCategoryItem(
    id: 'maintenance',
    title: 'طلب صيانة',
    icon: Icons.build_rounded,
    bgColor: Color(0xFFE3F2FD),
    iconColor: AppColors.primaryColor,
    description: 'ياتيك مندوبنا في اسرع وقت',
  ),
  ServiceCategoryItem(
    id: 'cart',
    title: 'الســـلة',
    icon: Icons.shopping_cart,
    bgColor: Color(0xFFE0F7FA),
    iconColor: Colors.teal,
    description: 'مشترياتك',
  ),
  ServiceCategoryItem(
    id: 'contact',
    title: 'تواصل معنا',
    icon: Icons.phone,
    bgColor: Color(0xFFFFF3E0),
    iconColor: Colors.orange,
    description: 'متواجدون ٢٤ ساعه',
  ),
];

class ServiceCategoriesWidget extends StatelessWidget {
  const ServiceCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CustomStyledText(
            text: 'خدماتنا',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 170,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: serviceCategories.length,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemBuilder: (context, index) {
              final service = serviceCategories[index];
              return GestureDetector(
                onTap: () {},
                child: Container(
                  width: 135,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[900]
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.1),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: service.bgColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            service.icon,
                            color: service.iconColor,
                            size: 26,
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomStyledText(
                          text: service.title,
                          textAlign: TextAlign.center,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(height: 6),
                        CustomStyledText(
                          text: service.description,
                          textAlign: TextAlign.center,
                          fontSize: 11,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class RecycledDevice {
  final int id;
  final String name;
  final String model;
  final String price;
  final String originalPrice;
  final String image;
  final String warranty;
  final String condition;
  final String discount;

  RecycledDevice({
    required this.id,
    required this.name,
    required this.model,
    required this.price,
    required this.originalPrice,
    required this.image,
    required this.warranty,
    required this.condition,
    required this.discount,
  });
}

final List<RecycledDevice> recycledDevices = [
  RecycledDevice(
    id: 1,
    name: 'مكنسة غسيل السجاد',
    model: 'مجدده بحاله ٨٠٪',
    price: '٣٥٠ ر.س',
    originalPrice: '٦٥٠ ر.س',
    image:
        'https://sianaplus.com/ImageProduct/2-042b8802-2951-4533-b7bb-8ecebc12f3ac.jpg',
    warranty: '3 شهور',
    condition: 'ممتازة',
    discount: 'خصم %45',
  ),
  RecycledDevice(
    id: 2,
    name: 'خلاط',
    model: 'مجدد بحالة ٩٠٪',
    price: '١٨٠ ر.س ',
    originalPrice: '٣٢٠ ر.س',
    image:
        'https://sianaplus.com/ImageProduct/4-e0e7a2db-2dbc-41ab-bc24-e22eb84ed42f.jpg',
    warranty: '3 شهور',
    condition: 'جيدة',
    discount: 'خصم %40',
  ),
];

class RecycledDevicesWidget extends StatelessWidget {
  const RecycledDevicesWidget({super.key, required this.products});
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          itemCount: products.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemBuilder: (context, index) {
            final device = products[index];

            return Card(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[900]
                  : Colors.white,
              elevation: 0.5,
              margin: const EdgeInsets.only(bottom: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0, bottom: 20),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(12),
                          ),
                          child: Image.network(
                            IMAGE_URL + device.image!,
                            width: 100,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      if (device.discount != 0)
                        Positioned(
                          top: 6,
                          left: 6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.red.shade600,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: CustomStyledText(
                              text: "خصم ${device.discount ?? 0}%",
                              textColor: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomStyledText(
                            text: device.name ?? "منتج جديد",
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          const SizedBox(height: 4),
                          CustomStyledText(
                            text: "مجدد بحالة 70%",
                            fontSize: 12,
                            textColor: Colors.grey,
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CustomStyledText(
                                        text: "${device.price ?? 0}",
                                        textColor: AppColors.secondaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                      const SizedBox(width: 4),
                                      Image.asset(
                                        "assets/images/logoRiyal.png",
                                        width: 12,
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.black54
                                            : Colors.white,
                                      ),
                                    ],
                                  ),
                                  if (device.discount != 0)
                                    CustomStyledText(
                                      text: "${device.originalPrice ?? 0}",
                                      fontSize: 11,
                                      decoration: TextDecoration.lineThrough,
                                      textColor: Colors.black,
                                    ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.stop_circle_outlined,
                                  size: 13, color: Colors.teal),
                              const SizedBox(width: 4),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: CustomStyledText(
                                  text: '4 شهور ضمان',
                                  fontSize: 11,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: CustomStyledText(
                                  text: "ممتازة",
                                  fontSize: 11,
                                  textColor: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          AppSizedBox.kVSpace10,
                          CustomButton(
                            text: "عرض تفاصيل الخدمة",
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ProductDetailsPage(
                                      product: products[index]),
                                ),
                              );
                            },
                            padding: EdgeInsets.all(0),
                            color: AppColors.secondaryColor,
                            margin: EdgeInsets.all(0),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        AppSizedBox.kVSpace20
      ],
    );
  }
}

class HomeProductGrid extends StatelessWidget {
  final List<Product> products;

  const HomeProductGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final displayProducts = products.take(4).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.builder(
        itemCount: displayProducts.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.79,
        ),
        itemBuilder: (context, index) {
          final product = displayProducts[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      ProductDetailsPage(product: displayProducts[index]),
                ),
              );
            },
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: shadowList,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black54
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (product.discount != null && product.discount! > 0)
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.secondaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CustomStyledText(
                              text: '%${product.discount!.toInt()}',
                              textColor: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: IMAGE_URL + product.image!,
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomStyledText(
                        text: truncateTextTitle(product.name!),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      CustomStyledText(
                        text: truncateTextDescription(product.details ?? ""),
                        fontSize: 10,
                        textColor: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add_shopping_cart,
                              size: 14,
                              color: Colors.white,
                            ),
                            label: const CustomStyledText(
                              text: "إضافة",
                              textColor: Colors.white,
                              fontSize: 11,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondaryColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              textStyle: const TextStyle(fontSize: 11),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              minimumSize: const Size(10, 30),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: Row(
                              children: [
                                if (product.discount! > 0)
                                  CustomStyledText(
                                    text: "${product.originalPrice}",
                                    fontSize: 12,
                                    textColor: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                const SizedBox(width: 6),
                                CustomStyledText(
                                  text: "${product.price}",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                const SizedBox(width: 4),
                                Image.asset(
                                  "assets/images/logoRiyal.png",
                                  width: 14,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 12,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.favorite_border,
                            size: 20,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 3),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.remove_red_eye_outlined,
                            size: 20,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
