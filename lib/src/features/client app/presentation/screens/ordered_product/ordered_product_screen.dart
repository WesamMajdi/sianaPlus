import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class OrderedProductPage extends StatelessWidget {
  const OrderedProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: const MyDrawer(),
        appBar: AppBar(
          iconTheme: IconThemeData(
              weight: 100,
              shadows: shadowList,
              size: 32,
              fill: 0.5,
              color: (Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black)),
          elevation: 0,
          bottom: TabBar(
            labelColor: (Theme.of(context).brightness == Brightness.dark
                ? AppColors.lightGrayColor
                : AppColors.darkGrayColor),
            unselectedLabelColor:
                (Theme.of(context).brightness == Brightness.dark
                    ? AppColors.lightGrayColor
                    : AppColors.darkGrayColor),
            indicatorColor: AppColors.secondaryColor,
            labelStyle: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              fontFamily: 'Tajawal',
            ),
            tabs: const [
              Tab(
                text: 'طلباتي الحالية',
              ),
              Tab(text: 'طلباتي السابقة'),
            ],
          ),
          backgroundColor: Colors.transparent,
          title: Container(
            margin: const EdgeInsets.only(left: 60),
            child: const Center(
              child: CustomStyledText(
                text: 'طلبات المنتجات',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                textColor: AppColors.secondaryColor,
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [PreviousProductOrdersTab(), CurrentProductOrdersTab()],
        ),
      ),
    );
  }
}
