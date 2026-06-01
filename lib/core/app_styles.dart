import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppStyles {
  // Darwin Smith custom font for names on inner pages
  static TextStyle get scriptStyle => const TextStyle(
        fontFamily: 'DarwinSmith',
        color: AppColors.accent,
        fontSize: 48,
        fontWeight: FontWeight.w400,
      );

  // Darwin Smith custom font for cover page names
  static TextStyle get coverNameStyle => const TextStyle(
        fontFamily: 'DarwinSmith',
        color: AppColors.accent,
        fontSize: 64,
        fontWeight: FontWeight.w400,
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
