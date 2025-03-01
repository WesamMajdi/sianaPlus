import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20delivery%20shop%20app/ItemsReceiveOrderPart.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/controller/Cubit/delivery_shop_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/controller/state/deliveryShop_state.dart';

class ReceiveOrderScreen extends StatefulWidget {
  const ReceiveOrderScreen({Key? key}) : super(key: key);

  @override
  State<ReceiveOrderScreen> createState() => _ReceiveOrderScreenState();
}

class _ReceiveOrderScreenState extends State<ReceiveOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarApplicationArrow(text: 'الطلبات'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildReceiveOrderList(),
          ],
        ),
      ),
    );
  }

  Widget buildReceiveOrderList() {
    return BlocBuilder<DeliveryShopCubit, DeliveryShopState>(
        builder: (context, state) {
      if (state.deliveryShopStatus == DeliveryShopStatus.loading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state.deliveryShopStatus == DeliveryShopStatus.failure) {
        return const Center(child: Text('فشلت العملية'));
      }
      if (state.deliveryShopStatus == DeliveryShopStatus.success) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: state.orders.length,
          itemBuilder: (context, index) {
            return ItemsReceiveOrderPart(
              item: state.orders[index],
            );
          },
        );
      }
      return const Center(
          child: CustomStyledText(text: 'لا توجد إيصالات استلام'));
    });
  }
}
