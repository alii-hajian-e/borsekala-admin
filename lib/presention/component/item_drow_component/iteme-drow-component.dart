// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/value_manager.dart';

class DrawerNavigationItem extends StatelessWidget {
  final dynamic iconData;
  final String title;
  final bool selected;
  final Color colorTxt;
  final Function() onTap;
  const DrawerNavigationItem({
    super.key,
    required this.iconData,
    required this.colorTxt,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      leading: iconData,
      onTap: onTap,
      title: Text(title,style: getMediumStyle(color: colorTxt,fontSize: AppSize.s14)),
      selectedTileColor: ColorManager.yellow,
      selected: selected,
      selectedColor: ColorManager.black,
    );
  }
}
