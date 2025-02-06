// ignore_for_file: file_names



import 'package:bors_web_admin_sms/presention/resources/value_manager.dart';
import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';

class ItemListSubCategury extends StatelessWidget {

  final bool itemsActive;
  final dynamic onTapCheckBoxAll;
  final String name;

  const ItemListSubCategury({super.key, required this.itemsActive, this.onTapCheckBoxAll, required this.name});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: onTapCheckBoxAll,
            child: Container(
              width: AppSize.s24,
              height: AppSize.s24,
              decoration: BoxDecoration(
                color: itemsActive ? ColorManager.yellow.withOpacity(0.2) : ColorManager.gray,
                borderRadius: BorderRadius.circular(AppSize.s8),
                border: Border.all(
                  color: itemsActive ? ColorManager.yellow : ColorManager.gray1,
                  width: AppSize.s2,
                ),
              ),
              child: itemsActive ?
              const Icon(
                Icons.check,
                color: Colors.black,
                size: AppSize.s18,
              ) :
              null,
            ),
          ),
          const SizedBox(width: AppSize.s16),
          Expanded(
            child: Text(name,style: getMediumStyle(color: ColorManager.black,fontSize: AppSize.s14),maxLines: 1,overflow: TextOverflow.ellipsis,),
          ),
        ],
      ),
    );
  }
}
