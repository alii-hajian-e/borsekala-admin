// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types

import 'package:bors_web_admin_sms/presention/component/button_component/btn/_btn.dart';
import 'package:bors_web_admin_sms/presention/resources/styles_manager.dart';
import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/value_manager.dart';
import '../../input_component/defult/defulttextfield.dart';


class DialogAdd_UpdateAdmin extends StatelessWidget {

  final String txtAlert;
  final String txtName;
  final String txtFamily;
  final String txtPhoneEmail;
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

  final dynamic child;
  const DialogAdd_UpdateAdmin({
    super.key,required this.textFieldControllerName, required this.textFieldControllerFamily,required this.textFieldControllerPhone, required this.txtAlert, required this.txtBtn, required this.txtBtn1, this.onPress, this.onPress1, required this.buttonColorBtn, required this.buttonColorBtn1, required this.hintTextName, required this.hintTextFamily, required this.hintTextPhone, this.child, required this.txtName, required this.txtFamily, required this.txtPhoneEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: IntrinsicWidth(
        child: IntrinsicHeight(
          child: Container(
            padding: const EdgeInsets.all(AppPadding.p24),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: const BorderRadius.all(Radius.circular(AppSize.s16)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  txtAlert,
                  style: getBlackStyle(color: ColorManager.black, fontSize: AppSize.s24),
                ),
                const SizedBox(height: AppSize.s32),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              txtName,
                              style: getBoldStyle(color: ColorManager.black, fontSize: AppSize.s14),
                            ),
                          ),
                          const SizedBox(height: AppSize.s16),
                          SizedBox(
                            height: AppSize.s48,
                            child: DefaultTextField(
                              maxLinesTextFormField: 1,
                              obscureText: false,
                              textFieldColor: ColorManager.white,
                              textInputType: TextInputType.text,
                              borderSideWidth: AppSize.s2,
                              borderSideColor: ColorManager.gray1,
                              hintStyle: getMediumStyle(
                                color: ColorManager.black,
                                fontSize: AppSize.s14,
                              ),
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
                            child: Text(
                              txtFamily,
                              style: getBoldStyle(color: ColorManager.black, fontSize: AppSize.s14),
                            ),
                          ),
                          const SizedBox(height: AppSize.s16),
                          SizedBox(
                            height: AppSize.s48,
                            child: DefaultTextField(
                              maxLinesTextFormField: 1,
                              obscureText: false,
                              textFieldColor: ColorManager.white,
                              textInputType: TextInputType.text,
                              borderSideWidth: AppSize.s2,
                              borderSideColor: ColorManager.gray1,
                              hintStyle: getMediumStyle(
                                color: ColorManager.black,
                                fontSize: AppSize.s14,
                              ),
                              hintText: hintTextFamily,
                              textFieldActive: false,
                              textFieldController: textFieldControllerFamily,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSize.s16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    txtPhoneEmail,
                    style: getBoldStyle(color: ColorManager.black, fontSize: AppSize.s14),
                  ),
                ),
                const SizedBox(height: AppSize.s16),
                SizedBox(
                  height: AppSize.s48,
                  child: DefaultTextField(
                    maxLinesTextFormField: 1,
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
                child,
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
                        borderSideColorBtn: ColorManager.gray1.withValues(alpha: 0),
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
                        borderSideColorBtn: ColorManager.gray1.withValues(alpha: 0),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
