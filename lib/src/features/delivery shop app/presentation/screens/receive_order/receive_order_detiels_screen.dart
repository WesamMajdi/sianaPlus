import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/pagination/pagination_params.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20maintenance%20app/customSureDialog.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/domain/entities/receive_order_detiels_entity.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/controller/Cubit/delivery_shop_cubit.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/controller/state/deliveryShop_state.dart';
import 'package:maintenance_app/src/features/delivery%20shop%20app/presentation/screens/receive_order/receive_order_screen.dart';

class ReceiveOrdersDetailsScreen extends StatefulWidget {
  final int basketId;

  const ReceiveOrdersDetailsScreen({
    Key? key,
    required this.basketId,
  }) : super(key: key);

  @override
  State<ReceiveOrdersDetailsScreen> createState() =>
      _ReceiveOrdersDetailsScreenState();
}

class _ReceiveOrdersDetailsScreenState
    extends State<ReceiveOrdersDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<DeliveryShopCubit>()
        .fetchOrderItemsByBasketId(widget.basketId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarApplicationArrow(
        text: 'تفاصيل طلب',
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
            if (state.selectedOrderItems.isEmpty) {
              return const Center(
                child: CustomStyledText(text: 'لا توجد إيصالات استلام'),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: state.selectedOrderItems.length,
              itemBuilder: (context, index) {
                final order = state.selectedOrderItems[index];

                return _buildOrderItem(context, order);
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
      BuildContext context, ReceiveOrderDetielsEntity order) {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: CustomStyledText(
                              text: order.productName.toString(),
                              fontSize: 25,
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        IMAGE_URL + order.productImage!,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  width: 100,
                                  height: 100,
                                ),
                                AppSizedBox.kVSpace20,
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const CustomStyledText(
                                        text: 'لون',
                                        fontSize: 18,
                                        textColor: AppColors.secondaryColor,
                                      ),
                                      CustomStyledText(
                                        text: order.productColor.toString(),
                                        fontSize: 16,
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const CustomStyledText(
                                        text: 'السعر',
                                        fontSize: 18,
                                        textColor: AppColors.secondaryColor,
                                      ),
                                      CustomStyledText(
                                        text: order.price.toString(),
                                        fontSize: 16,
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const CustomStyledText(
                                        text: 'الكمية',
                                        fontSize: 18,
                                        textColor: AppColors.secondaryColor,
                                      ),
                                      CustomStyledText(
                                        text: order.count.toString(),
                                        fontSize: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.grey[200],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: const CustomStyledText(
                                    text: "إلغاء",
                                    fontSize: 12,
                                    textColor: AppColors.darkGrayColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomStyledText(
                          text: order.productName.toString(),
                          fontSize: 20,
                          textColor: AppColors.secondaryColor,
                        ),
                        CustomStyledText(
                          text: '${order.price ?? 0} ريال',
                          fontSize: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        buildTakeOrderButtonWidget(context)
      ],
    );
  }

  Widget buildTakeOrderButtonWidget(BuildContext context) {
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
                        getTakeOrderTile(context, widget.basketId)
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

  Widget getTakeOrderTile(BuildContext context, int basketId) {
    return ListTile(
      title: const CustomStyledText(
        text: 'اخذ طلب',
        fontSize: 20,
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomSureDialog(
              onConfirm: () async {
                print(basketId);
                await context.read<DeliveryShopCubit>().takeOrder(
                      basketId: basketId,
                    );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ReceiveOrdersDetailsScreen(basketId: basketId),
                  ),
                );

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReceiveOrderScreen(),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
