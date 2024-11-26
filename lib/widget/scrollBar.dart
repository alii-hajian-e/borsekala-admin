// ignore_for_file: file_names

import 'package:bors_web_admin_sms/presention/resources/value_manager.dart';
import 'package:flutter/material.dart';

class ScrollBarWidget extends StatelessWidget {
  final ScrollController controllerScrollBar;
  final dynamic childUi;

  const ScrollBarWidget({super.key, required this.controllerScrollBar, this.childUi});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: controllerScrollBar,
      thumbVisibility: true,
      trackVisibility: true,
      radius: const Radius.circular(AppSize.s2),
      thickness: AppSize.s8,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppPadding.p16, AppPadding.p0, AppPadding.p0, AppPadding.p0),
        child: childUi,
      )
    );
  }
}
