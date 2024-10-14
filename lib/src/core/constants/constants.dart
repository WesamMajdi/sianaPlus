import 'package:flutter/material.dart';

const kAppName = 'Siana Plus';

class AppColors {
  static const Color primaryColor = Color(0xFF28489d);
  static const Color secondaryColor = Color(0xFFeb6624);
  static const Color darkGrayColor = Color(0xFF35353a);
  static const Color lightGrayColor = Color(0xFFe4eaf6);
}

class AppPadding {
  static const double smallPadding = 8.0;
  static const double mediumPadding = 16.0;
  static const double largePadding = 24.0;
  static const double extraLargePadding = 32.0;
}

class AppSizedBox {
  static const kVSpace5 = SizedBox(
    height: 5,
  );
  static const kVSpace10 = SizedBox(
    height: 10.0,
  );
  static const kVSpace15 = SizedBox(
    height: 15.0,
  );
  static const kVSpace20 = SizedBox(
    height: 20.0,
  );
  static const kWSpace5 = SizedBox(
    width: 5.0,
  );
  static const kWSpace10 = SizedBox(
    width: 10.0,
  );
  static const kWSpace15 = SizedBox(
    width: 15.0,
  );
  static const kWSpace20 = SizedBox(
    width: 20.0,
  );
}

String truncateTextTitle(String text, {int maxLength = 12}) {
  return text.length > maxLength ? '${text.substring(0, maxLength)}...' : text;
}

String truncateTextDescription(String text, {int maxLength = 40}) {
  return text.length > maxLength ? '${text.substring(0, maxLength)}...' : text;
}

List<BoxShadow> shadowList = [
  BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      blurRadius: 10,
      spreadRadius: 3,
      offset: const Offset(0, 3))
];
