import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class AppSearch extends StatefulWidget {
  const AppSearch({super.key, this.validators});
  final FormFieldValidator<String>? validators;
  @override
  State<AppSearch> createState() => _AppSearchState();
}

class _AppSearchState extends State<AppSearch> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                onTap: () {
                  searchController.clear();
                },
                onChanged: (value) {
                  setState(() {});
                },
                controller: searchController,
                validator: widget.validators,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none),
                  prefixIcon: const Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 20,
                    color: Colors.grey,
                  ),
                  suffixIcon: searchController.text.isEmpty
                      ? null
                      : const Icon(
                          Icons.cancel_sharp,
                          color: Colors.black,
                        ),
                  hintText: "ابحث عن المنتج",
                  hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Tajawal"),
                ),
              ),
            ),
          ],
        ));
  }
}
