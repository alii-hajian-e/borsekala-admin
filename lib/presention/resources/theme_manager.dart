import 'package:bors_web_admin_sms/presention/resources/styles_manager.dart';
import 'package:bors_web_admin_sms/presention/resources/value_manager.dart';
import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';

ThemeData getApplicationTheme(){
  return ThemeData(
    //main color of app
    primaryColor: ColorManager.black,
    disabledColor: ColorManager.gray,
    primaryColorLight: ColorManager.white,
    splashColor: ColorManager.white,

    //app bar theme color
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.white,
      elevation: AppSize.s0,
      titleTextStyle: getBlackStyle(color: ColorManager.white,fontSize: FontSize.s18),
    ),

    //button theme
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s8)),
      disabledColor: ColorManager.gray,
      buttonColor: ColorManager.yellow,
      splashColor: ColorManager.gray,
    ),

    //elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getBoldStyle(color: ColorManager.white),
        backgroundColor: ColorManager.yellow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s8)),
      )
    ),

    //text theme color
    textTheme: TextTheme(
      titleLarge: getBlackStyle(color: ColorManager.white),
      titleSmall: getBoldStyle(color: ColorManager.black),
      labelLarge: getMediumStyle(color: ColorManager.gray),
    ),

    //input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getMediumStyle(color: ColorManager.gray),
      labelStyle: getBoldStyle(color: ColorManager.black),
      errorStyle: getMediumStyle(color: ColorManager.red),
      filled: true,
      // fillColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
      //   if (states.contains(WidgetState.focused)) {
      //     return ColorManager.white;
      //   }
      //   if (states.contains(WidgetState.error)) {
      //     return ColorManager.red;
      //   }
      //   return ColorManager.white;
      // }),

      border: OutlineInputBorder(
        //Outline border type for TextFeild
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
          borderSide: BorderSide(
            color: ColorManager.black,
            width: AppSize.s1,
          ),
      ),
      disabledBorder: OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        borderSide: BorderSide(
          color: ColorManager.black,
          width: AppSize.s1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        borderSide: BorderSide(
          color: ColorManager.black,
          width: AppSize.s1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        borderSide: BorderSide(
          color: ColorManager.black,
          width: AppSize.s1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        borderSide: BorderSide(
          color: ColorManager.black,
          width: AppSize.s1,
        ),
      ),
    )
  );
}