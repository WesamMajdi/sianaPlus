import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

class MaintenancePartsPage extends StatelessWidget {
  const MaintenancePartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: const AppBarApplication(text: 'قطع الصيانة'),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(50),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              CustomStyledText(text: "الثلاجة"),
            ],
          ),
        ),
      ),
    );
  }
}
