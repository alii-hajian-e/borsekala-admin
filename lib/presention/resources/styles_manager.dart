import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(double fontSize, String fontFamily, FontWeight fontWeight , Color color){
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight
  );
}
TextStyle getMediumStyle({double fontSize = FontSize.s14, required Color color}){
  return _getTextStyle(
      fontSize,
      FontConstants.fontFamily,
      FontWeightManager.medium,
      color,
  );
}
TextStyle getBoldStyle({double fontSize = FontSize.s18, required Color color}){
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWeightManager.bold,
    color,
  );
}
TextStyle getBlackStyle({double fontSize = FontSize.s14, required Color color}){
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWeightManager.black,
    color,
  );
}
TextStyle _getTextTebStyle(double fontSize, String fontFamily, FontWeight fontWeight){
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight
  );
}
TextStyle getTabStyle({double fontSize = FontSize.s14}){
  return _getTextTebStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWeightManager.bold,

  );
}