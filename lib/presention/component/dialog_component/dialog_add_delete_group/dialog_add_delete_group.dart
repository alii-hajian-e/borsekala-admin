// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/value_manager.dart';
import '../../button_component/btn/_btn.dart';
import '../../button_component/org-btn/wid_button.dart';
import '../../button_component/select-btn/select-bn.dart';
import '../../input_component/defult/defulttextfield.dart';


class DialogAdd_DeleteGroup extends StatelessWidget {

  final String txtAlert;
  final dynamic child;
  final TextEditingController textFieldController;
  final String hintText;
  final RxString txtHintGroup;
  final RxString txtHintMainGroup;
  final RxString txtHintSubGroup;
  final RxString txtHintCompany;
  final dynamic onPressCompany;
  final dynamic onPressGroup;
  final dynamic onPressMainGroup;
  final dynamic onPressSubGroup;

  final String txtBtn1;

  final dynamic onPress1;

  final Color buttonColorBtn1;

  final dynamic btn;

  const DialogAdd_DeleteGroup({
    super.key, required this.txtAlert, this.onPress1, required this.buttonColorBtn1, required this.child, this.onPressGroup, this.onPressMainGroup, this.onPressSubGroup, required this.txtHintGroup, required this.txtHintMainGroup, required this.txtHintSubGroup, required this.textFieldController, required this.hintText, required this.btn, required this.txtBtn1, required this.txtHintCompany, this.onPressCompany,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorManager.white,
      shadowColor: ColorManager.white,
      surfaceTintColor: ColorManager.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.s16),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p24),
        width: MediaQuery
            .of(context)
            .size
            .width / 2.5,
        height: MediaQuery
            .of(context)
            .size
            .height / 1.13,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s16)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(txtAlert, style: getBlackStyle(
                color: ColorManager.black, fontSize: AppSize.s24)),
            const SizedBox(height: AppSize.s32),
            child,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text('نام گروه', style: getBoldStyle(
                        color: ColorManager.black, fontSize: AppSize.s14)),
                  ),
                ),
                const SizedBox(width: AppSize.s16),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text('نام شرکت', style: getBoldStyle(
                        color: ColorManager.black, fontSize: AppSize.s14)),
                  ),
                )
              ],
            ),
            const SizedBox(height: AppSize.s16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: AppSize.s48,
                    child: DefaultTextField(
                      obscureText: false,

                      textFieldColor: ColorManager.gray,
                      textInputType: TextInputType.text,
                      borderSideWidth: AppSize.s2,
                      borderSideColor: ColorManager.gray1,
                      hintStyle: getMediumStyle(
                          color: ColorManager.black,
                          fontSize: AppSize.s14),
                      hintText: hintText,
                      textFieldActive: false,
                      textFieldController: textFieldController,
                      textAlign: TextAlign.right,
                    ),
                  )
                ),
                const SizedBox(width: AppSize.s16),

                Expanded(
                  child: Obx(() {
                    return WidgetButtonSelectVersionNew(
                      appSize: AppSize.s14,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      buttonOnPressed: onPressCompany,
                      txt: txtHintCompany.value,
                      borderSideColor: ColorManager.gray1,
                      borderRadius: AppSize.s8,
                      height: AppSize.s48,
                      colorText: ColorManager.black,
                      icon: Icon(
                          Icons.arrow_drop_down_outlined, color: ColorManager.black),
                      backgroundColor: ColorManager.gray,
                      visible: true,
                      appPadding: AppPadding.p0,
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text('همه گروه های اصلی', style: getMediumStyle(
                        color: ColorManager.black,
                        fontSize: AppSize.s14)),
                  ),
                ),
                const SizedBox(width: AppSize.s16),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text('همه گروه ها', style: getMediumStyle(
                        color: ColorManager.black,
                        fontSize: AppSize.s14)),
                  ),
                )
              ],
            ),
            const SizedBox(height: AppSize.s16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Obx(() {
                    return SelectBtn(
                      appSizeBtn: AppSize.s14,
                      mainAxisAlignmentSelect: MainAxisAlignment.spaceBetween,
                      onPress: onPressGroup,
                      text: txtHintGroup.value,
                      borderColor: ColorManager.gray1,
                      radius: AppSize.s8,
                      heightBtn: AppSize.s48,
                      colorTextSelect: ColorManager.black,
                      iconSelect: Icon(Icons.arrow_drop_down_outlined,
                          color: ColorManager.black),
                      backgroundColorSelect: ColorManager.gray,
                      visibleSelect: true,
                      appPaddingSelect: AppPadding.p0,
                    );
                  }),
                ),
                const SizedBox(width: AppSize.s16),
                Expanded(
                  child: Obx(() {
                    return SelectBtn(
                      appSizeBtn: AppSize.s14,
                      mainAxisAlignmentSelect: MainAxisAlignment.spaceBetween,
                      onPress: onPressMainGroup,
                      text: txtHintMainGroup.value,
                      borderColor: ColorManager.gray1,
                      radius: AppSize.s8,
                      heightBtn: AppSize.s48,
                      colorTextSelect: ColorManager.black,
                      iconSelect: Icon(Icons.arrow_drop_down_outlined,
                          color: ColorManager.black),
                      backgroundColorSelect: ColorManager.gray,
                      visibleSelect: true,
                      appPaddingSelect: AppPadding.p0,

                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s24),
            Align(
              alignment: Alignment.centerRight,
              child: Text('همه زیر گروه ها', style: getBoldStyle(
                  color: ColorManager.black, fontSize: AppSize.s14)),
            ),
            const SizedBox(height: AppSize.s16),
            Obx(() {
              return WidgetButtonSelectVersionNew(
                appSize: AppSize.s14,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                buttonOnPressed: onPressSubGroup,
                txt: txtHintSubGroup.value,
                borderSideColor: ColorManager.gray1,
                borderRadius: AppSize.s8,
                height: AppSize.s48,
                colorText: ColorManager.black,
                icon: Icon(
                    Icons.arrow_drop_down_outlined, color: ColorManager.black),
                backgroundColor: ColorManager.gray,
                visible: true,
                appPadding: AppPadding.p0,

              );
            }),
            const SizedBox(height: AppSize.s24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                btn,
                const SizedBox(width: AppSize.s16),
                Expanded(
                  child: Btn(
                    buttonColorBtn: buttonColorBtn1,
                    onPress: onPress1,
                    text: txtBtn1,
                    heightBtn: AppSize.s48,
                    borderRadiusBtn: AppSize.s8,
                    buttonTextColorBtn: ColorManager.black,
                    borderSideColorBtn: ColorManager.gray1.withOpacity(0),
                  ),
                ),
              ],
            )
          ],

        ),
      ),
    );
  }
}
