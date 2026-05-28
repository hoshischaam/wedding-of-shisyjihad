import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppStyles {
  // Script font for names
  static TextStyle get scriptStyle => GoogleFonts.greatVibes(
        color: AppColors.accent,
        fontSize: 48,
      );

  // Montserrat for headings
  static TextStyle get headingStyle => GoogleFonts.montserrat(
        color: AppColors.primaryText,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      );

  // Montserrat for standard text
  static TextStyle get bodyStyle => GoogleFonts.montserrat(
        color: AppColors.primaryText,
        fontSize: 14,
        height: 1.6,
      );

  // Amiri for Arabic text
  static TextStyle get arabicStyle => GoogleFonts.amiri(
        color: AppColors.primaryText,
        fontSize: 22,
        height: 1.8,
      );
}
