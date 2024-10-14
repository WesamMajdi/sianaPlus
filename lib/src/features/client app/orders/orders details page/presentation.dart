import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20order/itemsToOrderDetalies.dart';

class OrdersDetailsPage extends StatelessWidget {
  const OrdersDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarApplicationArrow(text: 'تفاصيل الطلب'),
      body: ListView.builder(
        shrinkWrap: false,
        itemCount: allOrders.length,
        itemBuilder: (context, index) {
          final order = allOrders[index];
          return Column(
            children: [
              ItemsOrdersDetails(
                order: order,
              ),
              
            ],
          );
        },
      ),
    );
  }
}
