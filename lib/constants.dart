import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primaryGreen = Color(0xFF23AA49);
  static const Color background = Color(0xFFF6F7F9);
  static const Color primaryText = Color(0xFF1B1B1B);
  static const Color secondaryText = Color(0xFF979899);
  static const Color mutedText = Color(0xFF979899);
  static const Color priceText = Color(0xFF1B1B1B);
  static const Color inactiveTab = Color(0xFF2D2D2D);
  static const Color stroke = Color(0xFFF1F1F5);
  static const Color inputBackground = Color(0xFFF3F5F7);
  static const Color successLight = Color(0xFFF2FBF5); // Matching faint green from prev request
  
  // Legacy/Compatibility Colors
  static const Color headerGreen = Color(0xFF55C973); 
  static const Color cardTeal = Color(0xFF1ABC9C);
  static const Color cardOrange = Color(0xFFFF9800);
  static const Color textDark = primaryText; 
  static const Color textGrey = secondaryText;
  static const Color success = primaryGreen;
  static const Color error = Color(0xFFEF5350);
  static const Color errorLight = Color(0xFFFFEBEE);
}

class AppDefaults {
  static const double radius = 18.0;
  static final BoxShadow defaultShadow = BoxShadow(
    color: Colors.black.withOpacity(0.04),
    blurRadius: 20,
    offset: const Offset(0, 4),
  );
}

class AppTextStyles {
  static TextStyle headlineLarge = GoogleFonts.dmSans(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
  );
  static TextStyle headlineMedium = GoogleFonts.dmSans(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
  );
  static TextStyle titleLarge = GoogleFonts.dmSans(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
  );
  static TextStyle titleMedium = GoogleFonts.dmSans(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
  );
  static TextStyle bodyLarge = GoogleFonts.dmSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
  );
  static TextStyle bodyMedium = GoogleFonts.dmSans(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
  );
  static TextStyle bodySmall = GoogleFonts.dmSans(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.secondaryText,
  );
}
