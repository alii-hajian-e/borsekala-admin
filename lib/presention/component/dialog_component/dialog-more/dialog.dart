// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:bors_web_admin_sms/presention/component/list_user/listUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/value_manager.dart';
import '../../button_component/btn/_btn.dart';
import '../../input_component/search_bar/search_component.dart';

class WidgetDialog extends StatelessWidget {

  final String name;
  final String mainCategory;
  final String grouping;
  final String subset;
  final String company;
  final String nameGroup;
  final int num;

  final bool activeCheckBox;
  final bool isCheckedAll;
  final dynamic onTapCheckBoxAll;
  final dynamic onChanged;
  final dynamic visibleBtnUser;
  final dynamic onPressAddUser;
  final dynamic child;
  final textFieldController;

  final dynamic childBtnDelete;

  const WidgetDialog({
    super.key, required this.name, required this.mainCategory, required this.grouping, required this.subset, required this.nameGroup, required this.num,required this.child, required this.activeCheckBox, required this.isCheckedAll, this.onTapCheckBoxAll, this.textFieldController, this.onChanged,required this.visibleBtnUser,required this.onPressAddUser, required this.childBtnDelete, required this.company
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.all(
      //     Radius.circular(AppSize.s16),
      //   ),
      // ),
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p32),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s16)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: AppSize.s8,
                  height: AppSize.s8,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(AppSize.s32)),
                    color: ColorManager.yellow
                  ),
                ),
                const SizedBox(width: AppSize.s16),
                Text(nameGroup,style: getBoldStyle(color: ColorManager.black,fontSize: AppSize.s18))
              ],
            ),
            const SizedBox(height: AppSize.s24),
            SizedBox(
              width: MediaQuery.of(context).size.width ,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('نام گروه : $name',style: getBoldStyle(color: ColorManager.black,fontSize: AppSize.s14)),
                      Text('دسته بندی اصلی : $mainCategory',style: getBoldStyle(color: ColorManager.black,fontSize: AppSize.s14)),
                    ],
                  ),),
                  const SizedBox(width: AppSize.s32),
                  Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('تعداد کاربر : $num'.toString(),style: getBoldStyle(color: ColorManager.black,fontSize: AppSize.s14)),
                      Text('دسته بندی : $grouping',style: getBoldStyle(color: ColorManager.black,fontSize: AppSize.s14)),
                    ],
                  ),),
                  const SizedBox(width: AppSize.s32),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('شرکت : $company',
                            style: getBoldStyle(color: ColorManager.black,fontSize: AppSize.s14),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('زیر دسته بندی : $subset',
                            style: getBoldStyle(color: ColorManager.black,fontSize: AppSize.s14),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSize.s24),
            SizedBox(
              width: AppSize.s260,
              child: SearchWidget(
                textFieldBorderSearch: BorderSide(
                    width: AppSize.s0, color: ColorManager.white),
                textFieldColor: ColorManager.gray1,
                textInputType: TextInputType.text,
                textFieldActive: false,
                prefixIcon: SvgPicture.asset(fit: BoxFit.scaleDown,ImageAssets.search,width: AppSize.s16,height: AppSize.s16,),
                textFieldHint: 'جست و جو',
                textFieldController: textFieldController,
                onChanged: onChanged,
              ),
            ),
            const SizedBox(height: AppSize.s24),
            Expanded(
              child: ListViewUser(
                childBtnDelete: childBtnDelete,
                activeCheckBox: activeCheckBox,
                isCheckedAll: true,
                onTapCheckBoxAll: onTapCheckBoxAll,
                child: child,
              ),
            ),
            const SizedBox(height: AppSize.s24),
            Row(
              children: [
                Visibility(
                  visible: visibleBtnUser,
                  child: SizedBox(
                    width: AppSize.s180,
                    child: Btn(
                      buttonColorBtn: ColorManager.yellow,
                      onPress: onPressAddUser,
                      text: 'افزودن کاربر',
                      heightBtn: AppSize.s40,
                      borderRadiusBtn: AppSize.s8,
                      buttonTextColorBtn: ColorManager.black,
                      borderSideColorBtn: ColorManager.yellow,
                    ),
                  ),
                ),
                Visibility(
                  visible: visibleBtnUser,
                  child: const SizedBox(width: AppSize.s16),
                ),
                SizedBox(
                  width: AppSize.s180,
                  child: Btn(
                    buttonColorBtn: ColorManager.gray1,
                    onPress: () {
                      GoRouter.of(context).pop();
                      // Get.back();
                      },
                    text: 'بستن',
                    heightBtn: AppSize.s40,
                    borderRadiusBtn: AppSize.s8,
                    buttonTextColorBtn: ColorManager.black,
                    borderSideColorBtn: ColorManager.gray1,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
