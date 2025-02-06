import 'package:flutter/material.dart';

class ColorManager{
  static Color black = HexColor.fromHex("#201F30");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color gray = HexColor.fromHex("#F6F6F6");
  static Color gray1 = HexColor.fromHex("#E7E7E7");
  static Color red = HexColor.fromHex("#FF4040");
  static Color red2 = HexColor.fromHex("#FF8787");
  static Color yellow = HexColor.fromHex("#FFD600");
  static Color green = HexColor.fromHex("#3DB268");

}

extension HexColor on Color{
  static Color fromHex(String hexColorString){
    hexColorString = hexColorString.replaceAll('#', '');
    if(hexColorString.length == 6){
      hexColorString = "FF$hexColorString";
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}