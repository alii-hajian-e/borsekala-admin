import 'package:bors_web_admin_sms/presention/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class TransactionPage extends StatelessWidget {
  TransactionPage({super.key});

  final logic = Get.put(TransactionLogic());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.black,
      ),
    );
  }
}
