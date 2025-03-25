import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/category_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/category_state.dart';
import 'package:maintenance_app/src/features/maintenance%20technician%20app/presentation/screens/home_maintenance/home_maintenance_screen.dart';

import '../home/home_screen.dart';

class CartShoppingPage extends StatelessWidget {
  const CartShoppingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
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
          } else if (state.orderStatus == OrderStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: CustomStyledText(
                  text: "تم اضافة الطلب بنجاح",
                  textColor: Colors.white,
                ),
                backgroundColor: Colors.green,
              ),
            );

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          }
        }, builder: (context, state) {
          // context.read<CategoryCubit>().getDiscount();
          if (state.cartItems.isEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    child: Image.asset(
                      'assets/images/cartShopping.png',
                      width: 300,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const CustomStyledText(
                  text: 'سلة التسوق فارغة',
                  fontSize: 20,
                )
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
