// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/value_manager.dart';
import '../../button_component/btn/_btn.dart';
import '../../button_component/circle-btn/circle_btn.dart';
import '../../input_component/defult/defulttextfield.dart';


class WidgetDialogAddTicket extends StatelessWidget {

  final GlobalKey keyDropDown;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final dynamic dropDown;
  final VoidCallback onPressSaveTicket;

  const WidgetDialogAddTicket({super.key, required this.keyDropDown, required this.titleController, required this.descriptionController, required this.onPressSaveTicket, required this.dropDown});

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
        width: MediaQuery.of(context).size.width / 2.5,
        padding: const EdgeInsets.all(AppSize.s16),
        child: Form(
          key: keyDropDown,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'ایجاد تیکت جدید',
                    style: getBoldStyle(color: ColorManager.black,fontSize: AppSize.s16),
                  ),
                  CircleButton(
                    appSize: AppSize.s8,
                    widthCircle: AppSize.s32,
                    heightCircle: AppSize.s32,
                    buttonColorCircle: ColorManager.white.withOpacity(0),
                    onPress: ()=> Navigator.of(context).pop(),
                    icons: const Icon(Icons.clear,size: AppSize.s18),
                    colors: ColorManager.white,
                    bordersSide: AppSize.s2,
                    borderSideColors: ColorManager.white,
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s16),
              Align(
                alignment: Alignment.centerRight,
                child: Text('موضوع', style: getBoldStyle(
                    color: ColorManager.black, fontSize: AppSize.s14)),
              ),
              const SizedBox(height: AppSize.s8),
              DefaultTextField(
                maxLinesTextFormField: 1,
                obscureText: false,
                textFieldColor: ColorManager.white,
                textInputType: TextInputType.text,
                borderSideWidth: AppSize.s2,
                borderSideColor: ColorManager.black.withOpacity(0.3),
                hintStyle: getMediumStyle(
                    color: ColorManager.black.withOpacity(0.5), fontSize: AppSize.s14),
                hintText: 'موضوع',
                textFieldActive: false,
                textFieldController: titleController,
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: AppSize.s16),

              Align(
                alignment: Alignment.centerRight,
                child: Text('توضیحات', style: getBoldStyle(
                    color: ColorManager.black, fontSize: AppSize.s14)),
              ),
              const SizedBox(height: AppSize.s8),
              DefaultTextField(
                maxLinesTextFormField: 4,
                obscureText: false,
                textFieldColor: ColorManager.white,
                textInputType: TextInputType.text,
                borderSideWidth: AppSize.s2,
                borderSideColor: ColorManager.black.withOpacity(0.3),
                hintStyle: getMediumStyle(
                    color: ColorManager.black.withOpacity(0.5), fontSize: AppSize.s14),
                hintText: 'توضیحات',
                textFieldActive: false,
                textFieldController: descriptionController,
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: AppSize.s16),

              Align(
                alignment: Alignment.centerRight,
                child: Text('لطفا بخش را انتخاب کنید', style: getBoldStyle(
                    color: ColorManager.black, fontSize: AppSize.s14)),
              ),
              const SizedBox(height: AppSize.s8),
              dropDown,
              const SizedBox(height: AppSize.s24),
              Btn(
                  buttonColorBtn: ColorManager.yellow,
                  onPress: onPressSaveTicket,
                  text: 'ثبت تیکت',
                  heightBtn: AppSize.s48,
                  borderRadiusBtn: AppSize.s12,
                  buttonTextColorBtn: ColorManager.black,
                  borderSideColorBtn: ColorManager.yellow
              ),
            ],
          ),
        ),
      ),
    );
  }
}
