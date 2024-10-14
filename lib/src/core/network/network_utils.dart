import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

Future<bool> hasInternetConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult != ConnectivityResult.none) {
    return await InternetConnectionChecker().hasConnection;
  } else {
    return false;
  }
}
