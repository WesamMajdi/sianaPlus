import 'package:cached_network_image/cached_network_image.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/customSureDialog.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/domain/entities/current_order_detiles_entity.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/controller/Cubit/delivery_shop_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/controller/state/deliveryShop_state.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/screens/current_order/current_order_screen.dart';

class CurrentOrdersDetailsScreen extends StatefulWidget {
  final int basketId;

  const CurrentOrdersDetailsScreen({
    Key? key,
    required this.basketId,
  }) : super(key: key);

  @override
  State<CurrentOrdersDetailsScreen> createState() =>
      _CurrentOrdersDetailsScreenState();
}

class _CurrentOrdersDetailsScreenState
    extends State<CurrentOrdersDetailsScreen> {
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
              builder: (context) => CurrentTakeOrderScreen(),
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
        buildProccesOrderButtonWidget(context),
      ],
    );
  }

  Widget buildProccesOrderButtonWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          builder: (BuildContext context) {
            return BlocBuilder<DeliveryShopCubit, DeliveryShopState>(
              builder: (context, state) {
                if (state.deliveryShopStatus == DeliveryShopStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.deliveryShopStatus == DeliveryShopStatus.failure) {
                  return const Center(child: Text('فشلت العملية'));
                }
                if (state.deliveryShopStatus == DeliveryShopStatus.success) {
                  final order = state.selectedOrderDetilesCurrentItems;
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 50,
                          height: 5,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 12, left: 10),
                          alignment: Alignment.topRight,
                          child: const CustomStyledText(
                            text: 'اختر العملية:',
                            textColor: AppColors.secondaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ...getItemsBasedOnStatus(context, order[0].orderStatus),
                      ],
                    ),
                  );
                }
                return const Center(
                    child: CustomStyledText(text: 'لا توجد إيصالات استلام'));
              },
            );
          },
        );
        Navigator.maybePop(context);
      },
      child: SizedBox(
        height: 80,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: AppColors.secondaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FontAwesomeIcons.gear,
                        size: 20,
                      ),
                      AppSizedBox.kWSpace10,
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: const CustomStyledText(
                          text: 'العمليات',
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getItemsBasedOnStatus(
    BuildContext context,
    int status,
  ) {
    if (status == 1) {
      return [
        ListTile(
          title: const CustomStyledText(
            text: "اخذ من المخزن",
            fontSize: 20,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomSureDialog(onConfirm: () async {
                  final cubit = context.read<DeliveryShopCubit>();
                  try {
                    await cubit.updateStatusForOrder(
                        orderId: widget.basketId, status: 2);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CurrentOrdersDetailsScreen(
                            basketId: widget.basketId),
                      ),
                    );
                    Navigator.maybePop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CurrentTakeOrderScreen(),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to update status: $e')),
                    );
                  }
                });
              },
            );
          },
        ),
      ];
    } else if (status == 2) {
      return [
        ListTile(
          title: const CustomStyledText(
            text: "توصيل لعميل",
            fontSize: 20,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomSureDialog(onConfirm: () async {
                  final cubit = context.read<DeliveryShopCubit>();
                  try {
                    await cubit.updateStatusForOrder(
                        orderId: widget.basketId, status: 3);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CurrentOrdersDetailsScreen(
                            basketId: widget.basketId),
                      ),
                    );
                    Navigator.maybePop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CurrentTakeOrderScreen(),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to update status: $e')),
                    );
                  }
                });
              },
            );
          },
        ),
      ];
    } else if (status == 3) {
      return [
        ListTile(
          title: const CustomStyledText(
            text: "مكتمل",
            fontSize: 20,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomSureDialog(
                  onConfirm: () async {
                    final cubit = context.read<DeliveryShopCubit>();
                    try {
                      await cubit.updateStatusForOrder(
                          orderId: widget.basketId, status: 4);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CurrentOrdersDetailsScreen(
                              basketId: widget.basketId),
                        ),
                      );
                      Navigator.maybePop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CurrentTakeOrderScreen(),
                        ),
                      );
                    } catch (e) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to update status: $e')),
                      );
                    }
                  },
                );
              },
            );
          },
        ),
      ];
    } else if (status == 4) {
      return [];
    }

    return [];
  }
}
