import 'package:flutter/material.dart';
import 'colors.dart';

TextStyle customTextStyle({
  double? fontSize = 14.0,
  Color? color = whiteColor,
  FontWeight? fontWeight = FontWeight.normal,
}) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  );
}
