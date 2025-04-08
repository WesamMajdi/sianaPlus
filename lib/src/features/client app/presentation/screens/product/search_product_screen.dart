import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/product/search_product_model.dart';
import 'package:maintenance_app/src/features/client%20app/domain/entities/product/search_product_entity.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/category_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/category_state.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/category/category_screen.dart';

class SearchProductPage extends StatefulWidget {
  const SearchProductPage({super.key});

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().getSearchProduct();
  }

  TextEditingController searchController = TextEditingController();
  void _onSearch() {
    String query = searchController.text;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoryPage()),
    );
    context.read<CategoryCubit>().createSearch(context, query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      resizeToAvoidBottomInset: true,
      appBar: const AppBarApplication(text: "ابحث عن المنتجات"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  onTap: () {
                                    searchController.clear();
                                  },
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  controller: searchController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'الرجاء إدخال نص';
                                    }
                                    return null;
                                  },
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide.none),
                                    prefixIcon: const Icon(
                                      FontAwesomeIcons.magnifyingGlass,
                                      size: 20,
                                      color: Colors.grey,
                                    ),
                                    suffixIcon: searchController.text.isEmpty
                                        ? null
                                        : const Icon(
                                            Icons.cancel_sharp,
                                            color: Colors.black,
                                          ),
                                    hintText: "ابحث عن المنتج",
                                    hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Tajawal"),
                                  ),
                                ),
                              ),
                            ],
                          ))),
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
                          onPressed: _onSearch))
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
                child: BlocBuilder<CategoryCubit, CategoryState>(
                  builder: (context, state) {
                    if (state.searchProductStatus ==
                        SearchProductStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state.searchProductStatus ==
                        SearchProductStatus.failure) {
                      return Center(
                          child: Text(
                              'فشل في تحميل البيانات: ${state.errorMessage}'));
                    } else if (state.searchProductStatus ==
                        SearchProductStatus.success) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.listOfSearch.length,
                        itemBuilder: (context, index) =>
                            previousSearchesItems(state.listOfSearch[index]),
                        shrinkWrap: true,
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
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
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const FloatingButtonInBottomBar(),
      bottomNavigationBar: const BottomAppBarApplication(currentIndex: -1),
    );
  }

  previousSearchesItems(SearchProductEntity product) {
    return InkWell(
      onTap: () {
        if (product.text != null && product.text!.isNotEmpty) {
          searchController.text = product.text ?? '';
          searchController.selection = TextSelection.fromPosition(
              TextPosition(offset: searchController.text.length));
          setState(() {});
        }
      },
      onLongPress: () {
        context.read<CategoryCubit>().deleteSearchProduct(product);
      },
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
            CustomStyledText(
              text: product.text!,
              fontSize: 20,
            ),
            const Spacer(),
            const Icon(
              Icons.call_made_outlined,
              color: Colors.grey,
            ),
            Divider(
              // ignore: deprecated_member_use
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
