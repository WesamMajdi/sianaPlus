// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/region/region_model.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/cubits/category_cubit.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/category_state.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({
    Key? key,
    required this.onConfirm,
  }) : super(key: key);
  final VoidCallback onConfirm;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  BaseViewModel? _selectedRegion;
  BaseViewModel? _selectedCity;
  BaseViewModel? _selectedVillage;
  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().fetchAllRegion();
  }

  void _onRegionChanged(BaseViewModel? selectedRegion) {
    if (selectedRegion == null) return;

    context.read<CategoryCubit>().selectItem(selectedRegion);

    setState(() {
      _selectedRegion = selectedRegion;
      _selectedCity = null;
      _selectedVillage = null;
    });

    context.read<CategoryCubit>().fetchAllCity(selectedRegion.id);
  }

  void _onCityChanged(BaseViewModel? selectedCity) {
    if (selectedCity == null) return;

    context.read<CategoryCubit>().selectItemCity(selectedCity);

    setState(() {
      _selectedCity = selectedCity;
      _selectedVillage = null;
    });

    context.read<CategoryCubit>().fetchAllVillage(selectedCity.id);
  }

  void _onVillageChanged(BaseViewModel? selectedVillage) {
    if (selectedVillage == null) return;

    context.read<CategoryCubit>().selectItemVillage(selectedVillage);

    setState(() {
      _selectedVillage = selectedVillage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarApplicationArrow(
        text: 'الدفع والشحن',
        onBackTap: () {
          Navigator.pop(context);
        },
      ),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state.regionStatus == RegionStatus.loading) {
            return const Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: CircularProgressIndicator()),
                    AppSizedBox.kVSpace20,
                    CustomStyledText(
                      text: 'جاري تحميل البيانات...',
                    ),
                  ],
                ),
              ),
            );
          }
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSizedBox.kVSpace20,
                  const CustomLabelText(text: "اسم المنطقة:*"),
                  CustomSearch(
                    hintText: 'اختر اسم المنطقة',
                    validators: (value) {
                      if (value == null) {
                        return 'يرجى اختيار اسم المنطقة';
                      }
                      return null;
                    },
                    items: state.listofRegion,
                    onChanged: _onRegionChanged,
                    selectedItem: _selectedRegion,
                  ),
                  const SizedBox(height: 16),
                  const CustomLabelText(text: "اسم المدينة:*"),
                  CustomSearch(
                    isEnabled: _selectedRegion != null,
                    hintText: 'اختر اسم المدينة',
                    validators: (value) {
                      if (value == null) {
                        return 'يرجى اختيار اسم المدينة';
                      }
                      return null;
                    },
                    items: state.listOfCity,
                    onChanged: _onCityChanged,
                    selectedItem: _selectedCity,
                  ),
                  const SizedBox(height: 16),
                  const CustomLabelText(text: "اسم الحي:*"),
                  CustomSearch(
                    hintText: 'اختر اسم الحي',
                    validators: (value) {
                      if (value == null) {
                        return 'يرجى اختيار اسم الحي';
                      }
                      return null;
                    },
                    items: state.listOfVillage,
                    onChanged: _onVillageChanged,
                    isEnabled: _selectedCity != null,
                    selectedItem: _selectedVillage,
                  ),
                  AppSizedBox.kVSpace20,
                  const CustomLabelText(text: "العنوان (الخط الأول):*"),
                  CustomInputField(
                    hintText: 'ادخل العنوان',
                    icon: Icons.location_city,
                    controller: addressLine1Controller,
                    validators: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال العنوان';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const CustomLabelText(text: "العنوان (الخط الثاني):"),
                  CustomInputField(
                    hintText: 'ادخل العنوان الثاني',
                    icon: Icons.location_city,
                    controller: addressLine2Controller,
                  ),
                  AppSizedBox.kVSpace20,
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      child: state.orderStatus == OrderStatus.loading
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton.icon(
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                padding: WidgetStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      vertical: 13, horizontal: 15),
                                ),
                                backgroundColor: WidgetStateProperty.all(
                                  (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppColors.lightGrayColor
                                      : AppColors.primaryColor),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<CategoryCubit>()
                                      .updateCheckoutData(
                                        region: _selectedRegion?.id,
                                        city: _selectedCity?.id,
                                        village: _selectedVillage?.id,
                                        addressLine1:
                                            addressLine1Controller.text,
                                        addressLine2:
                                            addressLine2Controller.text,
                                      );
                                  widget.onConfirm();
                                }
                              },
                              icon: const Icon(
                                FontAwesomeIcons.check,
                                color: Colors.white,
                              ),
                              label: const CustomStyledText(
                                text: "إِكمال الطلب",
                                textColor: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomSearch extends StatelessWidget {
  final List<BaseViewModel> items;
  final String hintText;
  final FormFieldValidator<BaseViewModel>? validators;
  final void Function(BaseViewModel?)? onChanged;
  final bool isEnabled;
  final BaseViewModel? selectedItem;

  const CustomSearch({
    Key? key,
    required this.items,
    required this.hintText,
    this.validators,
    this.onChanged,
    this.isEnabled = true,
    this.selectedItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.mediumPadding),
      child: Column(
        children: [
          DropdownSearch<BaseViewModel>(
            selectedItem: selectedItem,
            itemAsString: (item) => item.name,
            items: items,
            compareFn: (item1, item2) => item1.id == item2.id,
            popupProps: PopupProps.menu(
              menuProps: MenuProps(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              isFilterOnline: true,
              showSearchBox: true,
              showSelectedItems: true,
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  hintText: 'ابحث هنا',
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.2),
                  errorStyle:
                      const TextStyle(fontFamily: "Tajawal", fontSize: 14),
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontFamily: "Tajawal",
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.secondaryColor,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.secondaryColor,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: AppPadding.mediumPadding,
                    horizontal: AppPadding.mediumPadding,
                  ),
                ),
                style: const TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 16,
                ),
              ),
              itemBuilder: (context, item, isSelected) {
                return Column(children: [
                  ListTile(
                    title: CustomStyledText(
                      text: item.name,
                    ),
                  )
                ]);
              },
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                hintText: hintText,
                filled: true,
                fillColor: Colors.grey.withOpacity(0.2),
                errorStyle:
                    const TextStyle(fontFamily: "Tajawal", fontSize: 14),
                hintStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontFamily: "Tajawal",
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.secondaryColor,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.secondaryColor,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: AppPadding.mediumPadding,
                  horizontal: AppPadding.mediumPadding,
                ),
              ),
            ),
            onChanged: onChanged,
            validator: validators,
            enabled: isEnabled,
          ),
        ],
      ),
    );
  }
}
