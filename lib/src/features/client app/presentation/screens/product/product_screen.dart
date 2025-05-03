import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/category_cubit.dart';

import '../../controller/states/category_state.dart';

// ignore: must_be_immutable
class ProductPage extends StatefulWidget {
  int categoryId;
  ProductPage({super.key, required this.categoryId});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<CategoryCubit>()
        .getProductByCategory(mainCategoryId: widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: const AppBarApplication(
        text: 'تسوق اونلاين',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppSizedBox.kVSpace10,
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
              alignment: Alignment.centerRight,
              child: const CustomStyledText(
                text: "المنتجات",
                fontSize: 22,
                fontWeight: FontWeight.bold,
                textColor: AppColors.secondaryColor,
              ),
            ),
            BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                switch (state.productStatus) {
                  case ProductStatus.initial:
                  case ProductStatus.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ProductStatus.failure:
                    return Text(state.errorMessage!);
                  case ProductStatus.success:
                    if (state.products.isNotEmpty) {
                      return ItemsProduct(products: state.products);
                    } else {
                      return const Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [CustomStyledText(text: 'لا توجد منتجات')],
                        ),
                      );
                    }
                }

                return Text('Some thing error');
              },
            )
          ],
        ),
      ),
    );
  }
}
