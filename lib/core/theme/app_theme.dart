import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App theme configuration
class AppTheme {
  // Colors
  static const Color _primaryLight = Color(0xFF0066FF);
  static const Color _primaryDark = Color(0xFF4D9FFF);
  static const Color _secondaryLight = Color(0xFF00C0A3);
  static const Color _secondaryDark = Color(0xFF66FFE0);
  static const Color _backgroundLight = Color(0xFFF8F9FA);
  static const Color _backgroundDark = Color(0xFF121212);
  static const Color _surfaceLight = Color(0xFFFFFFFF);
  static const Color _surfaceDark = Color(0xFF1E1E1E);
  static const Color _errorLight = Color(0xFFB00020);
  static const Color _errorDark = Color(0xFFCF6679);

  // Text colors
  static const Color _textPrimaryLight = Color(0xFF212121);
  static const Color _textSecondaryLight = Color(0xFF757575);
  static const Color _textPrimaryDark = Color(0xFFE0E0E0);
  static const Color _textSecondaryDark = Color(0xFF9E9E9E);

  // Accent colors for skills and tags
  static const List<Color> _accentColors = [
    Color(0xFF4D9FFF), // Blue
    Color(0xFF66FFE0), // Turquoise 
    Color(0xFFFFD166), // Yellow
    Color(0xFFFF6B6B), // Red
    Color(0xFFC77DFF), // Purple
  ];

  /// Get accent color based on index
  static Color getAccentColor(int index) {
    return _accentColors[index % _accentColors.length];
  }

  static final ColorScheme _lightColorScheme = ColorScheme(
    primary: _primaryLight,
    secondary: _secondaryLight,
    surface: _surfaceLight,
    background: _backgroundLight,
    error: _errorLight,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: _textPrimaryLight,
    onBackground: _textPrimaryLight,
    onError: Colors.white,
    brightness: Brightness.light,
  );

  static final ColorScheme _darkColorScheme = ColorScheme(
    primary: _primaryDark,
    secondary: _secondaryDark,
    surface: _surfaceDark,
    background: _backgroundDark,
    error: _errorDark,
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: _textPrimaryDark,
    onBackground: _textPrimaryDark,
    onError: Colors.black,
    brightness: Brightness.dark,
  );

  // Text Themes
  static final TextTheme _lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.inter(
      fontSize: 96,
      fontWeight: FontWeight.w300,
      color: _textPrimaryLight,
    ),
    displayMedium: GoogleFonts.inter(
      fontSize: 60,
      fontWeight: FontWeight.w300,
      color: _textPrimaryLight,
    ),
    displaySmall: GoogleFonts.inter(
      fontSize: 48,
      fontWeight: FontWeight.w400,
      color: _textPrimaryLight,
    ),
    headlineMedium: GoogleFonts.inter(
      fontSize: 34,
      fontWeight: FontWeight.w600,
      color: _textPrimaryLight,
    ),
    headlineSmall: GoogleFonts.inter(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: _textPrimaryLight,
    ),
    titleLarge: GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: _textPrimaryLight,
    ),
    titleMedium: GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: _textPrimaryLight,
    ),
    titleSmall: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: _textPrimaryLight,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: _textPrimaryLight,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: _textPrimaryLight,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: _textSecondaryLight,
    ),
    labelLarge: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: _textPrimaryLight,
    ),
  );

  static final TextTheme _darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.inter(
      fontSize: 96,
      fontWeight: FontWeight.w300,
      color: _textPrimaryDark,
    ),
    displayMedium: GoogleFonts.inter(
      fontSize: 60,
      fontWeight: FontWeight.w300,
      color: _textPrimaryDark,
    ),
    displaySmall: GoogleFonts.inter(
      fontSize: 48,
      fontWeight: FontWeight.w400,
      color: _textPrimaryDark,
    ),
    headlineMedium: GoogleFonts.inter(
      fontSize: 34,
      fontWeight: FontWeight.w600,
      color: _textPrimaryDark,
    ),
    headlineSmall: GoogleFonts.inter(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: _textPrimaryDark,
    ),
    titleLarge: GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: _textPrimaryDark,
    ),
    titleMedium: GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: _textPrimaryDark,
    ),
    titleSmall: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: _textPrimaryDark,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: _textPrimaryDark,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: _textPrimaryDark,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: _textSecondaryDark,
    ),
    labelLarge: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: _textPrimaryDark,
    ),
  );

  /// Light theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: _lightColorScheme,
    scaffoldBackgroundColor: _backgroundLight,
    textTheme: _lightTextTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: _surfaceLight,
      elevation: 0,
      iconTheme: IconThemeData(color: _textPrimaryLight),
      titleTextStyle: _lightTextTheme.titleLarge,
    ),
    cardTheme: CardTheme(
      color: _surfaceLight,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryLight,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        textStyle: _lightTextTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _primaryLight,
        side: const BorderSide(color: _primaryLight, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        textStyle: _lightTextTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _primaryLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        textStyle: _lightTextTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _surfaceLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _primaryLight, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _errorLight, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFFE0E0E0),
      thickness: 1,
    ),
  );

  /// Dark theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: _darkColorScheme,
    scaffoldBackgroundColor: _backgroundDark,
    textTheme: _darkTextTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: _surfaceDark,
      elevation: 0,
      iconTheme: IconThemeData(color: _textPrimaryDark),
      titleTextStyle: _darkTextTheme.titleLarge,
    ),
    cardTheme: CardTheme(
      color: _surfaceDark,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryDark,
        foregroundColor: Colors.black,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        textStyle: _darkTextTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _primaryDark,
        side: const BorderSide(color: _primaryDark, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        textStyle: _darkTextTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _primaryDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        textStyle: _darkTextTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _surfaceDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF424242)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _primaryDark, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _errorDark, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFF424242),
      thickness: 1,
    ),
  );
} 