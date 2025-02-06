// ignore_for_file: file_names


import 'package:bors_web_admin_sms/presention/resources/value_manager.dart';
import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';

class ListViewUser extends StatelessWidget {

  final bool activeCheckBox;
  final bool isCheckedAll;
  final dynamic onTapCheckBoxAll;
  final dynamic child;
  final dynamic childBtnDelete;
  final String emailTxt;

  const ListViewUser(
      {super.key, required this.activeCheckBox, required this.isCheckedAll, this.onTapCheckBoxAll, this.child, required this.childBtnDelete, required this.emailTxt});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              activeCheckBox ?
              InkWell(
                onTap: onTapCheckBoxAll,
                child: Container(
                  width: AppSize.s24,
                  height: AppSize.s24,
                  decoration: BoxDecoration(
                    color: isCheckedAll
                        ? ColorManager.yellow.withValues(alpha: 0.2)
                        : ColorManager.gray,
                    borderRadius: BorderRadius.circular(AppSize.s8),
                    border: Border.all(
                      color: isCheckedAll ? ColorManager.yellow : ColorManager
                          .gray1,
                      width: AppSize.s2,
                    ),
                  ),
                  child: isCheckedAll ?
                  const Icon(
                    Icons.check,
                    color: Colors.black,
                    size: AppSize.s18,
                  ) :
                  null,
                ),
              ) :
              Text("ردیف", style: getMediumStyle(
                  color: ColorManager.black.withValues(alpha: 0.5), fontSize: AppSize.s14)),
              const SizedBox(width: AppSize.s40),
              SizedBox(
                width: AppSize.s220,
                child: Text('نام / نام خانوادگی', style: getMediumStyle(
                    color: ColorManager.black.withValues(alpha: 0.5), fontSize: AppSize.s14)),
              ),
              SizedBox(
                width: AppSize.s220,
                child: Text('نام شرکت', style: getMediumStyle(
                    color: ColorManager.black.withValues(alpha: 0.5), fontSize: AppSize.s14)),
              ),
              SizedBox(
                width: AppSize.s220,
                child: Text(emailTxt, style: getMediumStyle(
                    color: ColorManager.black.withValues(alpha: 0.5), fontSize: AppSize.s14)),
              ),
              Expanded(child: Container()),
              childBtnDelete
            ],
          ),
          const SizedBox(height: AppSize.s8),
          Divider(color: ColorManager.black.withValues(alpha: 0.5), height: AppSize.s2),
          child
        ],
      ),
    );
  }
}
