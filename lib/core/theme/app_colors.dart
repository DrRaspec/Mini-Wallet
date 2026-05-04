import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Core palette ──────────────────────────────────────────────────────
  static const primary = Color(0xFF1A1A2E);
  static const secondary = Color(0xFFE8956A);
  static const accent = Color(0xFFF2C4A0);

  // ── Surfaces ──────────────────────────────────────────────────────────
  static const background = Color(0xFFFDF5EF);
  static const card = Colors.white;
  static const surfaceMuted = Color(0xFFF8EDE3);
  static const border = Color(0xFFF0E6DA);

  // ── Text ──────────────────────────────────────────────────────────────
  static const textPrimary = Color(0xFF1A1A2E);
  static const textSecondary = Color(0xFF9A8F85);

  // ── Semantic ──────────────────────────────────────────────────────────
  static const income = Color(0xFF2F7D5A);
  static const expense = Color(0xFFE8956A);

  // ── Dark theme ────────────────────────────────────────────────────────
  static const darkPrimary = Color(0xFFFDF5EF);
  static const darkSecondary = Color(0xFFE8956A);
  static const darkAccent = Color(0xFFF2C4A0);

  static const darkBackground = Color(0xFF11111F);
  static const darkCard = Color(0xFF1A1A2E);
  static const darkSurfaceMuted = Color(0xFF252538);
  static const darkBorder = Color(0xFF34344A);

  static const darkTextPrimary = Color(0xFFF8EDE3);
  static const darkTextSecondary = Color(0xFFB8ADA4);

  static const darkIncome = Color(0xFF5CC08E);
  static const darkExpense = Color(0xFFFFA77B);
}

extension AppThemeColors on BuildContext {
  bool get _isDark => Theme.of(this).brightness == Brightness.dark;

  Color get appPrimary => _isDark ? AppColors.darkPrimary : AppColors.primary;
  Color get appSecondary =>
      _isDark ? AppColors.darkSecondary : AppColors.secondary;
  Color get appBackground =>
      _isDark ? AppColors.darkBackground : AppColors.background;
  Color get appCard => _isDark ? AppColors.darkCard : AppColors.card;
  Color get appSurfaceMuted =>
      _isDark ? AppColors.darkSurfaceMuted : AppColors.surfaceMuted;
  Color get appBorder => _isDark ? AppColors.darkBorder : AppColors.border;
  Color get appTextPrimary =>
      _isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;
  Color get appTextSecondary =>
      _isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;
  Color get appIncome => _isDark ? AppColors.darkIncome : AppColors.income;
  Color get appExpense => _isDark ? AppColors.darkExpense : AppColors.expense;
}
