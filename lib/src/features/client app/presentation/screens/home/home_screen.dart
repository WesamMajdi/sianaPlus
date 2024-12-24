import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/categorys%20page/presentation.dart';
import 'package:maintenance_app/src/features/client%20app/data/data_sources/brand/brand_data_source.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../controller/cubits/category_cubit.dart';
import '../../controller/states/category_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imageList = [
    'assets/images/kitchenware.jpeg',
    'assets/images/refrigerator.jpeg',
    'assets/images/washing machine.jpeg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarApplication(
        text: "الرئيسية",
        actions: [
          AppSizedBox.kWSpace20,
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchProductPage(),
                  ));
            },
            child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 22,
                )),
          ),
          AppSizedBox.kWSpace5
        ],
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SliderHome(imageList: imageList),
            const ItemsBrandes(),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20, bottom: 10),
                    child: CustomStyledText(
                      text: "الاصناف الرئيسية",
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      textColor: AppColors.secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const ItemsCategory(),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20, bottom: 5),
                    child: CustomStyledText(
                      text: "تسوق اونلاين",
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      textColor: AppColors.secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            // ItemsProduct(),
            AppSizedBox.kVSpace20
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FloatingButtonInBottomBar(),
      bottomNavigationBar: const BottomAppBarApplication(currentIndex: 0),
    );
  }
}

class ItemsCategory extends StatelessWidget {
  const ItemsCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        switch (state.mainCategoryStatus) {
          case MainCategoryStatus.initial:
          case MainCategoryStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case MainCategoryStatus.failure:
            return Text(state.errorMessage!);

          case MainCategoryStatus.success:
            if (state.categories.isNotEmpty) {
              return SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    final category = state.categories[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryPage(),
                            )

                          );
                          context.read<CategoryCubit>().selectCategory(
                            categoryId: category.id,
                          );
                          context.read<CategoryCubit>().fetchSubCategories(
                                mainCategoryId: category.id,
                              );
                        },
                        child: Container(
                          height: 70,
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppPadding.mediumPadding,
                              vertical: AppPadding.smallPadding),
                          decoration: BoxDecoration(
                            // boxShadow: shadowList,
                            border: Border.all(
                              color: AppColors.secondaryColor,
                              width: 0.6,
                            ),
                            color: Colors.grey.withOpacity(0.2),

                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(top: 3),
                            child: Center(
                              child: CustomStyledText(
                                text: category.name,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      )
                    );
                  },
                ),
              );
            }
        }

        return Text('Some thing error');
      },
    );
    // return
  }
}

class SliderHome extends StatelessWidget {
  const SliderHome({
    super.key,
    required this.imageList,
  });

  final List<String> imageList;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        autoPlayInterval: const Duration(seconds: 10),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        enableInfiniteScroll: true,
        viewportFraction: 0.9,
      ),
      items: imageList.map((imagePath) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppColors.primaryColor,
                    AppColors.secondaryColor,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  AppSizedBox.kWSpace15,
                  Expanded(
                    flex: 2,
                    child: Image.asset(imagePath, fit: BoxFit.cover),
                  ),
                  AppSizedBox.kWSpace15,
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomStyledText(
                          text: 'طقم طناجر',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          textColor: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: CustomStyledText(
                            text: 'هو عبارة عن طقم طناجر مكون من 16 قطعة"',
                            fontSize: 14,
                            textColor: Colors.white54,
                          ),
                        ),
                        AppSizedBox.kVSpace10,
                        const CustomStyledText(
                          text: '50\$',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          textColor: Colors.white,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomStyledText(
                                  text: 'اطلب الان',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  textColor: Colors.white54,
                                ),
                                AppSizedBox.kWSpace5,
                                Icon(
                                  FontAwesomeIcons.arrowLeft,
                                  size: 12,
                                  color: Colors.white54,
                                )
                              ],
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
        );
      }).toList(),
    );
  }
}

class ItemsBrandes extends StatelessWidget {
  const ItemsBrandes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: brandes.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(15)),
                      child: Image.asset(
                        brandes[index]['imagePath'],
                        height: 50,
                        width: 50,
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: CustomStyledText(
                          text: brandes[index]['name'],
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ))
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
