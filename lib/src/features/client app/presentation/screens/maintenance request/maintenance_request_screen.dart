import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maintenance_app/main.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/services/telr_service_xml.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20maintenance%20request/itemsMaintenanceRequest.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/orders_model_request.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/order_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/order_state.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/shipping/shipping_screen.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/screens/webviwe/telr_order_maintenace_payment_screen.dart';
import '../map/map_picker_screen.dart';

class MaintenanceRequestPage extends StatefulWidget {
  const MaintenanceRequestPage({super.key});

  @override
  State<MaintenanceRequestPage> createState() => _MaintenanceRequestPageState();
}

class _MaintenanceRequestPageState extends State<MaintenanceRequestPage> {
  LatLng? _pickedLocation;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   context.read<OrderCubit>().clearItems();
  // }

  // Opens the map picker screen
  Future<void> _openMapPicker() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapPickerScreen()),
    );

    if (result != null && result is LatLng) {
      setState(() {
        _pickedLocation = result;
      });
    }
  }

  final TextEditingController locationController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // context.read<OrderCubit>().clearItems();
  }

  @override
  void initState() {
    super.initState();
    context.read<OrderCubit>().getNewOrderMaintenance();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) => Scaffold(
        drawer: const MyDrawer(),
        appBar: const AppBarApplication(text: 'طلب صيانة'),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Form(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: _openMapPicker,
                          child: CustomInputFielLocation(
                            hintText: _pickedLocation != null
                                ? '${_pickedLocation!.longitude}, ${_pickedLocation!.latitude}'
                                : 'حدد موقعك',
                            enabled: false,
                            icon: Icons.location_on_rounded,
                            controller: locationController,
                          ),
                        ),
                        AppSizedBox.kVSpace10,
                        Row(
                          children: [
                            Checkbox(
                              value: state.notifyCustomerOfTheCost,
                              onChanged: (value) {
                                context
                                    .read<OrderCubit>()
                                    .toggleNotifyCustomerOfTheCost(value!);
                              },
                            ),
                            const CustomStyledText(
                                text: 'إبلاغي بتكلفة الصيانة'),
                          ],
                        ),
                        CustomButton(
                          text: 'اضافة جهاز',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    InsertMaintenanceRequestPage(
                                  latLong: _pickedLocation,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  AppSizedBox.kVSpace20,

                  // Orders List
                  BlocBuilder<OrderCubit, OrderState>(
                    builder: (context, state) {
                      if (state.itemOrdersStatus == ItemOrdersStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state.itemOrdersStatus == ItemOrdersStatus.failure) {
                        return const Center(child: Text('فشلت العملية'));
                      }
                      if (state.itemOrdersStatus == ItemOrdersStatus.success &&
                          state.items.isNotEmpty) {
                        return ListView.builder(
                          shrinkWrap: true, // Important for nesting scrolls
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.items.length,
                          itemBuilder: (context, index) {
                            return ItemsMaintenanceRequest(
                              state: state,
                              i: index,
                              itemEntity: state.items[index],
                              // order: ,
                            );
                          },
                        );
                      }
                      return const Center(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomStyledText(text: 'لا توجد طلبات صيانة'),
                        ],
                      ));
                    },
                  ),

                  state.items.isNotEmpty
                      ? BlocListener<OrderCubit, OrderState>(
                          listener: (context, state) {
                            if (state.orderCreationStatus ==
                                OrderCreationStatus.success) {
                              Navigator.pop(context);
                            }
                          },
                          listenWhen: (previous, current) =>
                              previous != current,
                          child: Column(children: [
                            AppSizedBox.kVSpace20,
                            state.orderCreationStatus ==
                                    OrderCreationStatus.loading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : CustomButton(
                                    text: 'اضافة طلب',
                                    onPressed: () async {
                                      if (_pickedLocation == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            backgroundColor: Colors.red,
                                            behavior: SnackBarBehavior.floating,
                                            content: Text('يجب تحديد الموقع'),
                                          ),
                                        );
                                        return;
                                      } else {
                                        final createOrder = CreateOrderRequest(
                                          total: 0,
                                          discount: 0,
                                          locationForDelivery:
                                              '${_pickedLocation!.latitude},${_pickedLocation!.longitude}',
                                          notifyCustomerOfTheCost:
                                              state.notifyCustomerOfTheCost,
                                          handReceipt: HandReceipt(
                                            items: state.items
                                                .map((e) => Items(
                                                    itemId: e.item!.id,
                                                    colorId: e.color!.id,
                                                    companyId: e.company!.id,
                                                    description:
                                                        e.description!))
                                                .toList(),
                                          ),
                                        );

                                        double fees = NavigationService
                                            .navigatorKey.currentContext!
                                            .read<OrderCubit>()
                                            .state
                                            .fees;

                                        if (fees > 0) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Center(
                                                      child: Container(
                                                        width: 50,
                                                        height: 5,
                                                        margin: const EdgeInsets
                                                            .only(bottom: 15),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.grey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                    const CustomStyledText(
                                                      text: 'رسوم توصيل',
                                                      fontSize: 20,
                                                      textColor: AppColors
                                                          .secondaryColor,
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 5),
                                                      width: double.infinity,
                                                      color: Colors.grey,
                                                      height: 0.5,
                                                    ),
                                                  ],
                                                ),
                                                content: const SizedBox(
                                                  height: 45,
                                                  width: 400,
                                                  child: CustomStyledText(
                                                      text:
                                                          'يجب دفع رسوم التوصيل الآن لإكمال الطلب. هل ترغب في المتابعة؟'),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              FutureBuilder<
                                                                  String?>(
                                                            future: TelrServiceXML
                                                                .createPayment(
                                                                    fees),
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                      .connectionState ==
                                                                  ConnectionState
                                                                      .waiting) {
                                                                return const Center(
                                                                    child:
                                                                        CircularProgressIndicator());
                                                              } else if (snapshot
                                                                  .hasError) {
                                                                return Center(
                                                                    child: Text(
                                                                        'Error: ${snapshot.error}'));
                                                              } else if (snapshot
                                                                      .hasData &&
                                                                  snapshot.data !=
                                                                      null) {
                                                                return TelrMaihtenancePaymentScreen(
                                                                  paymentUrl:
                                                                      snapshot
                                                                          .data!,
                                                                  createOrder:
                                                                      createOrder,
                                                                );
                                                              } else {
                                                                return const Center(
                                                                    child: Text(
                                                                        'Payment creation failed'));
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                        content: CustomStyledText(
                                                            text:
                                                                'تمت إضافة الطلب بنجاح!'),
                                                        duration: Duration(
                                                            seconds: 2),
                                                        backgroundColor:
                                                            Colors.green,
                                                      ));
                                                    },
                                                    style: TextButton.styleFrom(
                                                      backgroundColor: AppColors
                                                          .secondaryColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                    ),
                                                    child:
                                                        const CustomStyledText(
                                                      text: "تأكيد",
                                                      textColor: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Center(
                                                      child: Container(
                                                        width: 50,
                                                        height: 5,
                                                        margin: const EdgeInsets
                                                            .only(bottom: 15),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.grey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                    const CustomStyledText(
                                                      text: 'هدية لك!',
                                                      fontSize: 20,
                                                      textColor: AppColors
                                                          .secondaryColor,
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 5),
                                                      width: double.infinity,
                                                      color: Colors.grey,
                                                      height: 0.5,
                                                    ),
                                                  ],
                                                ),
                                                content: const SizedBox(
                                                  height: 45,
                                                  width: 400,
                                                  child: CustomStyledText(
                                                      text:
                                                          'هدية لك! التوصيل مجاني كهدية 🎁، سيتم إرسال الطلب الآن.'),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      context
                                                          .read<OrderCubit>()
                                                          .createOrderMaintenance(
                                                              createOrder);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          content: CustomStyledText(
                                                              text:
                                                                  'تمت إضافة الطلب بنجاح!'),
                                                          duration: Duration(
                                                              seconds: 2),
                                                          backgroundColor:
                                                              Colors.green,
                                                        ),
                                                      );
                                                    },
                                                    style: TextButton.styleFrom(
                                                      backgroundColor: AppColors
                                                          .secondaryColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                    ),
                                                    child:
                                                        const CustomStyledText(
                                                      text: "تأكيد",
                                                      textColor: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      }
                                    },
                                  ),
                          ]),
                        )
                      : const Text(''),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
