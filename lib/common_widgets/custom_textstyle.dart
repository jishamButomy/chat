import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const TextStyle cardTextStyle = TextStyle(
  color: Color(0XFF2C2C2C),
  fontSize: 14,
  fontWeight: FontWeight.w500,
);

class CustomFontStyle {
  TextStyle common(
      {FontWeight? fontWeight,
      String? fontFamily, 
      double? fontSize,
      TextDecoration? decoration,
      Color? color,
      double? height = 0,
      TextOverflow? overflow}) {
    return TextStyle(
        height: height,
        fontFamily: fontFamily ?? "Manrope",
        fontWeight: fontWeight,
        fontSize: fontSize,
        decoration: decoration,
        overflow: overflow,
        decorationColor: Colors.blue,
        color: color);
  }
}
