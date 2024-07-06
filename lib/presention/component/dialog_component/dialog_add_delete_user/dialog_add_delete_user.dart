// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types

import 'package:bors_web_admin_sms/presention/component/button_component/btn/_btn.dart';
import 'package:bors_web_admin_sms/presention/resources/styles_manager.dart';
import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/value_manager.dart';
import '../../input_component/defult/defulttextfield.dart';


class DialogAdd_DeleteUser extends StatelessWidget {

  final String txtAlert;
  final TextEditingController textFieldControllerName;
  final TextEditingController textFieldControllerFamily;
  final TextEditingController textFieldControllerPhone;

  final String txtBtn;
  final String txtBtn1;
  final String hintTextName;
  final String hintTextFamily;
  final String hintTextPhone;
  final dynamic onPress;
  final dynamic onPress1;

  final Color buttonColorBtn;
  final Color buttonColorBtn1;

  const DialogAdd_DeleteUser({
    super.key,required this.textFieldControllerName, required this.textFieldControllerFamily,required this.textFieldControllerPhone, required this.txtAlert, required this.txtBtn, required this.txtBtn1, this.onPress, this.onPress1, required this.buttonColorBtn, required this.buttonColorBtn1, required this.hintTextName, required this.hintTextFamily, required this.hintTextPhone,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // backgroundColor: ColorManager.white,
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.all(
      //     Radius.circular(AppSize.s16),
      //   ),
      // ),
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p24),
        width: MediaQuery.of(context).size.width / 3,
        height: AppSize.s380,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s16)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(txtAlert,style: getBlackStyle(color: ColorManager.black,fontSize: AppSize.s24)),
            const SizedBox(height: AppSize.s32),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text('نام', style: getBoldStyle(
                              color: ColorManager.black, fontSize: AppSize.s14)),
                        ),
                        const SizedBox(height: AppSize.s16),
                        SizedBox(
                          height: AppSize.s48,
                          child: DefaultTextField(
                            obscureText: false,

                            textFieldColor: ColorManager.white,
                            textInputType: TextInputType.text,
                            borderSideWidth: AppSize.s2,
                            borderSideColor: ColorManager.gray1,
                            hintStyle: getMediumStyle(
                                color: ColorManager.black, fontSize: AppSize.s14),
                            hintText: hintTextName,
                            textFieldActive: false,
                            textFieldController: textFieldControllerName,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSize.s16),
                  Expanded(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text('نام خانوادگی', style: getBoldStyle(
                              color: ColorManager.black, fontSize: AppSize.s14)),
                        ),
                        const SizedBox(height: AppSize.s16),
                        SizedBox(
                          height: AppSize.s48,
                          child: DefaultTextField(
                            obscureText: false,

                            textFieldColor: ColorManager.white,
                            textInputType: TextInputType.number,
                            borderSideWidth: AppSize.s2,
                            borderSideColor: ColorManager.gray1,
                            hintStyle: getMediumStyle(color: ColorManager.black, fontSize: AppSize.s14),
                            hintText: hintTextFamily,
                            textFieldActive: false,
                            textFieldController: textFieldControllerFamily,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    )
                  )
                ],
              ),
            ),
            const SizedBox(width: AppSize.s16),
            Align(
              alignment: Alignment.centerRight,
              child: Text('شماره همراه', style: getBoldStyle(
                  color: ColorManager.black, fontSize: AppSize.s14)),
            ),
            const SizedBox(height: AppSize.s16),
            SizedBox(
              height: AppSize.s48,
              child: DefaultTextField(
                obscureText: false,

                textFieldColor: ColorManager.white,
                textInputType: TextInputType.text,
                borderSideWidth: AppSize.s2,
                borderSideColor: ColorManager.gray1,
                hintStyle: getMediumStyle(color: ColorManager.black, fontSize: AppSize.s14),
                hintText: hintTextPhone,
                textFieldActive: false,
                textFieldController: textFieldControllerPhone,
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: AppSize.s24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Btn(
                    buttonColorBtn: buttonColorBtn,
                    onPress: onPress,
                    text: txtBtn,
                    heightBtn: AppSize.s48,
                    borderRadiusBtn: AppSize.s8,
                    buttonTextColorBtn: ColorManager.black,
                    borderSideColorBtn: ColorManager.gray1.withOpacity(0),
                  ),
                ),
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
