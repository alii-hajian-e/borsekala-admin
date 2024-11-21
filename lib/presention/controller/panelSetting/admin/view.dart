import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/color_manager.dart';
import 'logic.dart';

class AdminPage extends StatelessWidget {
  AdminPage({super.key});

  final logic = Get.put(AdminLogic());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.red,
      ),
    );  }
}
