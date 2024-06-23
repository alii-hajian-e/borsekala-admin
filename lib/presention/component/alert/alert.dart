
import 'package:flutter/material.dart';

import '../../resources/styles_manager.dart';
import '../../resources/value_manager.dart';

class Alert {
  final String txt;
  final Color color;
  final Color backgroundColor;

  Alert({required this.txt, required this.color, required this.backgroundColor});

  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        content: Text(
          txt,
          style: getMediumStyle(
            color: color,
            fontSize: AppSize.s16,
          ),
        ),
      ),
    );
  }
}