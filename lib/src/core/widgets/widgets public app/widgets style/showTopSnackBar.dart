import 'package:flutter/material.dart';
import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';

void showTopSnackBar(BuildContext context, String message, Color color) {
  final snackBarKey = GlobalKey<_SnackBarState>();
  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Stack(
          children: [
            Positioned(
              top: 80,
              left: 20,
              right: 20,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Material(
                  color: color,
                  child: TopSnackBar(
                    key: snackBarKey,
                    message: message,
                    color: color,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}

class TopSnackBar extends StatefulWidget {
  final String message;
  final Color color;
  const TopSnackBar({super.key, required this.message, required this.color});

  @override
  // ignore: library_private_types_in_public_api
  _SnackBarState createState() => _SnackBarState();
}

class _SnackBarState extends State<TopSnackBar> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: widget.color,
          width: 1.0,
        ),
      ),
      child: CustomStyledText(
        text: widget.message,
        textColor: Colors.white,
      ),
    );
  }
}
