import 'package:cached_network_image/cached_network_image.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/domain/entities/current_order_detiles_entity.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/controller/Cubit/delivery_shop_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/controller/state/deliveryShop_state.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/screens/pervious_order/pervious_order_screen.dart';

class PerviousOrdersDetailsScreen extends StatefulWidget {
  final int basketId;

  const PerviousOrdersDetailsScreen({
    Key? key,
    required this.basketId,
  }) : super(key: key);

  @override
  State<PerviousOrdersDetailsScreen> createState() =>
      _PerviousOrdersDetailsScreenState();
}

class _PerviousOrdersDetailsScreenState
    extends State<PerviousOrdersDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<DeliveryShopCubit>()
        .fetchAllItemByOrderDetiles(widget.basketId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarApplicationArrow(
        text: 'تفاصيل طلب',
        onBackTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PerviousOrderScreen(),
            ),
          );
        },
      ),
      body: BlocBuilder<DeliveryShopCubit, DeliveryShopState>(
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
              itemCount: state.selectedOrderDetilesCurrentItems.length,
              itemBuilder: (context, index) {
                final ordersCurrent =
                    state.selectedOrderDetilesCurrentItems[index];

                return _buildOrderItem(context, ordersCurrent);
              },
            );
          }

          return const Center(
            child: CustomStyledText(text: 'جاري التحميل...'),
          );
        },
      ),
    );
  }

  Widget _buildOrderItem(
      BuildContext context, OrderCurrentDetailsEntity order) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.mediumPadding,
            vertical: AppPadding.smallPadding,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: (Theme.of(context).brightness == Brightness.dark
                  ? Colors.black54
                  : Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.largePadding),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: order.orders!.length,
                itemBuilder: (context, index) {
                  final orderItem = order.orders![index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: orderItem.productImage != null
                            ? Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      IMAGE_URL +
                                          (orderItem.productImage ?? ""),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              )
                            : const SizedBox.shrink(),
                        title: CustomStyledText(
                          text: orderItem.productName.toString() ?? "غير محدد",
                          fontSize: 16,
                          textColor: AppColors.lightGrayColor,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomStyledText(
                                  text: orderItem.productColor.toString() ??
                                      "غير محدد",
                                ),
                                CustomStyledText(
                                    text:
                                        "الكمية:  ${orderItem.count.toString() ?? "غير محدد"}")
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
