import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20delivery%20shop%20app/ItemsPerviousTakePart.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20delivery%20shop%20app/ItemsReceiveOrderPart.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/controller/Cubit/delivery_shop_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/controller/state/deliveryShop_state.dart';

class PerviousOrderScreen extends StatefulWidget {
  const PerviousOrderScreen({Key? key}) : super(key: key);

  @override
  State<PerviousOrderScreen> createState() => _PerviousOrderScreenState();
}

class _PerviousOrderScreenState extends State<PerviousOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarApplicationArrow(text: 'الطلبات السابقة'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildPerviousOrderList(),
          ],
        ),
      ),
    );
  }

  Widget buildPerviousOrderList() {
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
          itemCount: state.ordersOld.length,
          itemBuilder: (context, index) {
            return ItemsPerviousOrderPart(
              item: state.ordersOld[index],
            );
          },
        );
      }
      return const Center(
          child: CustomStyledText(text: 'لا توجد إيصالات استلام'));
    });
  }
}
