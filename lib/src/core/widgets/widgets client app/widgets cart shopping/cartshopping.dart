import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/category_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/category_state.dart';

class CartShopping extends StatelessWidget {
  const CartShopping({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: const AppBarApplication(text: "سلة التسوق"),
      body: Column(children: [
        Expanded(child: BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
          if (state.cartItems.isEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/cartShopping.gif',
                    height: 250,
                    width: 250, // ارتفاع أكبر (اختياري)
                    fit: BoxFit.contain, // لضمان التناسب
                  ),
                ),
                AppSizedBox.kVSpace20,
                const CustomStyledText(text: 'سلة التسوق فارغة')
              ],
            );
          }
          return ListView.builder(
            itemCount: state.cartItems.length,
            itemBuilder: (context, index) {
              final product = state.cartItems.values.toList()[index];
              return CartShoppingItem(item: product);
            },
          );
        }))
      ]),
      bottomNavigationBar: const BottomBarCartTotal(),
    );
  }
}
