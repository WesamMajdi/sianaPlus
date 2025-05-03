import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/category_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/category_state.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/screens/home_maintenance/home_maintenance_screen.dart';

import '../home/home_screen.dart';

class CartShoppingPage extends StatelessWidget {
  final int? currentIndex;
  const CartShoppingPage({
    super.key,
    this.currentIndex = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(
        currentIndex: currentIndex,
      ),
      appBar: const AppBarApplication(text: "سلة التسوق"),
      body: Column(children: [
        Expanded(
            child: BlocConsumer<CategoryCubit, CategoryState>(
                listener: (context, state) {
          if (state.orderStatus == OrderStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: CustomStyledText(
                  text: state.errorMessage!,
                  textColor: Colors.white,
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        }, builder: (context, state) {
          if (state.cartItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/cartShopping.png',
                    width: 300,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 16),
                  const CustomStyledText(
                    text: 'سلة التسوق فارغة',
                    fontSize: 20,
                  )
                ],
              ),
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
