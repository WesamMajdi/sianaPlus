import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/category_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/category_state.dart';

// class CartShopping extends StatelessWidget {
//   const CartShopping({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: const MyDrawer(),
//       appBar: const AppBarApplication(text: "سلة التسوق"),
//       body: Column(
//         children: [
//           Expanded(
//             child: BlocBuilder<CategoryCubit,CategoryState>(
//               builder: (context, state) {
//                 if (state.cartItems.isEmpty) {
//                   return const Center(
//                     child: Text('سلة التسوق فارغة'),
//                   );
//                 }
//                 return ListView.builder(
//                   itemCount: state.cartItems.length,
//                   itemBuilder: (context, index) {
//                     final item = state.cartItems.values.toList()[index];
//                     return ListTile(
//                       title: Text(item.name!),
//                       subtitle: Text('السعر: ${item.price} \$'),
//                       trailing: Text('الكمية: ${item.count}'),
//                       leading: IconButton(
//                         icon: const Icon(Icons.remove_shopping_cart),
//                         onPressed: () {
//                           context.read<CategoryCubit>().removeItem(item.id.toString());
//                         },
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BlocBuilder<CategoryCubit, CategoryState>(
//         builder: (context, state) {
//           return BottomAppBar(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'المجموع: ${state.totalAmount?.toStringAsFixed(2)} \$',
//                 style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class CartShopping extends StatelessWidget {
  const CartShopping({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: const MyDrawer(),
      appBar: const AppBarApplication(text: "سلة التسوق"),
      body: Column(
        children: [
          Expanded(
            // child: ListView.builder(
            //   itemCount: items.length,
            //   itemBuilder: (context, index) {
            //     return CartShoppingItem(item: items[index]);
            //   },
            // ),
        child: BlocBuilder<CategoryCubit,CategoryState>(
              builder: (context, state) {
                if (state.cartItems.isEmpty) {
                  return const Center(
                    child: Text('سلة التسوق فارغة'),
                  );
                }
                return ListView.builder(
                  itemCount: state.cartItems.length,
                  itemBuilder: (context, index) {
                    final product = state.cartItems.values.toList()[index];
                    return CartShoppingItem(item:product);
                    // print(state.cartItems.toString());
                  },
                );
              }
    ))]),
      bottomNavigationBar: const BottomBarCartTotal(),
    );
  }
}
