import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20maintenance%20request/itemsMaintenanceRequest.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/orders_model_request.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/order_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/order_state.dart';
import '../map/map_picker_screen.dart';

class MaintenanceRequestPage extends StatefulWidget {
  const MaintenanceRequestPage({super.key});

  @override
  State<MaintenanceRequestPage> createState() => _MaintenanceRequestPageState();
}

class _MaintenanceRequestPageState extends State<MaintenanceRequestPage> {
  LatLng? _pickedLocation;

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
                                text: 'سيتم إبلاغ العميل بالتكلفة'),
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
                          child: CustomStyledText(text: 'لا توجد طلبات صيانة'));
                    },
                  ),

                  state.items.isNotEmpty
                      ? BlocListener<OrderCubit, OrderState>(
                          listener: (context, state) {
                            if (state.orderCreationStatus ==
                                OrderCreationStatus.success ) {
                              Navigator.pop(context);
                            }
                          },
                    listenWhen: (previous, current) => previous != current,
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
                                        await context
                                            .read<OrderCubit>()
                                            .createOrderMaintenance(
                                                createOrder);
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
