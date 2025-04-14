import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF6200EA);
  static const Color secondaryColor = Color(0xFF03DAC6);
  static const Color backgroundColor = Color(0xFF121212);
  static const Color surfaceColor = Color(0xFF1E1E1E);
  static const Color accentColor = Color(0xFFBB86FC);
  
  // Light accent colors for card backgrounds
  static const List<Color> cardColors = [
    Color(0xFFEF5350), // Red
    Color(0xFF42A5F5), // Blue
    Color(0xFF66BB6A), // Green
    Color(0xFFFFEE58), // Yellow
    Color(0xFFAB47BC), // Purple
    Color(0xFF26A69A), // Teal
    Color(0xFFFFCA28), // Amber
    Color(0xFF78909C), // Blue Grey
    Color(0xFFFF7043), // Deep Orange
    Color(0xFF9CCC65), // Light Green
    Color(0xFF5C6BC0), // Indigo
    Color(0xFF8D6E63), // Brown
    Color(0xFF29B6F6), // Light Blue
    Color(0xFFFF8A65), // Light Orange
    Color(0xFF9575CD), // Deep Purple
    Color(0xFF4DD0E1), // Cyan
    Color(0xFFF06292), // Pink
    Color(0xFFAED581), // Lime
  ];

  // Dark theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      background: backgroundColor,
      surface: surfaceColor,
      error: Color(0xFFCF6679),
    ),
    scaffoldBackgroundColor: backgroundColor,
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: surfaceColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: accentColor),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}