import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText {
  AppText._();

  static TextTheme textTheme = TextTheme(
    // Big balance number
    headlineLarge: GoogleFonts.inter(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      letterSpacing: -0.5,
    ),

    // Section titles (e.g. "Transactions")
    titleLarge: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600),

    // Card title (e.g. "Coffee")
    titleMedium: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),

    // Normal text
    bodyLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.normal),

    // Small text (date, hint)
    bodySmall: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
  );
}
