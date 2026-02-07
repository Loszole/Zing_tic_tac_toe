import 'package:flutter/material.dart';

class AppColors {
  // Common Colors (Used in both modes)
  static const Color orangeLogo = Color(0xFFF9A84D); // Matches the logo's "Street Food" text
  static const Color orangeShadow = Color(0xFFD47C20); // Darker shade for buttons/depth

  // --- Light Mode ---
  static const Color primaryBackground = Color(0xFFFDFDFD); // Clean, slightly warm white
  static const Color text = Color(0xFF1A1A1B); // Deep "soft black" for better readability
  static const Color primaryAccent = orangeLogo; 
  static const Color secondaryAccent = Color(0xFFE63946); // Energetic Red (standard for food apps)
  static const Color divider = Color(0xFFF1F1F1);

  // --- Dark Mode ---
  static const Color darkPrimaryBackground = Color(0xFF121212); // True "OLED" style dark
  static const Color darkSurface = Color(0xFF1E1E1E); // Elevated surface color
  static const Color darkText = Color(0xFFFFFFFF); // Pure white for high contrast
  static const Color darkPrimaryAccent = orangeLogo; 
  static const Color darkSecondaryAccent = Color(0xFFFF4D5A); // Brightened red for dark mode
  static const Color darkDivider = Color(0xFF2C2C2C); 
  static const Color darkInactiveIcon = Color(0xFF757575); 
}