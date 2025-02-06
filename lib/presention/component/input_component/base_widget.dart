// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/value_manager.dart';

class BaseInput extends StatelessWidget {

  final textFieldHint;
  final Color textFieldColor;
  final textFieldController;
  bool textFieldActive = true;
  final textFieldMargin;
  final textFieldPadding;
  final textFieldBorder;
  var textInputType = TextInputType.number;
  final textAlign;
  final maxLines;
  final suffixIcon;
  final prefixIcon;
  final onChanged;
  final inputFormatters;

  BaseInput({super.key,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines,
    this.textAlign,
    this.textFieldBorder,
    this.textFieldPadding,
    this.textFieldMargin,
    this.textFieldHint,
    required this.textFieldColor,
    this.textFieldController,
    required this.textInputType,
    required this.textFieldActive,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: textFieldColor,
        borderRadius: BorderRadius.circular(AppSize.s12),
        border: textFieldBorder,
      ),
      margin: textFieldMargin,
      child: TextFormField(
        inputFormatters: inputFormatters,
        maxLines: maxLines,
        keyboardType: textInputType,
        readOnly: textFieldActive,
        controller: textFieldController,
        textAlign: textAlign,
        onChanged: onChanged,
        decoration: InputDecoration(
            fillColor: textFieldColor,
            contentPadding: textFieldPadding,
            hintText: '$textFieldHint',
            hintStyle: getMediumStyle(color: ColorManager.gray1,fontSize: AppSize.s18),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: AppSize.s0,color: ColorManager.white),
              borderRadius: BorderRadius.circular(AppSize.s12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: AppSize.s0,color: ColorManager.white),
              borderRadius: BorderRadius.circular(AppSize.s12),
            ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon
        ),
        style: getMediumStyle(color: ColorManager.black,fontSize: AppSize.s18),
      ),
    );
  }
}

