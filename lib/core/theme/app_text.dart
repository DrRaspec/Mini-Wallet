import 'package:flutter/material.dart';

class AppText {
  AppText._();

  static const String bodyFontFamily = 'Inter';
  static const String displayFontFamily = 'Manrope';

  static const TextTheme textTheme = TextTheme(
    displaySmall: TextStyle(
      fontFamily: displayFontFamily,
      fontSize: 34,
      fontWeight: FontWeight.w900,
      letterSpacing: -0.5,
    ),
    headlineLarge: TextStyle(
      fontFamily: displayFontFamily,
      fontSize: 30,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.6,
    ),
    headlineSmall: TextStyle(
      fontFamily: displayFontFamily,
      fontSize: 24,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.4,
    ),
    titleLarge: TextStyle(
      fontFamily: displayFontFamily,
      fontSize: 20,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.2,
    ),
    titleMedium: TextStyle(
      fontFamily: displayFontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    ),
    titleSmall: TextStyle(
      fontFamily: displayFontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w800,
      letterSpacing: 1.2,
    ),
    bodyLarge: TextStyle(
      fontFamily: bodyFontFamily,
      fontSize: 15,
      fontWeight: FontWeight.w500,
      height: 1.45,
    ),
    bodyMedium: TextStyle(
      fontFamily: bodyFontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.45,
    ),
    bodySmall: TextStyle(
      fontFamily: bodyFontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Colors.grey,
      height: 1.4,
    ),
    labelLarge: TextStyle(
      fontFamily: bodyFontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
    labelMedium: TextStyle(
      fontFamily: displayFontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w800,
      letterSpacing: 1.4,
    ),
  );
}
