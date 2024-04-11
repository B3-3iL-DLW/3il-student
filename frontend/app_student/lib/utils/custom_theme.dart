import 'package:flutter/material.dart';

class CustomTheme {
  static const Color primaryColor = Color(0xFF005067);
  static const Color secondaryColor = Color(0xffE84E0F);

  static const Color primaryColorLight = Color(0xFF007A8D);

  static const TextStyle title = TextStyle(fontSize: 32);
  static const TextStyle subtitle = TextStyle(fontSize: 22);

  static const TextStyle textXl = TextStyle(fontSize: 18);
  static const TextStyle text = TextStyle(fontSize: 16);
  static const TextStyle textSmall = TextStyle(fontSize: 14);
  static const TextStyle textXs = TextStyle(fontSize: 12);
}

extension TextStyleHelpers on TextStyle {
  TextStyle get toBold => copyWith(fontWeight: FontWeight.bold);

  TextStyle get toItalic => copyWith(fontStyle: FontStyle.italic);

  TextStyle get toUnderline => copyWith(decoration: TextDecoration.underline);

  TextStyle get toColorPrimary => copyWith(color: CustomTheme.primaryColor);

  TextStyle get toColorSecondary => copyWith(color: CustomTheme.secondaryColor);

  TextStyle get toColorWhite => copyWith(color: Colors.white);

  TextStyle get toColorBlack => copyWith(color: Colors.black);
}
