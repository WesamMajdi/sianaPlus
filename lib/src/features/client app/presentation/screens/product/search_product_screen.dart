import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class SearchProductPage extends StatelessWidget {
  const SearchProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      resizeToAvoidBottomInset: true,
      appBar: const AppBarApplication(text: "ابحث عن المنتج"),
      body: SingleChildScrollView(
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      const Expanded(child: AppSearch()),
                      Container(
                          margin: const EdgeInsets.only(right: 5),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.tune, color: Colors.white),
                            onPressed: () {},
                          ))
                    ],
                  ),
                ),
                AppSizedBox.kVSpace10,
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.smallPadding),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.black45
                          : Colors.white),
                    ),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) => previousSearchesItems(),
                      shrinkWrap: true,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSizedBox.kVSpace20,
                    const Padding(
                      padding: EdgeInsets.only(right: AppPadding.mediumPadding),
                      child: CustomStyledText(
                        text: "اقترحات البحث",
                        textColor: AppColors.secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    AppSizedBox.kVSpace20,
                    Row(
                      children: [
                        searchSuggestionsTimes("الغسالة"),
                        searchSuggestionsTimes("الثلاجة")
                      ],
                    ),
                    AppSizedBox.kVSpace20,
                    Row(
                      children: [
                        searchSuggestionsTimes("طقم طناجر"),
                        searchSuggestionsTimes("مكيروويف"),
                        searchSuggestionsTimes("مروحة")
                      ],
                    )
                  ],
                )
              ],
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FloatingButtonInBottomBar(),
      bottomNavigationBar: const BottomAppBarApplication(currentIndex: -1),
    );
  }

  previousSearchesItems() {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Row(
          children: [
            Icon(
              Icons.timer,
              color: Colors.grey.withOpacity(0.4),
              size: 20,
            ),
            AppSizedBox.kWSpace15,
            const CustomStyledText(
              text: "ثلاجة",
              fontSize: 20,
            ),
            const Spacer(),
            const Icon(
              Icons.call_made_outlined,
              color: Colors.grey,
            ),
            Divider(
              color: Colors.grey.withOpacity(0.4),
            ),
          ],
        ),
      ),
    );
  }

  searchSuggestionsTimes(String text) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(
          vertical: AppPadding.mediumPadding,
          horizontal: AppPadding.mediumPadding),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: CustomStyledText(
        text: text,
        fontSize: 20,
      ),
    );
  }
}
