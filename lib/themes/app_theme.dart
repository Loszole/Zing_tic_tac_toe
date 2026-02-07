import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
// Constants for a consistent "Street Food" look
const double _kBorderRadius = 16.0;
const double _kButtonRadius = 12.0;

///  Light ThemeData
final ThemeData LightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.primaryBackground,
  primaryColor: AppColors.primaryAccent,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primaryAccent,
    secondary: AppColors.secondaryAccent,
    surface: AppColors.primaryBackground,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: AppColors.text,
  ),
  dividerColor: AppColors.divider,
  
  // Clean AppBar with no shadow
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primaryBackground,
    surfaceTintColor: Colors.transparent, // Prevents M3 purple tint
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColors.text, size: 22),
    titleTextStyle: TextStyle(
      color: AppColors.text,
      fontWeight: FontWeight.w800, // Bold like the logo
      fontSize: 20,
      fontFamily: 'Poppins',
    ),
  ),

  // Modern Button Themes
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryAccent,
      foregroundColor: Colors.white,
      minimumSize: const Size.fromHeight(52),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_kButtonRadius)),
      elevation: 2,
      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Poppins'),
    ),
  ),

  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w800, color: AppColors.text, fontSize: 30, letterSpacing: -0.5),
    headlineMedium: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, color: AppColors.text, fontSize: 22),
    bodyLarge: TextStyle(fontFamily: 'Poppins', color: AppColors.text, fontSize: 16),
    bodyMedium: TextStyle(fontFamily: 'Poppins', color: Colors.black54, fontSize: 14), // Muted subtext for hierarchy
    labelLarge: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, color: AppColors.primaryAccent, fontSize: 16),
  ),

  // Cards with soft shadows for "Food Item" look
  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 6,
    shadowColor: Colors.black12,
    surfaceTintColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_kBorderRadius)),
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
  ),

  // Modern "Filled" Input fields (Better for Mobile)
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.divider.withValues(alpha: 0.4),
    border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(_kButtonRadius)),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.primaryAccent, width: 2),
      borderRadius: BorderRadius.circular(_kButtonRadius),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    labelStyle: const TextStyle(color: Colors.black45),
  ),

  bottomNavigationBarTheme:const  BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: AppColors.primaryAccent,
    unselectedItemColor: Colors.black54,
    selectedIconTheme: IconThemeData(color: AppColors.primaryAccent),
    unselectedIconTheme: IconThemeData(color: Colors.black54),
    type: BottomNavigationBarType.fixed,
    elevation: 20,
  ),
);

/// Dark ThemeData
final ThemeData DarkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.darkPrimaryBackground,
  primaryColor: AppColors.darkPrimaryAccent,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.darkPrimaryAccent,
    secondary: AppColors.darkSecondaryAccent,
    surface: AppColors.darkSurface,
    onPrimary: Colors.black,
    onSecondary: Colors.white,
    onSurface: AppColors.darkText,
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.darkPrimaryBackground,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: AppColors.darkText,
      fontWeight: FontWeight.w800,
      fontSize: 20,
      fontFamily: 'Poppins',
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.darkPrimaryAccent,
      foregroundColor: Colors.black, // Dark text on orange button
      minimumSize: const Size.fromHeight(52),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_kButtonRadius)),
      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Poppins'),
    ),
  ),

  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w800, color: AppColors.darkText, fontSize: 30, letterSpacing: -0.5),
    bodyLarge: TextStyle(fontFamily: 'Poppins', color: AppColors.darkText, fontSize: 16),
    bodyMedium: TextStyle(fontFamily: 'Poppins', color: Colors.white70, fontSize: 14),
  ),

  cardTheme: CardThemeData(
    color: AppColors.darkSurface,
    elevation: 0, 
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(_kBorderRadius),
      side: const BorderSide(color: AppColors.darkDivider, width: 1.5), // Subtle border for dark mode depth
    ),
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkSurface,
    border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(_kButtonRadius)),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.darkPrimaryAccent, width: 2),
      borderRadius: BorderRadius.circular(_kButtonRadius),
    ),
  ),

  bottomNavigationBarTheme: const  BottomNavigationBarThemeData(
    backgroundColor: AppColors.darkSurface,
    selectedItemColor: AppColors.darkPrimaryAccent,
    unselectedItemColor: AppColors.darkInactiveIcon,
    selectedLabelStyle: TextStyle(color: AppColors.darkPrimaryAccent),
    selectedIconTheme: IconThemeData(color: AppColors.darkPrimaryAccent),
    unselectedIconTheme: IconThemeData(color: AppColors.darkInactiveIcon),
    unselectedLabelStyle: TextStyle(color: AppColors.darkInactiveIcon),
    type: BottomNavigationBarType.fixed,
    elevation: 0,
  ),
);
