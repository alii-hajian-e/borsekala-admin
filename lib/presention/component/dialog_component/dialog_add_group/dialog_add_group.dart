// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/value_manager.dart';


class WidgetDialogAddGroup extends StatelessWidget {

  final String name;
  const WidgetDialogAddGroup({
    super.key, required this.name
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorManager.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.s16),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p32),
        width: AppSize.s395,
        height: MediaQuery.of(context).size.height,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          ],
        ),
      ),
    );
  }
}
