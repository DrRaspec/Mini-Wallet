import 'package:flutter/material.dart';
import 'package:mini_wallet/core/constants/app_fonts.dart';

class AppText {
  AppText._();

  static TextTheme getTextTheme(Locale locale) {
    final isKhmer = locale.languageCode == 'km';
    final base = ThemeData.light().textTheme;

    // Khmer (Noto Sans Khmer)
    if (isKhmer) {
      return base
          .apply(fontFamily: AppFonts.notoSansKhmer)
          .copyWith(
            // Keep spacing readable for Khmer
            bodyLarge: const TextStyle(height: 1.6),
            bodyMedium: const TextStyle(height: 1.6),
            bodySmall: const TextStyle(height: 1.6),

            // Optional: headings tweak for Khmer readability
            displaySmall: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
            headlineLarge: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          );
    }

    // English (Inter + Manrope mix)
    return base.copyWith(
      // Headings → Manrope
      displaySmall: const TextStyle(
        fontFamily: AppFonts.manrope,
        fontSize: 34,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
      ),
      headlineLarge: const TextStyle(
        fontFamily: AppFonts.manrope,
        fontSize: 30,
        fontWeight: FontWeight.w800,
      ),
      headlineSmall: const TextStyle(
        fontFamily: AppFonts.manrope,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: const TextStyle(
        fontFamily: AppFonts.manrope,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: const TextStyle(
        fontFamily: AppFonts.manrope,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: const TextStyle(
        fontFamily: AppFonts.manrope,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),

      // Body → Inter
      bodyLarge: const TextStyle(
        fontFamily: AppFonts.inter,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        height: 1.45,
      ),
      bodyMedium: const TextStyle(
        fontFamily: AppFonts.inter,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.45,
      ),
      bodySmall: const TextStyle(
        fontFamily: AppFonts.inter,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.4,
      ),

      // Labels
      labelLarge: const TextStyle(
        fontFamily: AppFonts.inter,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: const TextStyle(
        fontFamily: AppFonts.manrope,
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
      ),
    );
  }
}
