// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/value_manager.dart';
import '../base_widget.dart';

class SearchWidget extends BaseInput {
  final BorderSide textFieldBorderSearch;

  SearchWidget({
    super.key,
    required super.textFieldColor,
    required super.textInputType,
    required super.textFieldActive,
     super.textFieldController,
     super.onChanged,
     super.textAlign,
     super.textFieldPadding,
     super.prefixIcon,
     super.textFieldHint,
    required this.textFieldBorderSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: textFieldColor,
        borderRadius: BorderRadius.circular(AppSize.s12),
      ),
      child: TextFormField(
        maxLines: maxLines,
        keyboardType: textInputType,
        readOnly: textFieldActive,
        controller: textFieldController,
        onChanged: onChanged,
        decoration: InputDecoration(
            fillColor: textFieldColor,
            contentPadding: textFieldPadding,
            hintText: '$textFieldHint',
            hintStyle: getMediumStyle(color: ColorManager.black.withOpacity(0.4),fontSize: AppSize.s14),
            enabledBorder: OutlineInputBorder(
              borderSide: textFieldBorderSearch,
              borderRadius: BorderRadius.circular(AppSize.s12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: AppSize.s0,color: ColorManager.white),
              borderRadius: BorderRadius.circular(AppSize.s12),
            ),
            prefixIcon: prefixIcon
        ),
        style: getMediumStyle(color: ColorManager.black,fontSize: AppSize.s18),
      ),
    );
  }
}
