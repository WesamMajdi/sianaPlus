import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/orders_model_request.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/order_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/order_state.dart';

class InsertMaintenanceRequestPage extends StatefulWidget {
  InsertMaintenanceRequestPage({super.key, required this.latLong});

  final LatLng? latLong;

  @override
  State<InsertMaintenanceRequestPage> createState() =>
      _InsertMaintenanceRequestPageState();
}

class _InsertMaintenanceRequestPageState
    extends State<InsertMaintenanceRequestPage> {
  @override
  void initState() {
    super.initState();
    context.read<OrderCubit>().fetchColorList();
    context.read<OrderCubit>().fetchCompaniesList();
    context.read<OrderCubit>().fetchItemsList();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController devicenameController = TextEditingController();
  TextEditingController causeofthebreakdownController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state.colorStatus == ColorStatus.loading ||
            state.itemsStatus == ItemsStatus.loading ||
            state.companiesStatus == CompaniesStatus.loading) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  AppSizedBox.kVSpace20,
                  CustomStyledText(
                    text: 'جاري تحميل البيانات...',
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBarApplicationArrow(
              text: 'اضافة جهاز لصيانة',
              onBackTap: () {
                Navigator.pop(context);
              },
            ),
            body: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: (Theme.of(context).brightness == Brightness.dark
                          ? AppColors.lightGrayColor
                          : AppColors.primaryColor),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  height: 140,
                  width: 120,
                  child: Container(
                      margin: const EdgeInsets.only(top: 25, bottom: 25),
                      child: Image.asset("assets/images/logoWhit.png")),
                ),
                AppSizedBox.kVSpace20,
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const CustomLabelText(
                          text: 'اسم الجهاز',
                        ),
                        AppSizedBox.kVSpace5,
                        CustomSearchDropdown(
                          hintText: 'اختر اسم الجهاز',
                          validators: (value) {
                            if (value == null) {
                              return 'عفوا.يرجي اختيار اسم الجهاز';
                            }
                            return null;
                          },
                          items: state.itemsList,
                          onChanged: (p0) {
                            context.read<OrderCubit>().selectItem(p0!);
                          },
                        ),
                        AppSizedBox.kVSpace10,
                        const CustomLabelText(
                          text: 'شركة الجهاز',
                        ),
                        AppSizedBox.kVSpace5,
                        CustomSearchDropdown(
                          hintText: 'اختر شركة الجهاز',
                          validators: (value) {
                            if (value == null) {
                              return 'عفوا.يرجي اختيار شركة الجهاز';
                            }
                            return null;
                          },
                          items: state.companiesList,
                          onChanged: (p0) {
                            context.read<OrderCubit>().selectCompany(p0!);
                          },
                        ),
                        AppSizedBox.kVSpace10,
                        const CustomLabelText(
                          text: 'لون جهاز',
                        ),
                        AppSizedBox.kVSpace5,
                        CustomSearchDropdown(
                          validators: (value) {
                            if (value == null) {
                              return 'عفوا.يرجي اختيار لون الجهاز';
                            }
                            return null;
                          },
                          hintText: 'اختر لون القطعة',
                          items: state.colorsList,
                          onChanged: (p0) {
                            context.read<OrderCubit>().selectColor(p0!);
                          },
                        ),
                        AppSizedBox.kVSpace10,
                        const CustomLabelText(
                          text: 'وصف العطل',
                        ),
                        AppSizedBox.kVSpace5,
                        Texteara(
                          hintText: 'ادخل وصف العطل',
                          controller: causeofthebreakdownController,
                          validators: (value) {
                            if (value == null || value.isEmpty) {
                              return 'عفوا.ادخل وصف العطل مطلوب';
                            }
                            return null;
                          },
                        ),
                        AppSizedBox.kVSpace20,
                        state.orderCreationStatus == OrderCreationStatus.loading
                            ? const CircularProgressIndicator()
                            : CustomButton(
                                text: 'اضافة جهاز',
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    final createItem = Items(
                                        itemId: context
                                            .read<OrderCubit>()
                                            .state
                                            .selectedItem!
                                            .id!,
                                        colorId: context
                                            .read<OrderCubit>()
                                            .state
                                            .selectedColor!
                                            .id!,
                                        companyId: context
                                            .read<OrderCubit>()
                                            .state
                                            .selectedCompany!
                                            .id!,
                                        description:
                                            causeofthebreakdownController.text);
                                    final createItemEntity = ItemsEntity(
                                        item: context
                                            .read<OrderCubit>()
                                            .state
                                            .selectedItem!,
                                        color: context
                                            .read<OrderCubit>()
                                            .state
                                            .selectedColor!,
                                        company: context
                                            .read<OrderCubit>()
                                            .state
                                            .selectedCompany!,
                                        description:
                                            causeofthebreakdownController.text);

                                    context.read<OrderCubit>().saveItem(
                                        item: createItem,
                                        itemsEntity: createItemEntity);

                                    Navigator.pop(context);
                                  }
                                },
                              ),
                      ],
                    )),
              ],
            ));
      },
      buildWhen: (previous, current) => previous != current,
    );
  }

  // CreateOrderRequest get createOrderRequest => ;
}
