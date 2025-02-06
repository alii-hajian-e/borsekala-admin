import 'package:flutter/material.dart';
import '../../resources/color_manager.dart';
import '../../resources/value_manager.dart';

class DropDown extends StatelessWidget {
  final String selectedDepartment;
  final List<DropdownMenuItem<String>> items;
  final void Function(String?)? onChanged;

  const DropDown({super.key, required this.selectedDepartment, required this.items, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedDepartment,
      decoration: InputDecoration(
        fillColor: ColorManager.white,
        focusColor: ColorManager.white,
        hoverColor: ColorManager.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: AppSize.s2,color: ColorManager.black.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: AppSize.s2,color: ColorManager.black.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: AppSize.s2,color: ColorManager.black.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: AppSize.s2,color: ColorManager.black.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
      items: items,
      onChanged: onChanged,
    );
  }
}