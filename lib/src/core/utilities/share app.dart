import 'package:share_plus/share_plus.dart';
import '../export file/exportfiles.dart';

void shareAppLink() {
  if (Platform.isAndroid) {
    Share.share(
        'https://play.google.com/store/apps/details?id=com.example.app');
  } else if (Platform.isIOS) {
    Share.share('https://apps.apple.com/app/id123456789');
  } else {
    Share.share('https://example.com');
  }
}
