import 'package:bors_web_admin_sms/presention/resources/styles_manager.dart';
import 'package:bors_web_admin_sms/presention/resources/value_manager.dart';
import 'package:flutter/material.dart';

class CustomOverlayMessage extends StatelessWidget {
  final String message;
  final Duration duration;
  final Color backgroundColor;
  final Color textColor;

  const CustomOverlayMessage({
    super.key,
    required this.message,
    this.duration = const Duration(seconds: 3),
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
  });

  static void show(BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: MediaQuery.of(context).size.width * 0.01,
        right: MediaQuery.of(context).size.width * 0.01,
        bottom: AppSize.s24,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.s16, vertical: AppSize.s16),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(AppSize.s8),
            ),
            child: Text(
              message,
              style: getBoldStyle(
                color: textColor,
                fontSize: AppSize.s14,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(); // این ویجت فقط برای استفاده از متد show است
  }
}
