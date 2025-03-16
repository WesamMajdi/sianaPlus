import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20delivery%20shop%20app/ItemsCurrentTakePart.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/controller/Cubit/delivery_shop_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/controller/state/deliveryShop_state.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/screens/home_delivery/home_delivery_shop_screen.dart';

class CurrentTakeOrderScreen extends StatefulWidget {
  const CurrentTakeOrderScreen({Key? key}) : super(key: key);

  @override
  State<CurrentTakeOrderScreen> createState() => _CurrentTakeOrderScreenState();
}

class _CurrentTakeOrderScreenState extends State<CurrentTakeOrderScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      BlocProvider.of<DeliveryShopCubit>(context).getAllTakeDelivery();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarApplicationArrow(
        text: 'الطلبات الحالية',
        onBackTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeDeliveryScreen(),
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildCurrentTakeOrderList(),
          ],
        ),
      ),
    );
  }

  Widget buildCurrentTakeOrderList() {
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
            itemCount: state.ordersCurrent.length,
            itemBuilder: (context, index) {
              return ItemsCurrentTakePart(
                items: state.ordersCurrent[index],
              );
            },
          );
        }
        return const Center(
            child: CustomStyledText(text: 'لا توجد إيصالات استلام'));
      },
    );
  }
}
