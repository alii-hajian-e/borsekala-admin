// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/value_manager.dart';
import '../base_widget.dart';

class DefaultTextField extends BaseInput {

  final double borderSideWidth;
  final Color borderSideColor;
  final hintStyle;
  final String hintText;
  final dynamic obscureText;


  DefaultTextField({
    super.key,
    super.onChanged,
    super.textAlign,
    super.textFieldPadding,
    required super.textFieldColor,
    super.textFieldController,
    required super.textInputType,
    required this.borderSideWidth,
    required this.borderSideColor,
    required this.hintStyle,
    required this.hintText,
    required this.obscureText,
    required super.textFieldActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s12),
      ),
      child: TextFormField(
        obscureText: obscureText,
        obscuringCharacter: '*',
        controller: textFieldController,
        textAlign: textAlign,
        onChanged: onChanged,
        keyboardType: textInputType,
        readOnly: textFieldActive,
        decoration: InputDecoration(
            fillColor: textFieldColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            hintText: hintText,
            hintStyle: hintStyle,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: borderSideWidth,color: borderSideColor),
              borderRadius: BorderRadius.circular(AppSize.s12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: borderSideWidth,color: borderSideColor),
              borderRadius: BorderRadius.circular(AppSize.s12),
            ),
        ),
        style: getMediumStyle(color: ColorManager.black,fontSize: AppSize.s18),
      ),
    );
  }
}
