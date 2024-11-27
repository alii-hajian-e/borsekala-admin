import 'package:bors_web_admin_sms/presention/component/button_component/btn/_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/value_manager.dart';
import '../button_component/select-btn/select-bn.dart';

class ItemListUser extends StatelessWidget {
  final bool activeCheckBox;
  final bool activeEditItem;
  final bool itemsActive;
  final bool btnActive;
  final VoidCallback? onTap;
  final VoidCallback? onPressEditeItem;
  final VoidCallback? onPressDeleteItem;
  final VoidCallback? onPressBtnActiveAdmin;
  final String itemsUserName;
  final String itemsUserFamily;
  final String itemsUserPhone;
  final String? txtActiveBtnAdmin;
  final Color? colorBtnActiveAdmin;
  final Color? colorTextBtnActiveAdmin;
  final int itemsIndex;

  const ItemListUser({super.key, required this.activeCheckBox, this.onTap, required this.itemsActive, required this.activeEditItem, required this.itemsUserName, required this.itemsUserFamily, required this.itemsUserPhone, required this.itemsIndex, this.onPressEditeItem, this.onPressDeleteItem, required this.btnActive, this.txtActiveBtnAdmin, this.onPressBtnActiveAdmin, this.colorBtnActiveAdmin, this.colorTextBtnActiveAdmin});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: AppSize.s48,
          margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              activeCheckBox ?
              InkWell(
                onTap: onTap,
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
              ) :
              Text('${itemsIndex + 1}',style: getMediumStyle(color: ColorManager.black,fontSize: AppSize.s14)),
              const SizedBox(width: AppSize.s64),
              SizedBox(
                width: AppSize.s180,
                child: Text(itemsUserName,style: getMediumStyle(color: ColorManager.black,fontSize: AppSize.s14)),
              ),
              SizedBox(
                width: AppSize.s220,
                child: Text(itemsUserFamily,style: getMediumStyle(color: ColorManager.black,fontSize: AppSize.s14)),
              ),
              Expanded(
                child: Text(itemsUserPhone,style: getMediumStyle(color: ColorManager.black,fontSize: AppSize.s14)),
              ),
              Expanded(child: Container()),
              activeEditItem ?
              Row(
                children: [
                  SelectBtn(
                    appPaddingSelect: AppPadding.p0,
                    appSizeBtn: AppSize.s14,
                    mainAxisAlignmentSelect: MainAxisAlignment.spaceBetween,
                    visibleSelect: false,
                    iconSelect: SvgPicture.asset(ImageAssets.edit,width: AppSize.s24,height: AppSize.s24),
                    onPress: onPressEditeItem,
                    text: 'ویرایش',
                    borderColor: ColorManager.white,
                    radius: AppSize.s0,
                    heightBtn: AppSize.s48,
                    colorTextSelect: ColorManager.black.withOpacity(0.6),
                    backgroundColorSelect: ColorManager.white,
                  ),
                  const SizedBox(width: AppSize.s16),
                  SelectBtn(
                    appPaddingSelect: AppPadding.p0,
                    appSizeBtn: AppSize.s14,
                    mainAxisAlignmentSelect: MainAxisAlignment.spaceBetween,
                    visibleSelect: false,
                    iconSelect: SvgPicture.asset(ImageAssets.trash,width: AppSize.s24,height: AppSize.s24),
                    onPress: onPressDeleteItem,
                    text: 'حذف',
                    borderColor: ColorManager.white,
                    radius: AppSize.s0,
                    heightBtn: AppSize.s48,
                    colorTextSelect: ColorManager.red,
                    backgroundColorSelect: ColorManager.white,
                  ),
                ],
              ) :
              Container(),
              const SizedBox(width: AppSize.s64),
              btnActive ?
              SizedBox(
                width: MediaQuery.of(context).size.width / 15,
                child: Btn(
                  buttonColorBtn: colorBtnActiveAdmin ?? ColorManager.black,
                  onPress: onPressBtnActiveAdmin,
                  text: txtActiveBtnAdmin ?? '',
                  heightBtn: AppSize.s48,
                  borderRadiusBtn: AppSize.s8,
                  buttonTextColorBtn: colorTextBtnActiveAdmin ?? ColorManager.black,
                  borderSideColorBtn: ColorManager.black.withOpacity(0),
                ),
              ) :
              Container()

            ],
          ),
        ),
        Divider(color: ColorManager.gray,height: AppSize.s05),
      ],
    );
  }
}
