import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:maintenance_app/src/core/widgets/widgets%20client%20app/widgets%20maintenance%20request/itemsMaintenanceRequest.dart';

class MaintenanceRequestPage extends StatefulWidget {
  const MaintenanceRequestPage({super.key});

  @override
  State<MaintenanceRequestPage> createState() => _MaintenanceRequestPageState();
}

class _MaintenanceRequestPageState extends State<MaintenanceRequestPage> {
  TextEditingController locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: const AppBarApplication(text: 'طلب صيانة'),
      body: ListView(
        children: [
          Form(
              child: Column(
            children: [
              CustomInputFielLocation(
                hintText: 'حدد موقعك',
                icon: Icons.location_off_rounded,
                controller: locationController,
              ),
              AppSizedBox.kVSpace10,
              CustomButton(
                text: 'اضافة طلب',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const InsertMaintenanceRequestPage(),
                    ),
                  );
                },
              ),
            ],
          )),
          for (int i = 1; i <= 10; i++) ItemsMaintenanceRequest(i: i),
        ],
      ),
    );
  }
}
