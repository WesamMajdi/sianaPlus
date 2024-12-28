import 'package:dropdown_search/dropdown_search.dart';

import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/features/client%20app/data/model/orders/color_entery.dart';
import 'package:maintenance_app/src/features/client%20app/presentation/controller/states/order_state.dart';

class CustomSearchDropdown extends StatefulWidget {
  final List<OrderEntery> items;
  final String hintText;
  final FormFieldValidator<OrderEntery>? validators;
   void Function(OrderEntery?)? onChanged;

   CustomSearchDropdown({
    Key? key,
    required this.items,
    required this.hintText,
    this.validators,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomSearchDropdown> createState() => _CustomSearchDropdownState();
}

class _CustomSearchDropdownState extends State<CustomSearchDropdown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.mediumPadding),
      child: Column(
        children: [
          DropdownSearch<OrderEntery>(
            itemAsString: (item) => item.name!,
              items: widget.items,
              compareFn: (item1, item2) {
                return item1 == item2;
              },
              popupProps: PopupProps.menu(
                menuProps: MenuProps(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
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
                        fontFamily: "Tajawal"),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.secondaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.secondaryColor, width: 2.0),
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
                  return Column(
                    children: [
                      ListTile(
                        title: CustomStyledText(
                          text: item.name!,
                          textColor:
                              (Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        selected: isSelected,
                      ),
                    ],
                  );
                },
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  hintText: widget.hintText,
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.2),
                  errorStyle:
                      const TextStyle(fontFamily: "Tajawal", fontSize: 14),
                  hintStyle: const TextStyle(
                      fontSize: 16, color: Colors.grey, fontFamily: "Tajawal"),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColors.secondaryColor, width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColors.secondaryColor, width: 2.0),
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
              onChanged: widget.onChanged,
              validator: widget.validators
          ),
        ],
      ),
    );
  }
}
